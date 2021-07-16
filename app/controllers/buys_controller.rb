class BuysController < ApplicationController
  before_action :authenticate_user!
  before_action :set_item, only:[:index, :create]
  before_action :check_buyer, only: [:index, :create]
  before_action :check_sold_out, only: [:index, :create]

  def index
    @buy_address = BuyAddress.new
  end

  def create
    @buy_address = BuyAddress.new(buy_params)
    if @buy_address.valid?
      pay_item
      @buy_address.save
      redirect_to root_path
    else
      render 'index'
    end
  end

  private
  def buy_params
    params.require(:buy_address).permit(
      :postal_code, :prefecture_id, :city, :address, :building, :phone_number
    ).merge(user_id: current_user.id, item_id: @item.id, token: params[:token])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]
    Payjp::Charge.create(
      amount: @item.price,
      card: buy_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def check_buyer
    redirect_to root_path if current_user.id == @item.user_id
  end

  def check_sold_out
    redirect_to root_path unless @item.buy.blank?
  end
end
