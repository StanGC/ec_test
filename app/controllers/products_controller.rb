class ProductsController < ApplicationController
  before_action :find_product, only: [:show, :add_to_cart]

  def index
    @products = Product.all
  end

  def show
  end

  def add_to_cart
    if !current_cart.products.include?(@product)
      current_cart.add_product_to_cart(@product)
      flash[:notice] = "已成功將 #{@product.title} 加入購物車"
    else
      flash[:warning] = '購物車內已有此商品'
    end

    redirect_back(fallback_location: root_path)
  end

  private

  def find_product
    @product = Product.find(params[:id])
  end
end
