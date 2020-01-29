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
end
