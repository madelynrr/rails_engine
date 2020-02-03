require 'rails_helper'

describe "Invoices API" do
  it "can find first instance by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)

    get "/api/v1/invoices/find?id=#{invoice_1.id}"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice['id']).to eq(invoice_1.id)
  end

  it "can find first instance by customer id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)

    get "/api/v1/invoices/find?customer_id=#{invoice_1.customer_id}"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice['id']).to eq(invoice_1.id)
  end

  it "can find first instance by merchant id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)

    get "/api/v1/invoices/find?merchant_id=#{invoice_1.merchant_id}"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice['id']).to eq(invoice_1.id)
  end

  it "can find first instance by status" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: "shipped")

    get "/api/v1/invoices/find?status=#{invoice_1.status}"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice['id']).to eq(invoice_1.id)
  end

  it "can find first by created at" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: "shipped", created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/invoices/find?created_at='2020-02-01 23:36:19 UTC'"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice['id']).to eq(invoice_1.id)
  end

  it "can return first instance of updated at" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: "shipped", updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/invoices/find?updated_at='2020-02-01 23:36:19 UTC'"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice['id']).to eq(invoice_1.id)
  end

  it "can find all instances by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id, status: "shipped", created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/invoices/find_all?id=#{invoice_1.id}"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice['id']).to eq(invoice_1.id)
  end
end
