class Customer < ApplicationRecord
  validates_presence_of :first_name
  validates_presence_of :last_name

  has_many :invoices
  has_many :transactions, through: :invoices

  def fav_merchant
    x = Merchant.joins(invoices: :transactions)
    .select("merchants.*, COUNT(transactions.id) AS total_transactions")
    .group("merchants.id")
    .where(transactions: {result: "success"})
    .where(invoices: {customer_id: "#{self.id}"})
    .order(total_transactions: :desc)
    .limit(1)
    .first
  end
end
