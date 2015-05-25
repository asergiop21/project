class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  #:registerable,

  
  
  devise :database_authenticatable, 
    :recoverable, :rememberable, :trackable, :validatable


  has_many :invoices
  has_many :accounting_records


def self.destroy_logic(id)
     user = User.find(id).update_attribute(:is_deleted, true)
end


  ROLE = %w[admin invitado ]

  def self.current
    Thread.current[:user]
  end
  def self.current=(user)
    Thread.current[:user] = user
  end
end


