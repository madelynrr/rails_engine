require 'csv'

namespace :import do

  task customers: :environment do
    csv = CSV.foreach("./db/sales_engine/data/customers.csv", :headers => true)
    csv.each do |row|
      Customer.create!(row.to_hash)
    end
  end

  task merchants: :environment do
    csv = CSV.foreach("./db/sales_engine/data/merchants.csv", :headers => true)
    csv.each do |row|
      Merchant.create!(row.to_hash)
    end
  end

  task items: :environment do
    csv = CSV.foreach("./db/sales_engine/data/items.csv", :headers => true)
    csv.each do |row|
      Item.create!(row.to_hash)
    end
  end

  task invoices: :environment do
    csv = CSV.foreach("./db/sales_engine/data/invoices.csv", :headers => true)
    csv.each do |row|
      Invoice.create!(row.to_hash)
    end
  end

  task transactions: :environment do
    csv = CSV.foreach("./db/sales_engine/data/transactions.csv", :headers => true)
    csv.each do |row|
      Transaction.create!(row.to_hash)
    end
  end

  task invoice_items: :environment do
    csv = CSV.foreach("./db/sales_engine/data/invoice_items.csv", :headers => true)
    csv.each do |row|
      InvoiceItem.create!(row.to_hash)
    end
  end
end
