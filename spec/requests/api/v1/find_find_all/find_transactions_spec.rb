require 'rails_helper'

describe "Transactions API" do
  it "can return first instance by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/find?id=#{transaction_1.id}"

    transaction = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "can find first instance by invoice id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id)

    get "/api/v1/transactions/find?invoice_id=#{transaction_1.invoice_id}"

    transaction = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "can return first instance by credit card number" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id, credit_card_number: "1234123412341234")

    get "/api/v1/transactions/find?credit_card_number=#{transaction_1.credit_card_number}"

    transaction = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "can return first instance by result" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id, credit_card_number: "1234123412341234", result: "success")

    get "/api/v1/transactions/find?result=#{transaction_1.result}"

    transaction = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "can return first instance by created at" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id, credit_card_number: "1234123412341234", result: "success", created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/transactions/find?created_at='2020-02-01 23:36:19 UTC'"

    transaction = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "returns first instance by updated at" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id, credit_card_number: "1234123412341234", result: "success", updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/transactions/find?updated_at='2020-02-01 23:36:19 UTC'"

    transaction = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "returns all instances by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id, credit_card_number: "1234123412341234", result: "success", created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/transactions/find_all?id=#{transaction_1.id}"

    transaction = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "returns all instances by invoice id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id, credit_card_number: "1234123412341234", result: "success", created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/transactions/find_all?invoice_id=#{transaction_1.invoice_id}"

    transaction = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "returns all instances by credit card number" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id, credit_card_number: "1234123412341234", result: "success", created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/transactions/find_all?credit_card_number=#{transaction_1.credit_card_number}"

    transaction = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "returns all instances by result" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id, credit_card_number: "1234123412341234", result: "success", created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/transactions/find_all?result=#{transaction_1.result}"

    transaction = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "can return all instances by created at" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id, credit_card_number: "1234123412341234", result: "success", created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/transactions/find_all?created_at='2020-02-01 23:36:19 UTC'"

    transaction = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end

  it "can return all instances by updated at" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    transaction_1 = create(:transaction, invoice_id: invoice.id, credit_card_number: "1234123412341234", result: "success", updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/transactions/find_all?updated_at='2020-02-01 23:36:19 UTC'"

    transaction = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(transaction['id']).to eq(transaction_1.id)
  end
end
