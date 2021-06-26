class ItemsController < ApplicationController
  before_action :move_to_sign_in, except: [:index, :show]

  def index
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

  private
  def item_params
    params.require(:item).permit(
      :name, :price, :info, :image,
      :category_id, :sales_status_id, :fee_status_id, :prefecture_id, :scheduled_delivery_id
    ).merge(user_id: current_user.id)
  end

  def move_to_sign_in
    unless user_signed_in?
      redirect_to new_user_session_path
    end
  end
end
