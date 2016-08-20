class AddColumnSubtotalToInvoices < ActiveRecord::Migration
  def change

    add_column :invoices, :subtotal, :decimal, precision: 8 , scale: 2
    add_column :invoices, :discount, :decimal, precision: 8 , scale: 2
    
  
  end
end
