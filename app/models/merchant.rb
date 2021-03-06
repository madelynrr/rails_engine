class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def self.top_by_revenue(quantity)
    Merchant.joins(invoices: [:invoice_items, :transactions])
    .select("merchants.*, SUM((invoice_items.quantity) * (invoice_items.unit_price)) AS total_revenue")
    .group("merchants.id")
    .merge(Transaction.successful)
    .order(total_revenue: :desc)
    .limit(quantity)
  end

  def fav_customer
    Customer.joins(invoices: :transactions)
    .select("customers.*, COUNT(transactions.id) AS total_transactions")
    .group("customers.id")
    .merge(Transaction.successful)
    .where(invoices: {merchant_id: "#{self.id}"})
    .order(total_transactions: :desc)
    .limit(1)
    .first
  end

end
