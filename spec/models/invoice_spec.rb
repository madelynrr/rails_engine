require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe "relationships" do
    it {should belong_to :customer}
    it {should belong_to :merchant}
    it {should have_many :invoice_items}
    it {should have_many(:items).through(:invoice_items)}
    it {should have_many :transactions}
  end

  describe "class methods" do
    it ".total_revenue by date" do
      customer_1 = create(:customer)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      item_1 = create(:item, merchant_id: merchant_1.id)
      item_2 = create(:item, merchant_id: merchant_2.id)
      item_3 = create(:item, merchant_id: merchant_3.id)
      invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id, created_at: "2019-02-01 23:36:19 UTC")
      invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id, created_at: "2020-02-01 23:36:19 UTC")
      invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id, created_at: "2020-02-01 23:36:19 UTC")
      invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1, quantity: 2)
      invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, unit_price: 1, quantity: 3)
      invoice_item_3 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, unit_price: 1, quantity: 4)
      invoice_item_4 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, unit_price: 1, quantity: 5)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
      transaction_3 = create(:transaction, invoice_id: invoice_2.id, result: "success")
      transaction_4 = create(:transaction, invoice_id: invoice_3.id, result: "failed")

      date = "2020-02-01 23:36:19 UTC"

      expect(Invoice.total_revenue(date)).to eq(7.0)
    end
  end
end
