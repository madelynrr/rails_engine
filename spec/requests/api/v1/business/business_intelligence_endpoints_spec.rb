require 'rails_helper'

describe "Business Intelligence API" do
  it "can return a merchant where a customer has had most successful transactions" do
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

    get "/api/v1/customers/#{customer_1.id}/favorite_merchant"

    favorite_merchant = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(favorite_merchant['attributes']['id']).to eq(merchant_1.id)
  end
end
