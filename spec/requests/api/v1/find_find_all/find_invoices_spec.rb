require 'rails_helper'

describe "Invoices API" do
  it "can find first instance by id" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_1 = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)

    get "/api/v1/invoices/find?id=#{invoice_1.id}"

    invoice = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice['id']).to eq(invoice_1.id)
  end
end
