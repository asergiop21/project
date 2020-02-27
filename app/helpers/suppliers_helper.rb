module SuppliersHelper

  def suppliers_for_select
    Supplier.all.order(:name)
  end
end
