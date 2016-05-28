class ItemsController < ApplicationController
  before_action :set_item, only: [:complete, :destroy, :update, :edit]

  def index
    @items = current_user.items.all.order("created_at DESC")
  end

  def new
    @item = current_user.items.build
  end

  def create
    @item = current_user.items.build(item_params)
    if @item.save
      redirect_to user_path(current_user)
    else
      render :new
      flash[:error] = 'invalid'
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
  end

  def update
    @item.update(item_params)
    if @item.save
      redirect_to item_path(current_user)
    else
      render :edit
    end
  end

  def destroy
    @item.destroy
    redirect_to user_path(current_user)
  end

  def complete
    @item.update_attribute(:completed_at, Time.now)
    redirect_to user_path(current_user)
  end

  private

  def item_params
    params.require(:item).permit(:title, :description, :due_date)
  end

  def set_item
    @item = current_user.items.find(params[:id])
  end
end
