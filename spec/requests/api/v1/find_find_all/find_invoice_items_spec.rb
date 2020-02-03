require 'rails_helper'

describe "Invoice Items API" do
  it "can find an invoice item by its id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find?id=#{invoice_item_1.id}"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item['id']).to eq(invoice_item_1.id)
  end

  it "can find invoice item by item id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find?item_id=#{item_1.id}"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item['id']).to eq(invoice_item_1.id)
  end

  it "can find invoice item by invoice id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)

    get "/api/v1/invoice_items/find?invoice_id=#{invoice_1.id}"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item['id']).to eq(invoice_item_1.id)
  end

  it "can find invoice item by quantity" do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3)

    get "/api/v1/invoice_items/find?quantity=#{invoice_item_1.quantity}"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item['id']).to eq(invoice_item_1.id)
  end

  it "can find first instance of invoice item by unit price" do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 12345)

    get "/api/v1/invoice_items/find?unit_price=123.45"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item['id']).to eq(invoice_item_1.id)
  end

  it "can find first instance by created_at" do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 12345, created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/invoice_items/find?created_at='2020-02-01 23:36:19 UTC'"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item['id']).to eq(invoice_item_1.id)
  end

  it "can find first instance by updated at" do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id, quantity: 3, unit_price: 12345, updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/invoice_items/find?updated_at='2020-02-01 23:36:19 UTC'"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item['id']).to eq(invoice_item_1.id)
  end
end
