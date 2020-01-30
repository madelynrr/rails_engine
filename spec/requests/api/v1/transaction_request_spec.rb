require 'rails_helper'

describe "Transactions API" do
  it "can return list of transactions" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_2.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    trandaction_2 = create(:transaction, invoice_id: invoice_2.id)

    get "/api/v1/transactions"

    transactions = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(transactions.count).to be(2)
    expect(transactions[0]['type']).to eq('transaction')
    expect(transactions[1]['type']).to eq('transaction')
  end

  it "can find a transaction by its id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/#{transaction_1.id}"

    transaction = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end
end
