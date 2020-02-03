require 'rails_helper'

RSpec.describe Customer, type: :model do
  describe "validations" do
    it {should validate_presence_of :first_name}
    it {should validate_presence_of :last_name}
  end

  describe "relationships" do
    it {should have_many :invoices}
    it {should have_many :transactions}
  end

  describe "instance methods" do
    it ".fav_merchant" do
      customer_1 = create(:customer)
      customer_2 = create(:customer)
      merchant_1 = create(:merchant)
      merchant_2 = create(:merchant)
      merchant_3 = create(:merchant)
      invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
      invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
      invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
      invoice_4 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
      invoice_5 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
      invoice_6 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_2.id)
      invoice_6 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_2.id)
      transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
      transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
      transaction_3 = create(:transaction, invoice_id: invoice_3.id, result: "failed")
      transaction_4 = create(:transaction, invoice_id: invoice_4.id, result: "success")
      transaction_5 = create(:transaction, invoice_id: invoice_5.id, result: "failed")
      transaction_6 = create(:transaction, invoice_id: invoice_6.id, result: "success")
      transaction_7 = create(:transaction, invoice_id: invoice_6.id, result: "success")

      expect(customer_1.fav_merchant).to eq(merchant_1)
      expect(customer_1.fav_merchant.id).to eq(merchant_1.id)
    end
  end
end
