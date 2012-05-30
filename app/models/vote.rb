class Vote < ActiveRecord::Base

  belongs_to :poll
  belongs_to :voter, :class_name => 'User'

end
