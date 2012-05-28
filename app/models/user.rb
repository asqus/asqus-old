class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable
  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable,
         :lockable, :timeoutable, :omniauthable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :first_name, :last_name, :admin, :email, :password, :password_confirmation, :remember_me, :zipcode
  has_one :rep
  has_many :polls

  def is_rep?
    !self.rep.nil?
  end

  def is_admin?
    self.admin
  end


end
