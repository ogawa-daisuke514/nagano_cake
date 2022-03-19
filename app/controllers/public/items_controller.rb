class Public::ItemsController < ApplicationController
  # ログイン不要
  def index
    all = Item.all
    @items_count = all.size
    @items = Kaminari.paginate_array(all).page(params[:page]).per(8)
  end

  def show
  end

  def genre
    find_genre = Genre.find(params[:id])
    all_genre = Item.where(genre: find_genre)
    @items_count = all_genre.size
    @items = Kaminari.paginate_array(all_genre).page(params[:page]).per(8)
    render :index
  end
end
