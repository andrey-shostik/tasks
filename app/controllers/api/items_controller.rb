class Api::ItemsController < ApplicationController
  skip_before_action :require_user
  before_action :check_token

  def index
    if User.find_by(token: @token)
      @items = Item.all
      render json: @items
    else
      render text: 'Not specified token'
    end
  end

  def create
    if User.find_by(token: @token)
      @item = current_user.items.build(item_params)
      if @item.save
        render json: @item
      else
        render text: 'Error save item'
      end
    else
      render text: 'Not specified token'
    end
  end

  def show
    if User.find_by(token: @token)
      @item = Item.find(params[:id])
      render json: @item
    else
      render text: 'Not specified token'
    end
  end

  def update
    if User.find_by(token: @token)
      @item.update(item_params)
      if @item.save
        render json: @item
      else
        render text: 'Error update item'
      end
    else
      render text: 'Not specified token'
    end
  end

  def destroy
    if User.find_by(token: @token)
      @item.destroy
      render json: @item
    else
      render text: 'Not specified token'
    end
  end

  def complete
    if User.find_by(token: @token)
      @item.update_attribute(:completed_at, Time.now)
      render json: @item
    else
      render text: 'Not specified token'
    end
  end

  private

  def item_params
    params.require(:item).permit(:title, :description)
  end

  def check_token
    @token = request.headers['HTTP_TOKEN']
  end
end
