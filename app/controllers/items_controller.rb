class ItemsController < ApplicationController

  #to use no_menu layout
  layout "no_menu"

  def new ## 出品ページ
    @item = Item.new
    @item.item_images.build  ## 新規画像用
  end

  def edit ## 商品編集ページ
    @item = current_user.items.find(params[:id])
    @item.item_images.build  ## 新規画像用
  end

  def create
    redirect_to root_path, notice: "商品の出品に成功しました。"
  end

  def update
    redirect_to root_path, notice: "商品の編集に成功しました。"
  end
end
