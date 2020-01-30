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
end
