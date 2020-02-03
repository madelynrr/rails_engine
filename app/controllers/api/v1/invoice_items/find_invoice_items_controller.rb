class Api::V1::InvoiceItems::FindInvoiceItemsController < ApplicationController

  def show
    if params[:id]
      render json: InvoiceItemSerializer.new(InvoiceItem.find(params[:id]))
    end
  end

end
