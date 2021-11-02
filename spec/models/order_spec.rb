require 'rails_helper'

RSpec.describe Order, type: :model do
  let(:book) { create(:book) }
  let(:order) { create(:order) }
  
  it { is_expected.to delegate_method(:clear).to(:order_books) }
  it { is_expected.to delegate_method(:empty?).to(:order_books) }
  
  context 'validations' do
    it { is_expected.to validate_presence_of(:state) }
  end
  
  context 'associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:coupon) }
    it { is_expected.to belong_to(:credit_card) }
    it { is_expected.to belong_to(:billing_address) }
    it { is_expected.to belong_to(:shipping_address) }
    it { is_expected.to belong_to(:shipment) }
    it { is_expected.to have_many(:order_books) }
  end
  
  describe '#set_completed_time_and_ref' do
    it 'updates completed_at' do
      order.set_time_and_ref
      expect(order.completed_at).not_to be_nil
    end
  
    it 'calls after change order state to in_queue' do
      expect(order).to receive(:set_time_and_ref)
      order.create_order
    end
  end
  
  describe '#add_to_order' do
    context "book didn't add to the order" do
      it 'creates a new order_books' do
        expect { order.add_to_order(book) }.to change(order.order_books, :count).by(1)
      end
    end
    
    context 'book already added to the order' do
      let!(:order_book) { FactoryGirl.create(:order_book, book: book, order: order) }  
      
      it 'dont create new order_book' do
        expect { order.add_to_order(book) }.to_not change(order.order_books, :count)
      end
            
      it 'updates the quantity for order_item' do
        order.add_to_order(book)
        order_book.reload
        expect(order_book.quantity).to eq(2)
      end
    end
  end
  
  describe '#set_coupon' do
    let(:order) { build(:order, code: 'QWERTY') }
    
    context 'valid coupon code' do
      it 'assigns coupon to order' do
        coupon = FactoryGirl.create(:coupon)
        order.set_coupon
        expect(order.coupon).to eq(coupon)
      end
      
      it 'calls before validations if code present' do
        expect(order).to receive(:set_coupon)
        order.valid?
      end 
      
      it "doesn't calls before validations if code absent" do
        order = build(:order)
        expect(order).to_not receive(:set_coupon)
        order.valid?
      end
    end
    
    context 'invalid coupon code' do
      before { order.set_coupon }
      
      it 'not attach coupon to the order' do
        expect(order.coupon).to be_nil
      end
      
      it 'add errors to base' do
        expect(order.errors[:base][0]).to eq('Invalid coupon code')
      end
    end
  end
  
  describe '#update_order' do
    it 'calculate and updates order subtotal' do
      create_list(:order_book, 3, price: 10, order: order)
      order.update_order
      expect(order.subtotal).to eq(30)
    end
    
    it 'calculate and updates order total' do
      create_list(:order_book, 3, price: 10, order: order)
      order.update_order
      expect(order.total).to eq(30)
    end
    
     it 'calculate and updates order shipment_total' do
      shipment = FactoryGirl.create(:shipment)
      order = FactoryGirl.create(:order, shipment: shipment)
      order.update_order
      expect(order.shipment_total).to eq(15)
    end
  end
end
