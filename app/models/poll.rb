class Poll < ActiveRecord::Base

  belongs_to :creator, :class_name => "User"
  belongs_to :recipient, :class_name => "User"  # nil if the Poll is for the whole district
  belongs_to :poll_option_set   # nil if the poll is free-response
  has_many :votes
  
  validates_presence_of :creator_id
  
  
  def totals(poll = nil)
    poll ||= self
    results = if Rails.env != 'development'
                Rails.cache.read("Poll_#{poll.id}.totals")
              else
                nil
              end
    return results if results
    results = Vote.find_by_sql(
      "SELECT
        votes.poll_option_set_index,
        count(votes.poll_option_set_index) AS count
       FROM votes
       JOIN polls ON votes.poll_id = polls.id
       JOIN poll_option_sets ON polls.poll_option_set_id = poll_option_sets.id
       WHERE
        votes.poll_id = #{poll.id}
        AND votes.poll_option_set_index < poll_option_sets.num_options
       GROUP BY votes.poll_option_set_index"
    )
    return nil if results.empty?
    options_hash = poll.options
    results.collect!{ |result|
      {:option => options_hash[result.poll_option_set_index.to_s], :count => result.count}
    }
    Rails.cache.write("Poll_#{poll.id}.totals", results, :expires_in => 5.minutes) if Rails.env != 'development'
    return results
  end
  
  
  def votes_per_day(poll = nil)
  # Returns data of the number of votes per day for the current object. Called like:
  #   @poll.votes_per_day
  #
  # This function returns  an array of data points like the following:
  #   [ [1287903600000, 79], [1287990000000, 25], [1288076400000, 61] ]
  # The first number in each element is Unix time in milliseconds.
  #   The second number is the number of tweets that occured on that day for
  #   the given poll.
  # Returns nil if there are no results.
  #
    poll ||= self
    votes = Vote.find_by_sql(
     "SELECT
        count(date(votes.created_at)) as count_for_day,
        date(votes.created_at) as day
      FROM votes
      WHERE votes.poll_id = #{ poll.id }
      GROUP BY day"
    )
    data_points = votes.collect{ |vote|
      [Time.parse(vote.day).to_i*1000, vote.count_for_day.to_i]
    }

    (data_points.length == 0) ? nil : data_points
  end
  
  
  def votes_per_day_as_string
  # Returns a Javascript-ready version of votes_per_day, as if "inspect" was called on its output.
  # Returns a string like:
  #   "[ [1287903600, 79], [1287990000, 25], [1288076400, 61] ]"
  #
    data_points = self.votes_per_day
    return nil unless data_points

    output = '['
    data_points.each_with_index{ |point, i|
      output << ((i == 0) ? ' [' : ', [' ) << point[0].to_s << ', ' << point[1].to_s << ']'
    }
    output << ' ]'
  end

  
  def options
    if self.poll_option_set
      JSON.parse(self.poll_option_set.options)
    else
      {}
    end
  end


  def vote_for(option_index, voter_id)
    vote = Vote.create({
      :poll_id => self.id,
      :voter_id => voter_id,
      :poll_option_set_index => option_index.to_i
    })
  end
  
  
  def self.all_with_details
    results = Poll.find_by_sql(
      "SELECT
        polls.*,
        polls.id as poll_id,
        polls.title as poll_title,
        polls.created_at as published_at,
        reps.id as rep_id,
        reps.title as rep_title,
        reps.district as rep_district,
        reps.chamber as rep_chamber,
        reps.level as rep_level,
        users.first_name,
        users.last_name,
        users.zipcode,
        users.id as user_id,
        poll_option_sets.options_type,
        poll_option_sets.num_options,
        poll_option_sets.options
      FROM polls
      LEFT JOIN users ON users.id = polls.creator_id
      LEFT JOIN reps ON reps.user_id = users.id
      LEFT JOIN poll_option_sets ON poll_option_sets.id = polls.poll_option_set_id
      WHERE polls.published = #{ActiveRecord::Base.connection.quoted_true}"
    )
    results.each_with_index { |poll, i|
      case poll['zipcode']
        when '49501'  # Grand Rapids
          x = 210
          y = 280
        when '48854'
          x = 277
          y = 307
        else
          x = 305
          y = 325
      end
      poll['map_x_coord'] = x
      poll['map_y_coord'] = y
      poll['poll_type'] = (poll.creator && poll.creator.rep) ? 'rep' : 'user'
      poll['totals'] = poll.totals
      poll['votes_per_day'] = poll.votes_per_day_as_string
    }
  end
  
end
