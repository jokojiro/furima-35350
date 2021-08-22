class BuysController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_root_path, only: [:index, :create]

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
      render action: :index
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def buy_params
    params.require(:buy_address).permit(:postal_code, :area_id, :municipalities, :address, :phone_number, :building_name).merge(user_id: current_user.id,
                                                                                                    item_id: params[:item_id], token: params[:token])
  end

  def move_to_root_path
    redirect_to root_path if current_user.id == @item.user.id || @item.buy != nil
  end

  def pay_item
    Payjp.api_key = "sk_test_4e6da65b0826551a5845f990"
    Payjp::Charge.create(
      amount: @item.price, # 商品の値段
      card: buy_params[:token], # カードトークン
      currency: 'jpy'                 # 通貨の種類（日本円）
    )
  end
end