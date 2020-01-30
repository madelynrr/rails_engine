require 'rails_helper'

describe "Invoice Items API" do
  it "can return list of invoice items" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    item_1 = create(:item, merchant_id: merchant_1.id)
    item_2 = create(:item, merchant_id: merchant_2.id)
    invoice_1 = create(:invoice, merchant_id: merchant_1.id, customer_id: customer_1.id)
    invoice_2 = create(:invoice, merchant_id: merchant_2.id, customer_id: customer_2.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice_1.id)
    invoice_item_2 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice_2.id)

    get "/api/v1/invoice_items"

    invoice_items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(invoice_items.count).to eq(2)
    expect(invoice_items[0]['type']).to eq('invoice_item')
    expect(invoice_items[1]['type']).to eq('invoice_item')
  end

  it "can return on invoice item by its id" do
    merchant = create(:merchant)
    customer = create(:customer)
    item = create(:item, merchant_id: merchant.id, unit_price: 12345)
    invoice = create(:invoice, merchant_id: merchant.id, customer_id: customer.id)
    invoice_item_1 = create(:invoice_item, invoice_id: invoice.id, item_id: item.id, unit_price: item.unit_price)

    get "/api/v1/invoice_items/#{invoice_item_1.id}"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item['id']).to eq(invoice_item_1.id)
    expect(invoice_item['unit_price']).to eq("123.45")
  end
end
