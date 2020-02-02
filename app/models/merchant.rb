class Merchant < ApplicationRecord

  has_many :items
  has_many :invoices
  has_many :invoice_items, through: :invoices
  has_many :transactions, through: :invoices

  def top_by_revenue
    
  end

end
