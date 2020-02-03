require 'rails_helper'

describe "Merchants API" do
  it "returns first instance by id" do
    merchant_1 = create(:merchant)

    get "/api/v1/merchants/find?id=#{merchant_1.id}"

    merchant = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(merchant['id']).to eq(merchant_1.id)
  end

  it "can return first instance by name" do
    merchant_1 = create(:merchant, name: "Meg's Bike Shop")

    get "/api/v1/merchants/find?name=#{merchant_1.name}"

    merchant = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(merchant['id']).to eq(merchant_1.id)
  end

  it "returns first instance by created at" do
    merchant_1 = create(:merchant, name: "Meg's Bike Shop", created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/merchants/find?created_at='2020-02-01 23:36:19 UTC'"

    merchant = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(merchant['id']).to eq(merchant_1.id)
  end

  it "returns first instance by updated at" do
    merchant_1 = create(:merchant, name: "Meg's Bike Shop", updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/merchants/find?updated_at='2020-02-01 23:36:19 UTC'"

    merchant = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(merchant['id']).to eq(merchant_1.id)
  end

  it "can return all instances by id" do
    merchant_1 = create(:merchant, name: "Meg's Bike Shop", updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/merchants/find_all?id=#{merchant_1.id}"

    merchant = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(merchant['id']).to eq(merchant_1.id)
  end

  it "can return all instances by name" do
    merchant_1 = create(:merchant, name: "Meg's Bike Shop", updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/merchants/find_all?name=#{merchant_1.name}"

    merchant = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(merchant['id']).to eq(merchant_1.id)
  end

  it "can return all instances by created at" do
    merchant_1 = create(:merchant, name: "Meg's Bike Shop", created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/merchants/find_all?created_at='2020-02-01 23:36:19 UTC'"

    merchant = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(merchant['id']).to eq(merchant_1.id)
  end

  it "can return all instances of updated at" do
    merchant_1 = create(:merchant, name: "Meg's Bike Shop", updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/merchants/find_all?updated_at='2020-02-01 23:36:19 UTC'"

    merchant = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(merchant['id']).to eq(merchant_1.id)
  end
end
