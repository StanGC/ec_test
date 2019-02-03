class AddProductIdToProductLists < ActiveRecord::Migration[5.2]
  def change
    add_column :product_lists, :product_id, :integer
  end
end
