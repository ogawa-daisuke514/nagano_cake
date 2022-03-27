class Admin::ItemsController < ApplicationController

  before_action :authenticate_admin!

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item), notice: "商品を正常に追加しました。"
    else
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item), notice: "商品を正常に保存しました。"
    else
      render :edit
    end
  end

  def index
    set_items(Item.all)
    @title = "商品一覧"
  end

  def search
    word = params[:search_word]
    searched = Item.where("name like ?", "%#{word}%")
    @title = "検索結果: " + word
    set_items(searched)
    render :index
  end

  def show
    @item = Item.find(params[:id])
  end

  private
  def set_items(source)
    @items_count = source.size
    @items = Kaminari.paginate_array(source).page(params[:page]).per(10)
  end
  def item_params
    params.require(:item).permit(:name, :introduction, :image, :price, :is_active, :genre_id)
  end
end
