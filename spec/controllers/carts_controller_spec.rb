require 'rails_helper'

RSpec.describe CartsController do
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:user)
  end

  describe 'DELETE clean' do
    let(:current_cart) { subject.current_cart }

    before do
      current_cart
      delete :clean
    end

    it 'clean cart' do
      product = create(:product)

      current_cart.products << product

      expect{current_cart.products}.to change{ Cart.count }.by(0)
    end

    it 'redirect carts_path after clean cart' do
      expect(response).to redirect_to(carts_path)
    end
  end

  describe 'GET checkout' do
    let(:order) { build(:order) }

    before do
      order
      get :checkout
    end

    it 'assign @order' do
      expect(assigns(:order)).to be_a_new(Order)
    end

    it 'render template' do
      expect(response).to render_template('checkout')
    end
  end
end
