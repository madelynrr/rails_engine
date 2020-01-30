require 'rails_helper'

describe "Items API" do
  it "send a list of items" do
    merchant = create(:merchant)
    create_list(:item, 3, merchant_id: merchant.id)

    get "/api/v1/items"

    items = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(items.count).to eq(3)
    expect(items[0]['type']).to eq("items")
    expect(items[1]['type']).to eq("items")
    expect(items[2]['type']).to eq("items")
  end
end
