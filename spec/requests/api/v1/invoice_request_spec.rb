require 'rails_helper'

describe "Invoice API" do
  it "can return list of invoices" do
    customer = create(:customer)
    merchant = create(:merchant)
    invoice_list = create_list(:invoice, 3, customer_id: customer.id, merchant_id: merchant.id)

    get "/api/v1/invoices"

    invoices = JSON.parse(response.body)['data']

    expect(response).to be_successful
    expect(invoices.count).to eq(3)
    expect(invoices[0]['type']).to eq('invoice')
    expect(invoices[1]['type']).to eq('invoice')
    expect(invoices[2]['type']).to eq('invoice')
  end
end
