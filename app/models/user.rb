class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :status, :admin, :email, :password, :password_confirmation, :remember_me, :zipcode

  has_one :rep
  has_many :votes, :foreign_key => 'voter_id', :class_name => 'Vote'
  belongs_to :state
  
  # Polls asked BY the user
  has_many :polls_created, :foreign_key => 'creator_id', :class_name => 'Poll'
  # Polls asked TO the user
  has_many :polls_received, :foreign_key => 'recipient_id', :class_name => 'Poll'


  def received_polls
    polls = self.received_local_polls.to_a +
            self.received_state_polls.to_a +
            self.received_national_polls.to_a
    polls.uniq
  end

  def received_local_polls
    Rep.where(:level => 'city', 'users.zipcode' => self.zipcode).
        joins(:user, :polls_created).
        includes(:polls_created).collect{ |r|
          r.polls_created
        }.flatten(1)
  end

  def received_state_polls
    Rep.where('reps.level = "governor" OR reps.level = "state"').
        where('reps.state_id' => self.state_id).
        joins(:user, :polls_created).
        includes(:polls_created).collect{ |r|
          r.polls_created
        }.flatten(1)
  end

  def received_national_polls
    Rep.where(:level => 'national').
        joins(:user, :polls_created).
        includes(:polls_created).collect{ |r|
          r.polls_created
        }.flatten(1)
  end


  def reps
    Rep.find_by_sql(["
      SELECT
        reps.*,
        users.first_name,
        users.last_name,
        users.zipcode,
        users.gender
      FROM reps
      JOIN users ON reps.user_id = users.id
      WHERE users.zipcode = ?
      OR ( (reps.level = 'governor' OR reps.level = 'state')
        AND reps.state_id = ?
      )
      OR reps.level = 'national'
    ", self.zipcode, self.state_id])
  end


  def is_rep?
    !self.rep.nil?
  end

  def is_admin?
    self.admin
  end


end
