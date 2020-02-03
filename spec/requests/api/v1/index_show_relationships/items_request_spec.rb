require 'rails_helper'

describe "Items API" do
  it "send a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items"

    items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(items.count).to eq(3)
    expect(items[0]['type']).to eq("item")
    expect(items[1]['type']).to eq("item")
    expect(items[2]['type']).to eq("item")
  end

  it "sends a single item by its id" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, unit_price: 12345)
    create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item_1.id}"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item["id"]).to eq(item_1.id)
    expect(item["unit_price"]).to eq("123.45")
  end

  it "can return collection of associated invoice items" do
    customer = create(:customer)
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)
    item_2 = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item_1 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
    invoice_item_2 = create(:invoice_item, item_id: item_1.id, invoice_id: invoice.id)
    invoice_item_3 = create(:invoice_item, item_id: item_2.id, invoice_id: invoice.id)

    get "/api/v1/items/#{item_1.id}/invoice_items"

    invoice_items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(invoice_items.count).to eq(2)
    expect(invoice_items[0]['attributes']['id']).to eq(invoice_item_1.id)
    expect(invoice_items[1]['attributes']['id']).to eq(invoice_item_2.id)
  end
end
