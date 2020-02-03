class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant

  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :transactions

  # def self.total_revenue(date)
  #   beginning = date.beginning_of_day
  #   ending = date.end_of_day
  #
  #   x = joins(:transactions)
  #   .select("SUM((invoice_items.quantity) * (invoice_items.unit_price)) AS total")
  #   # group("invoices.created_at")
  #   # .merge(Transaction.successful)
  #   # .where("invoices.created_at BETWEEN #{beginning} AND #{ending}")
  #
  #   require "pry"; binding.pry
  #
  # end
end
