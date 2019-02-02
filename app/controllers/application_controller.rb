class ApplicationController < ActionController::Base
  helper_method :current_cart

  def current_cart
    @current_cart ||= find_cart
  end

  private

  def find_cart
    cart = Cart.find_by(id: session[:cart_id])
    cart = Cart.create if cart.blank?
    session[:cart_id] = cart.id

    return cart
  end
end
