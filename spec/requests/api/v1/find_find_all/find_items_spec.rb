require 'rails_helper'

describe "Item API" do
  it "can return first instance by id" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/find?id=#{item_1.id}"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can find first instance by name" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt")

    get "/api/v1/items/find?name=#{item_1.name}"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can find first instance by description" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.")

    get "/api/v1/items/find?description=#{item_1.description}"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can return first instance by unit price" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345)

    get "/api/v1/items/find?unit_price=12345"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can return first instance by merchant id" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345)

    get "/api/v1/items/find?merchant_id=#{item_1.merchant_id}"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can return first instance by created at" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345, created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/items/find?created_at='2020-02-01 23:36:19 UTC'"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can return first instance by updated at" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345, updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/items/find?updated_at='2020-02-01 23:36:19 UTC'"

    item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can find all instances by id" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345, updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/items/find_all?id=#{item_1.id}"

    item = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can return all instances by name" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345, updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/items/find_all?name=#{item_1.name}"

    item = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can return all instances by description" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345, updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/items/find_all?description=#{item_1.description}"

    item = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can return all instances by unit price" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345, updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/items/find_all?unit_price=#{item_1.unit_price}"

    item = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can return all instances by merchant id" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345, updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/items/find_all?merchant_id=#{item_1.merchant_id}"

    item = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "can return all instances by created at" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345, created_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/items/find_all?created_at='2020-02-01 23:36:19 UTC'"

    item = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(item['id']).to eq(item_1.id)
  end

  it "returns all instances by updated at" do
    merchant = create(:merchant)
    item_1 = create(:item, merchant_id: merchant.id, name: "Lightweight Concrete Shirt", description: "The best.", unit_price: 12345, updated_at: "2020-02-01 23:36:19 UTC")

    get "/api/v1/items/find_all?updated_at='2020-02-01 23:36:19 UTC'"

    item = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(item[0]['attributes']['id']).to eq(item_1.id)
  end
end
