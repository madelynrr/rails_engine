require 'rails_helper'

describe "Customer API" do
  it "can find customer by id" do
    customer_1 = create(:customer)

    get "/api/v1/customers/find?id=#{customer_1.id}"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
  end

  it "can find all customers by id" do
    customer_1 = create(:customer)
    create_list = create_list(:customer, 3)

    get "/api/v1/customers/find_all?id=#{customer_1.id}"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['id']).to eq(customer_1.id)
  end


end
