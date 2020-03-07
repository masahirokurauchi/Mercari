class ItemsController < ApplicationController

  #to use no_menu layout
  # layout "no_menu"

  def index
    return false if Item.count == 0 ## 商品数がゼロのときはランキングが作れないのでここで終了
    @new_items_arrays = []
    @categories = ["チノパン", "サンダル", "アート/写真", "正月"] ## 新着アイテムを表示したいカテゴリの名前たち
    @categories = @categories.map{|category_name| Categorie.find_by(name: category_name)} ## カテゴリの名前たちを使ってカテゴリのインスタンスが入った配列を作成
    @categories.each do |category|
      @new_items_arrays << Item.search_by_category(category.subtree_ids).order("created_at DESC").limit(4) ## カテゴリごとの新着アイテムを配列化する

    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def new ## 出品ページ
    render layout: "no_menu"
    @item = Item.new
    @item.item_images.build  ## 新規画像用
  end

  def edit ## 商品編集ページ
    render layout: "no_menu"
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
