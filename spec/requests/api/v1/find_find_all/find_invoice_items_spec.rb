require 'rails_helper'

describe "Invoice Items API" do
  it "can find an invoice item by its id" do
    customer = create(:customer)
    merchant = create(:merchant)
    item = create(:item, merchant_id: merchant.id)
    invoice = create(:invoice, customer_id: customer.id, merchant_id: merchant.id)
    invoice_item_1 = create(:invoice_item, item_id: item.id, invoice_id: invoice.id)

    get "/api/v1/invoice_items/find?id=#{invoice_item_1.id}"

    invoice_item = JSON.parse(response.body)['data']['attributes']

    expect(response).to be_successful
    expect(invoice_item['id']).to eq(invoice_item_1.id)
  end
end
