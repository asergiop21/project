class Customer < ActiveRecord::Base

  has_many :invoices

 scope :search, ->(data){where("name ilike ? or lastname ilike ?", "%#{data}%", "%#{data}%")}




end
