require 'rails_helper'

RSpec.describe OrdersController do
  before(:each) do
    request.env['devise.mapping'] = Devise.mappings[:user]
    sign_in FactoryGirl.create(:user)
  end

  describe 'POST create' do
    let(:order) { create(:order) }
    before do
      order
      subject.current_user.id = order.user_id
    end

    context 'when order have a billing_name ' do
      it 'create a new order record' do
        expect{
          post :create, params: { order: { billing_name: 'test1', billing_address: 'yy road', shipping_name: 'test1', shipping_address: 'yy road' } }
        }.to change{Order.count}.by(1)
      end

      it 'redirect to orders_path' do
        post :create, params: { order: { billing_name: 'test1', billing_address: 'yy road', shipping_name: 'test1', shipping_address: 'yy road' } }

        expect(response).to redirect_to order_path(Order.last)
      end
    end

    context 'when order doesnt have a billing_name' do
      it 'doesnt create a record' do
        expect{ post :create, params: { order: { billing_address: 'yy road', shipping_name: 'test1', shipping_address: 'yy road' } } }.to change{Order.count}.by(0)
      end

      it 'render new template' do
        post :create, params: { order: { billing_address: 'yy road', shipping_name: 'test1', shipping_address: 'yy road' } }

        expect(response).to render_template('carts/checkout')
      end
    end
  end

  describe 'GET show' do
    let(:order) { create(:order) }
    before do
      order
      subject.current_user.id = order.user_id
      get :show, params: { id: order }
    end

    it 'assigns @order' do
      expect(assigns[:order]).to eq(order)
    end

    it 'render template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET edit' do
    let(:order) { create(:order) }
    before do
      order
      subject.current_user.id = order.user_id
      get :edit, params: { id: order.token }
    end

    it 'assign order' do
      expect(assigns[:order]).to eq(order)
    end

    it 'render template' do
      expect(response).to render_template('edit')
    end
  end

  describe 'PUT update' do
    let(:order) { create(:order) }
    let(:product_list) { create(:product_list) }
    before do
      order
      product_list
      subject.current_user.id = order.user_id
    end

    it 'assign @order' do
      put :update , params: { id: product_list.order.token,
                              order: {
                                billing_name: 'test1',
                                billing_address: 'yy road',
                                shipping_name: 'test1',
                                shipping_address: 'yy road',
                                product_lists_attributes: { id: product_list.id, product_name: 'zzz', product_price: 500, quantity: 10 }
                              }
                            }

      expect(assigns[:order]).to eq(product_list.order)
    end

    it 'changes value success' do
      put :update , params: { id: product_list.order.token,
                              order: {
                                billing_name: 'test1',
                                billing_address: 'yy road',
                                shipping_name: 'test1',
                                shipping_address: 'yy road',
                                product_lists_attributes: { id: product_list.id, product_name: 'zzz', product_price: 500, quantity: 10 }
                              }
                            }

      expect(assigns[:order].billing_name).to eq('test1')
    end

    it 'redirects to order_path after changes value success' do
      put :update , params: { id: product_list.order.token,
                              order: {
                                billing_name: 'test1',
                                billing_address: 'yy road',
                                shipping_name: 'test1',
                                shipping_address: 'yy road',
                                product_lists_attributes: { id: product_list.id, product_name: 'zzz', product_price: 500, quantity: 10 }
                              }
                            }

      expect(response).to redirect_to order_path(assigns[:order])
    end

    it 'render to order_path after changes value fail' do
      put :update , params: { id: product_list.order.token,
                              order: {
                                billing_name: nil,
                                billing_address: 'yy road',
                                shipping_name: 'test1',
                                shipping_address: 'yy road',
                                product_lists_attributes: { id: product_list.id, product_name: 'zzz', product_price: 500, quantity: 10 }
                              }
                            }

      expect(response).to render_template('edit')
    end
  end
end
