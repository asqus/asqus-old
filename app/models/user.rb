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
  
  # Polls asked BY the user
  has_many :polls_created, :foreign_key => 'creator_id', :class_name => 'Poll'
  # Polls asked TO the user
  has_many :polls_received, :foreign_key => 'recipient_id', :class_name => 'Poll'

  def is_rep?
    !self.rep.nil?
  end

  def is_admin?
    self.admin
  end


end
