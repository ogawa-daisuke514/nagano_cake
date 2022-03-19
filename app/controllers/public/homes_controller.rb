class Public::HomesController < ApplicationController
  #ログイン不要
  def top
    @new_items = Item.all.order(created_at: "DESC")[0..4]
    @genres = Genre.all
  end

  def about
  end
end
