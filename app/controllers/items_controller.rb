class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new,:create,:edit,:update,:destroy]
  before_action :set_item, only: [:show,:edit,:update,:destroy]
  before_action :move_to_index, only: [:edit,:update,:destroy]
  before_action :sold_out,only: [:edit, :update, :destroy]

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
 
  def edit
  end
  
  def update
    if @item.update(item_params)
      redirect_to item_path(@item.id)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end
  
  private
    def item_params
      params.require(:item).permit(:title, :image, :description, :category_id, :condition_id, :shipping_id,
                                   :area_id, :delivery_days_id, :price, images: []).merge(user_id: current_user.id)
    end
    def set_item
      @item = Item.find(params[:id])
    end
    def move_to_index
      redirect_to action: :index unless current_user.id == @item.user_id
    end
    
    def sold_out
      redirect_to root_path if @item.buy != nil
    end
  end
  