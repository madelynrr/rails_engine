require 'rails_helper'

RSpec.describe Merchant, type: :model do
  describe "relationships" do
    it {should have_many :items}
    it {should have_many :invoices}
    it {should have_many(:invoice_items).through(:invoices)}
    it {should have_many(:transactions).through(:invoices)}
  end

  describe "class methods" do
    it "#top_by_revenue(x)" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      merchant_4 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      item_3 = create(:item, merchant_id: merchant_3.id)
      item_4 = create(:item, merchant_id: merchant_4.id)
      invoice_1 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
      invoice_3 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_2.id)
      invoice_4 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
      invoice_5 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
      invoice_6 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
      invoice_7 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id)
      invoice_8 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_4.id)
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1)
      invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_2.id, unit_price: 1)
      invoice_item_3 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_3.id, unit_price: 1)
      invoice_item_4 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_4.id, unit_price: 1)
      invoice_item_5 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_5.id, unit_price: 1)
      invoice_item_6 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_6.id, unit_price: 1)
      invoice_item_7 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_7.id, unit_price: 1)
      invoice_item_8 = create(:invoice_item, item_id: item_4.id, invoice_id: invoice_8.id, unit_price: 1)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
      transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
      transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: "failed")
      transaction_5 = create(:transaction, invoice_id: invoice_5.id, result: "failed")
      transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: "failed")
      transaction_7 = create(:transaction, invoice_id: invoice_7.id, result: "failed")
      transaction_8 = create(:transaction, invoice_id: invoice_8.id, result: "failed")

      quantity = 2
      top_merchants = Merchant.top_by_revenue(quantity)

      expect(top_merchants.length).to eq(2)
      expect(top_merchants[0].id).to eq(merchant_1.id)
      expect(top_merchants[1].id).to eq(merchant_2.id)
    end

    it ".fav_customer" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      merchant_1 = create(:merchant)
      invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
      invoice_3 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_1.id)
      invoice_4 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_1.id)
      invoice_5 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_1.id)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
      transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "success")
      transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: "failed")
      transaction_5 = create(:transaction, invoice_id: invoice_5.id, result: "failed")

      expect(merchant_1.fav_customer.id).to eq(customer_1.id)
    end
  end
end
