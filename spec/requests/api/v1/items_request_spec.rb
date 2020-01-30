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
    item_1 = create(:item, merchant_id: merchant.id)
    create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item_1.id}"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item["id"]).to eq(item_1.id)
  end
end
