require 'rails_helper'

describe "Customer API" do
  it "can find customer by id" do
    customer_1 = create(:customer)

    get "/api/v1/customers/find?id=#{customer_1.id}"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
  end

  it "can find first instance by first name" do
    customer_1 = create(:customer, first_name: "Bob")
    create_list(:customer, 3)

    get "/api/v1/customers/find?first_name=#{customer_1.first_name}"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
  end

  it "can find first instance by last name" do
    customer_1 = create(:customer, last_name: "Smith")
    create_list(:customer, 3)

    get "/api/v1/customers/find?last_name=#{customer_1.last_name}"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
  end

  it "can find first instance by created_at" do
    customer_1 = create(:customer, created_at: "2020-02-01 23:36:19 UTC")
    create_list(:customer, 3)

    get "/api/v1/customers/find?created_at='2020-02-01 23:36:19 UTC'"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
  end

  it "can find first instance by updated_at" do
    customer_1 = create(:customer, updated_at: "2020-02-01 23:36:19 UTC")
    create_list(:customer, 3)

    get "/api/v1/customers/find?updated_at='2020-02-01 23:36:19 UTC'"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
  end

  it "can find all customers by id" do
    customer_1 = create(:customer)
    create_list = create_list(:customer, 3)

    get "/api/v1/customers/find_all?id=#{customer_1.id}"

    customer = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
  end

end
