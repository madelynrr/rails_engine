class Api::V1::ItemsController < ApplicationController

  def index
    if !params.key?("merchant_id")
      render json: ItemSerializer.new(Item.all)
    else
      merchant = Merchant.find(params[:merchant_id])
      render json: ItemSerializer.new(merchant.items)
    end
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item)
  end

end
