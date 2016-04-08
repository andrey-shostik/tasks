class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :complete, :destroy, :update, :edit]
  def index
    @items = current_user.items.all.order("created_at DESC")
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to root_path
    else
      render :new
      flash[:error] = 'invalid'
    end
  end

  def show
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  def destroy
    @item.destroy
    redirect_to root_path
  end

  def complete
    @item.update_attribute(:completed_at, Time.now)
    redirect_to root_path
  end

  private

  def item_params
    params.require(:item).permit(:title, :description)
  end

  def set_item
    @item = current_user.items.find(params[:id])
  end
end
