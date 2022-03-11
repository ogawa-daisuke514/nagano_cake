class Admin::ItemsController < ApplicationController
  def new
    @item = Item.new
  end
  def create
  end

  def edit
  end
  def update
  end

  def index
  end

  def show
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :image, :price, :is_active, :genre_id)
  end
end
