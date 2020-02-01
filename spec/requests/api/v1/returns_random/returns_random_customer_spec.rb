require 'rails_helper'

describe "Customer API" do
  it "returns a random customer" do
    customer_1 = create(:customer)
    customer_2 = create(:customer)
    customer_3 = create(:customer)
    ids = [customer_1.id, customer_2.id, customer_3.id]

    get "/api/v1/customers/random"

    customer = JSON.parse(response.body)['data'].first['attributes']

    expect(response).to be_successful
    expect(ids.include?(customer['id'])).to be(true)
  end
end
