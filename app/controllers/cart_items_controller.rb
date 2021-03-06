class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_cart_item_and_product

  def update
    if @product.quantity >= cart_item_params[:quantity].to_i
      @cart_item.update(cart_item_params)
      flash[:notice] = "成功將 #{@product.title} 數量更改為 #{@cart_item.quantity}"
    else
      flash[:warning] = '數量不足'
    end

    redirect_to carts_path
  end

  def destroy
    @cart_item.destroy

    flash[:warning] = "成功將 #{@product.title} 從購物車刪除"
    redirect_back(fallback_location: root_path)
  end

  private

  def find_cart_item_and_product
    @cart_item = current_cart.cart_items.find_by(product_id: params[:id])
    @product = @cart_item.product
  end

  def cart_item_params
    params.require(:cart_item).permit(:quantity)
  end
end
