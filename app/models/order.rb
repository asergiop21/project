class Order < ActiveRecord::Base

  belongs_to :invoice
  belongs_to :article
end
