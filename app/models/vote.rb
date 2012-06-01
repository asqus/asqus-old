class Vote < ActiveRecord::Base

  belongs_to :poll
  belongs_to :voter, :class_name => 'User'
  
  
  validates_presence_of :poll_option_set_index, :message => 'You must select an option for this poll'
  validates :voter_id,
    :uniqueness => {
      :scope => :poll_id,
      :allow_nil => true,
      :message => 'You have already voted for this poll'
    }


end
