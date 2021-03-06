class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  before_action :find_order, only: [:show, :edit, :update]
  before_action :check_order_is_own, only: [:show, :edit]

  def create
    order = Order.new(order_params)
    order.user = current_user
    order.total_price = current_cart.total_price

    if order.save
      current_cart.cart_items.each do |cart_item|
        product_list = ProductList.new
        product_list.product_id = cart_item.product.id
        product_list.order = order
        product_list.product_name = cart_item.product.title
        product_list.product_price = cart_item.product.price
        product_list.quantity = cart_item.quantity
        product_list.save
      end

      redirect_to order_path(order)
    else
      render 'carts/checkout'
    end
  end

  def show
    @product_lists = @order.product_lists
  end

  def edit
  end

  def update
    if @order.update(order_params)
      redirect_to order_path(@order)
    else
      render :edit
    end
  end

  def get_product
    product = Product.find_by(title: params[:product_title]) if params[:product_title].present?

    if request.xhr?
      respond_to do |format|
        format.json {
          render json: { product: product }
        }
      end
    end
  end

  private

  def find_order
    @order = Order.find_by_token(params[:id])
  end

  def check_order_is_own
    if current_user.id != @order.user_id
      flash[:alert] = '請重新選擇訂單'
      redirect_to account_orders_path
    end
  end

  def order_params
    params.require(:order).permit(:billing_name, :billing_address, :shipping_name, :shipping_address,
                                  product_lists_attributes: [:id, :product_name, :product_price, :quantity])
  end
end
