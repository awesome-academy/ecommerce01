class AddDescriptionAndPayMethodToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :description, :string
    add_column :orders, :pay_method, :string
  end
end
