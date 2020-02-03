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

  it "returns top variable number of merchants with top revenue" do
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

    get "/api/v1/merchants/most_revenue?quantity=2"

    top_merchants = JSON.parse(response.body)['data']

    expect(top_merchants.count).to eq(2)
    expect(top_merchants[0]['attributes']['id']).to eq(merchant_1.id)
    expect(top_merchants[1]['attributes']['id']).to eq(merchant_2.id)
  end

  # it "returns total revenue for a given date across all merchants" do
  #   skip
  #   customer_1 = create(:customer)
  #   merchant_1 = create(:merchant)
  #   merchant_2 = create(:merchant)
  #   merchant_3 = create(:merchant)
  #   item_1 = create(:item, merchant_id: merchant_1.id)
  #   item_2 = create(:item, merchant_id: merchant_2.id)
  #   item_3 = create(:item, merchant_id: merchant_3.id)
  #   invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id, created_at: "2019-02-01 23:36:19 UTC")
  #   invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id, created_at: "2020-02-01 23:36:19 UTC")
  #   invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_3.id, created_at: "2020-02-01 23:36:19 UTC")
  #   invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, unit_price: 1, quantity: 2)
  #   invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, unit_price: 1, quantity: 3)
  #   invoice_item_3 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id, unit_price: 1, quantity: 4)
  #   invoice_item_4 = create(:invoice_item, item_id: item_3.id, invoice_id: invoice_3.id, unit_price: 1, quantity: 5)
  #   transaction_1 = create(:transaction, invoice_id: invoice_1.id, result: "success")
  #   transaction_2 = create(:transaction, invoice_id: invoice_2.id, result: "success")
  #   transaction_3 = create(:transaction, invoice_id: invoice_2.id, result: "success")
  #   transaction_4 = create(:transaction, invoice_id: invoice_3.id, result: "failed")
  #
  #   get "/api/v1/merchants/revenue?date=#{invoice_2.created_at}"
  #
  #   revenue = JSON.parse(response.body)
  #
  #   expect(revenue).to eq(7.0)
  # end

  it "returns customer with most successful transactions by merchant" do
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

    get "/api/v1/merchants/#{merchant_1.id}/favorite_customer"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
  end
end
