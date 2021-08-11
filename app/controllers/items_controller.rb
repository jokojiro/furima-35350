class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create ]
  before_action :set_item, only: [:show ]
 
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

  def index
    @items = Item.order('created_at DESC')
  end

   def show
   end
 
  private
    def item_params
      params.require(:item).permit(:title, :image, :description, :category_id, :condition_id, :shipping_id,
                                   :area_id, :delivery_days_id, :price).merge(user_id: current_user.id)
    end
    def set_item
      @item = Item.find(params[:id])
    end
  end
