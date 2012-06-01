class Poll < ActiveRecord::Base

  belongs_to :creator, :class_name => "User"
  belongs_to :recipient, :class_name => "User"  # nil if the Poll is for the whole district
  belongs_to :poll_option_set   # nil if the poll is free-response
  has_many :votes
  
  
  def totals
    results = Vote.find_by_sql(
      "SELECT
        votes.poll_option_set_index as option_index,
        count(poll_option_set_index) as count,
        poll_option_sets.options as options
       FROM votes
       JOIN polls ON votes.poll_id = polls.id
       JOIN poll_option_sets ON polls.poll_option_set_id = poll_option_sets.id
       WHERE
        votes.poll_id = #{self.id}
        AND option_index < poll_option_sets.num_options
       GROUP BY option_index"
    )
    return nil if results.empty?
    options_hash = JSON.parse(results.first.options)
    results.collect{ |result|
      {:option => options_hash[result.option_index.to_s], :count => result.count}
    }
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
  
  
  def self.all_with_map_information
    results = Poll.find_by_sql(
      "SELECT
        polls.*,
        polls.id as poll_id,
        polls.title as poll_title,
        polls.created_at as published_at,
        reps.*,
        reps.id as rep_id,
        reps.title as rep_title,
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
      logger.info poll.first_name
      case poll['zipcode']
        when '49501'
          x = 330
          y = 390
        when '48854'
          x = 420
          y = 430
        else
          x = 460
          y = 460
      end
=begin
      case i
        when 0
          x = 79
          y = 87.5
          creator_info = {
            'type' => 'user',
            'name' => 'Jake Schwartz',
            'title' => 'Michigan Governor'
          }
        when 1
          x = 57.5
          y = 74
          creator_info = {
            'type' => 'rep',
            'name' => 'Gov. Rick Snyder',
            'title' => 'Michigan Governor'
          }
        when 2
          x = 92
          y = 67
          creator_info = {
            'type' => 'rep',
            'name' => 'Rep. Justin Amash',
            'title' => 'Michigan state representative'
          }
        when 3
          x = 90
          y = 50
          creator_info = {
            'type' => 'user',
            'name' => 'Adam Williams'
          }
        else
          x = 10 + i*5
          y = 40 + i*3
          creator_info = {
            'type' => 'user',
            'name' => 'Brad Chick'
          }
        end
      i = 5 if i > 5
=end
      poll['map_x_coord'] = x
      poll['map_y_coord'] = y
      poll['poll_type'] = (poll['chamber'] ? 'rep' : 'user')

    }
  end
  
end
