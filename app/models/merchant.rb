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
    
  end

end
