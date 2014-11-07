class Customer < ActiveRecord::Base

  has_many :invoices
  has_many :current_accounts
 scope :search, ->(data){where("name ilike ? or lastname ilike ?", "%#{data}%", "%#{data}%")}


 def display_autocomplete
   self.name + ", " +  self.lastname
 end



end
