require 'rails_helper'

RSpec.describe CartItemsController do
  let(:cart_item) { create(:cart_item) }
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:user)

    cart_item
    session[:cart_id] = cart_item.cart.id
  end

  describe 'PUT update' do
    it 'assign @cart_item' do
      put :update , params: { id: cart_item.product_id, cart_item: { quantity: 1 } }

      expect(assigns[:cart_item]).to eq(cart_item)
    end

    it 'changes value success' do
      put :update , params: { id: cart_item.product_id, cart_item: { quantity: 3 } }

      expect(assigns[:cart_item].quantity).to eq(3)
    end

    it 'redirects to carts_path after changes value success' do
      put :update , params: { id: cart_item.product_id, cart_item: { quantity: 3 } }

      expect(response).to redirect_to carts_path
    end

    it 'changes value fail' do
      put :update , params: { id: cart_item.product_id, cart_item: { quantity: 6 } }

      expect(flash[:warning]).to match(/數量不足/)
    end

    it 'redirects to carts_path after changes value fail' do
      put :update , params: { id: cart_item.product_id, cart_item: { quantity: 6 } }

      expect(response).to redirect_to carts_path
    end
  end

  describe 'DELTE destroy' do
    before do
      cart_item
      delete :destroy, params: { id: cart_item.product_id }
    end

    it 'assigns @cart_item' do
      expect(assigns[:cart_item]).to eq(cart_item)
    end

    it 'destroy cart_item' do
      expect {cart_item}.to change { CartItem.count }.by(0)
    end

    it 'redirect carts_path after destroy cart_item' do
      expect(response).to redirect_to(root_path)
    end
  end
end
