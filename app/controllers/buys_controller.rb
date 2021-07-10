class BuysController < ApplicationController
  def index
    @item = Item.find(params[:item_id])
    @buy = Buy.new
  end

  def create
    @buy = Buy.new(buy_params)
  end

  private
  def buy_params
    params.require(:buy)
  end
end
