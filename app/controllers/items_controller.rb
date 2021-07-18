class ItemsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :set_item, only: [:show, :edit, :update]
  before_action :check_user, only: [:edit, :update]

  def index
    @items = Item.order('created_at DESC')
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render action: :edit
    end
  end

  def destroy
    item = Item.find(params[:id])
    if item.user_id == current_user.id
      item.destroy
      redirect_to root_path
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def check_user
    redirect_to root_path unless user_signed_in? && current_user.id == @item.user_id && @item.buy.blank?
  end

  def item_params
    params.require(:item).permit(
      :name, :price, :info, :image,
      :category_id, :sales_status_id, :fee_status_id, :prefecture_id, :scheduled_delivery_id
    ).merge(user_id: current_user.id)
  end
end
