require 'rails_helper'

describe "Customer API" do
  it "sends a list of customers" do
    create_list(:customer, 3)

    get "/api/v1/customers"

    customers = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(customers.count).to eq(3)
    expect(customers[0]['type']).to eq('customer')
    expect(customers[1]['type']).to eq('customer')
    expect(customers[2]['type']).to eq('customer')
  end

  it "sends single customer by id" do
    customer_1 = create(:customer)

    get "/api/v1/customers/#{customer_1.id}"

    customer = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(customer['first_name']).to eq(customer_1.first_name)
    expect(customer['last_name']).to eq(customer_1.last_name)
  end
end
