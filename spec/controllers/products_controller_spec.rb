require 'rails_helper'

RSpec.describe ProductsController do
  let(:product) { create(:product) }

  describe 'GET index' do
    let(:product1) { create(:product) }
    let(:product2) { create(:product) }

    before do
      product1
      product2

      get :index
    end

    it 'assigns @products and render' do
      expect(assigns[:products]).to eq([product1, product2])
    end

    it 'render template' do
      expect(response).to render_template('index')
    end
  end

  describe 'GET show' do
    before do
      get :show, params: { id: product.id }
    end

    it 'assigns @product' do
      expect(assigns[:product]).to eq(product)
    end

    it 'render template' do
      expect(response).to render_template('show')
    end
  end

  describe 'POST add_to_cart' do
    let(:current_cart) { subject.current_cart }

    it 'create current_cart' do
      expect{current_cart}.to change{ Cart.count }.from(0).to(1)
    end

    it 'create current_cart but cart is exist' do
      current_cart

      expect(current_cart).to eq(current_cart)
    end

    it 'cart add product' do
      current_cart

      post :add_to_cart, params: { id: product.id }

      expect(flash[:notice]).to match(/已成功將 #{product.title} 加入購物車/)
    end

    it 'redirect to back after current_cart add product' do
      current_cart

      post :add_to_cart, params: { id: product.id }

      expect(response).to redirect_to(root_path)
    end

    it 'cart add product but current_cart has product' do
      current_cart
      current_cart.products << product

      post :add_to_cart, params: { id: product.id }

      expect(flash[:warning]).to match(/購物車內已有此商品/)
    end

    it 'redirect to back after current_cart has product' do
      current_cart
      current_cart.products << product

      post :add_to_cart, params: { id: product.id }

      expect(response).to redirect_to(root_path)
    end
  end
end
