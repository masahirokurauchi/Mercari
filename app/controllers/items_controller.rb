class ItemsController < ApplicationController

  before_action :set_item, only: [:edit, :update, :destroy, :show, :purchase_confirmation, :purchase] ## @itemを定義する
  before_action :authenticate_user!, except: [:index, :item_selling?] ## ログイン必須アクション
  before_action :item_selling?, only: [:edit, :update, :destroy, :purchase_confirmation, :purchase] ## 売り切れではないかチェック
  before_action :seller?, only: [:edit, :update, :destroy] ## 出品者のみ可能なアクション
  before_action :not_seller?, only: [:purchase] ## 出品者ではない人のみ可能なアクション

  def index
    return false if Item.count == 0 ## 商品数がゼロのときはランキングが作れないのでここで終了
    categories = Categorie.roots ## 親カテゴリたちを配列で取得
    items = categories.map{|root| Item.search_by_category(root.subtree_ids)} ## カテゴリごとの商品リストを取得
    @sorted_items = items.sort { |a,b| b.length <=> a.length} ## カテゴリごとの商品リストを商品数が多い順で並び替える
    @sorted_items = @sorted_items[0..3].map{|items| items.order("created_at DESC").limit(4)} ## 商品数が多いカテゴリ上位4つのみ表示したい。また、1つのカテゴリのうち新着商品は4つだけ表示する。
    @sorted_items = @sorted_items.reject(&:blank?) ## 商品数がゼロのカテゴリを削除する
    @category_ranking = @sorted_items.map{|items| items[0].categorie.root} ## 商品数が多いカテゴリのランキングを定義
  end

  def show
  end

  def purchase_confirmation
    @card = Card.get_card(current_user.card&.customer_token)
  end

  def purchase
    ## カードの所持を確認
    redirect_to purchase_confirmation_item_path(@item), notice: 'カード情報を登録してください。' and return unless current_user.card
    ## with_lockで同時購入を防ぐ
    ActiveRecord::Base.transaction do
      @item.with_lock do
        ## 取引状態を更新
        @item.update(deal: '売り切れ')
        # binding.pry
        Dealing.create(item_id: @item.id, buyer_id: current_user.id)

        ## 秘密鍵を渡して認証
        Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
        ## 顧客のトークンを渡して顧客情報をもらう
        customer = Card.get_customer(current_user.card.customer_token)
        ## 顧客情報を使って支払いをする
        Payjp::Charge.create(
          amount: @item.price, # 決済する値段
          customer: customer.id,
          currency: 'jpy'
        )
      end
    end
    redirect_to root_path, notice: '購入しました。'
    ## 例外処理
    rescue Payjp::CardError
      redirect_to item_path(@item), notice: '購入に失敗しました。'
  end

  def item_selling? ## 売り切れだったらリダイレクト
    redirect_to item_path(@item), alert: '売り切れました。' if @item.deal != "販売中"
  end

  def seller? ## 出品者ではなかったらリダイレクト
    redirect_to item_path(@item), alert: "あなたは出品者ではありません。" unless @item.user.id == current_user.id
  end

  def not_seller? ## 出品者だったらリダイレクト
    redirect_to item_path(@item), alert: "あなたは出品者です。" if @item.user.id == current_user.id
  end

  def new ## 出品ページ
    @item = Item.new
    @item.item_images.build  ## 新規画像用
    render layout: "no_menu"
  end

  def edit ## 商品編集ページ
    @item.item_images.build  ## 新規画像用
    render layout: "no_menu"
  end

  def create
    redirect_to root_path, notice: "商品の出品に成功しました。"
  end

  def update
    redirect_to root_path, notice: "商品の編集に成功しました。"
  end

  def destroy
    @item.destroy
    redirect_to root_path, notice: "商品の削除に成功しました。"
  end

  private
  def set_item ## @itemを定義する
    @item = Item.find(params[:id])
  end
end
