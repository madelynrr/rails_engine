require 'rails_helper'

describe "Customer API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    customers = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(customers.count).to eq(3)
    expect(customers[0]['type']).to eq('customer')
    expect(customers[1]['type']).to eq('customer')
    expect(customers[2]['type']).to eq('customer')
  end

  it "sends single customer by id" do
    customer_1 = create(:customer)

    get "/api/v1/customers/#{customer_1.id}"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['first_name']).to eq(customer_1.first_name)
    expect(customer['last_name']).to eq(customer_1.last_name)
  end

  it "returns list of invoices associated with a customer" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
    invoice_3 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_2.id)
    invoice_4 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_1.id)

    get "/api/v1/customers/#{customer_1.id}/invoices"

    invoices = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(invoices.count).to eq(2)
    expect(invoices[0]['attributes']['customer_id']).to eq(customer_1.id)
    expect(invoices[1]['attributes']['customer_id']).to eq(customer_1.id)
  end

  it "returns all transactions by customer" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    invoice_2 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_1.id)
    invoice_3 = create(:invoice, customer_id: customer_1.id, merchant_id: merchant_2.id)
    invoice_4 = create(:invoice, customer_id: customer_2.id, merchant_id: merchant_2.id)
    transaction_1 = create(:transaction, invoice_id: invoice_1.id)
    transaction_2 = create(:transaction, invoice_id: invoice_2.id)
    transaction_3 = create(:transaction, invoice_id: invoice_3.id)
    transaction_4 = create(:transaction, invoice_id: invoice_4.id)

    get "/api/v1/customers/#{customer_1.id}/transactions"

    transactions = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(transactions.count).to be(3)
    expect(transactions[0]['type']).to eq("transaction")
    expect(transactions[1]['type']).to eq("transaction")
    expect(transactions[2]['type']).to eq("transaction")
  end
end
