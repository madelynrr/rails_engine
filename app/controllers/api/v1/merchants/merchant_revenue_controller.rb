class Api::V1::Merchants::MerchantRevenueController < ApplicationController

  def index
    merchants = Merchant.top_by_revenue(params[:quantity])
    render json: MerchantSerializer.new(merchants)
  end

  def show
    revenue = Invoice.total_revenue(params[:created_at])
    render json: RevenueSerializer.new(revenue)
  end

  # x = Invoice.joins(:transactions)
  # .select("invoice_items.quantity * invoice_items.unit_price AS total_revenue")
  # .merge(Transaction.successful)
  # .where("invoices.created_at: 2020-02-01 23:36:19 UTC")
  # .group("invoices.created_at")
  # require "pry"; binding.pry

end
