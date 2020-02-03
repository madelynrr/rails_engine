require 'rails_helper'

describe "Merchants API" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get "/api/v1/merchants"
    merchants = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(merchants.count).to eq(3)
    expect(merchants.first['type']).to eq("merchant")
  end

  it "sends a single merchant by its id" do
    id = create(:merchant).id

    get "/api/v1/merchants/#{id}"

    merchant = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(merchant["id"]).to eq(id)
  end

  it "can return list of items belonging to a merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    items = create_list(:item, 3, merchant_id: merchant_1.id)
    item = create(:item, merchant_id: merchant_2.id)

    get "/api/v1/merchants/#{merchant_1.id}/items"

    items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(items.count).to eq(3)
    item_1 = Item.find(items[0]['attributes']['id'])
    expect(item_1.merchant).to eq(merchant_1)
    item_2 = Item.find(items[1]['attributes']['id'])
    expect(item_2.merchant).to eq(merchant_1)
    item_3 = Item.find(items[2]['attributes']['id'])
    expect(item_3.merchant).to eq(merchant_1)
  end

  it "can return collection of invoices associated with a merchant" do
    customer = create(:customer)
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_1.id)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant_2.id)

    get "/api/v1/merchants/#{merchant_1.id}/invoices"

    invoices = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(invoices.count).to eq(3)
    expect(invoices[0]['attributes']['merchant_id']).to eq(merchant_1.id)
    expect(invoices[1]['attributes']['merchant_id']).to eq(merchant_1.id)
    expect(invoices[2]['attributes']['merchant_id']).to eq(merchant_1.id)
  end

end
