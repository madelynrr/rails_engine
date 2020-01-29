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

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item["id"]).to eq(id)
  end

  it "can return list of items belonging to a merchant" do
    merchant_1 = create(:merchant)
    merchant_2 = create(:merchant)
    items = create_list(:item, 3, merchant_id: merchant_1.id)
    item = create(:item, merchant_id: merchant_2.id)

    get "/api/v1/merchants/#{merchant_1.id}/items"

    items = JSON.parse(response.body)['data']
    require "pry"; binding.pry

    expect(response).to be_successful
    expect(items.count).to eq(3)


  end
end
