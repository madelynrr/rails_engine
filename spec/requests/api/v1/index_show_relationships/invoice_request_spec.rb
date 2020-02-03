require 'rails_helper'

describe "Invoice API" do
  it "can return list of invoices" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_list = create_list(:invoice, 3, customer_id: customer.id, merchant_id: merchant.id)

    get "/api/v1/invoices"

    invoices = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(invoices.count).to eq(3)
    expect(invoices[0]['type']).to eq('invoice')
    expect(invoices[1]['type']).to eq('invoice')
    expect(invoices[2]['type']).to eq('invoice')
  end

  it "can return single invoice by id" do
    merchant = create(:merchant)
    customer = create(:customer)
    invoice_1 = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)

    get "/api/v1/invoices/#{invoice_1.id}"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice['id']).to eq(invoice_1.id)
  end

  it "can return collection of transactions by invoice" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_2 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_1.id)
    transaction_3 = create(:transaction, invoice_id: invoice_2.id)

    get "/api/v1/invoices/#{invoice_1.id}/transactions"

    transactions = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(transactions.count).to eq(2)
    expect(transactions[0]['attributes']['invoice_id']).to eq(invoice_1.id)
    expect(transactions[1]['attributes']['invoice_id']).to eq(invoice_1.id)
  end
end
