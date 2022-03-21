class Public::ItemsController < ApplicationController
  # ログイン不要
  def index
    all = Item.all
    @title = "商品一覧"
    set_items(all)
    render :index
  end

  def show
    @item = Item.find(params[:id])
    @cart_once = 10
    @cart_item = CartItem.new
  end

  def genre
    target = Genre.find(params[:id])
    searched = Item.where(genre: target)
    @title = target.name + "一覧"
    set_items(searched)
    render :index
  end

  def search
    word = params[:search_word]
    #わざわざパラメータ分けてるしインジェクション耐性があると信じよう
    searched = Item.where("name like ?", "%#{word}%")
    @title = "検索結果: " + word
    set_items(searched)
    render :index
  end

  private
  def set_items(source)
    @items_count = source.size
    @items = Kaminari.paginate_array(source).page(params[:page]).per(8)
  end
end
