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
    require "pry"; binding.pry
  end

end
