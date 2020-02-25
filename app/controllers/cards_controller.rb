class CardsController < ApplicationController
  # before_action :authenticate_user!, except: [:create]

  def new
    @card = Card.new
  end

  def create #データベースにカードのcustomerのtokenを保存する。
    email = current_user.email
    # params[:card_token]に「tok_hogehoge」という形でカードのトークンが送られてきている
    # ↑このトークンはjsの方でappendしたhidden_fieldに埋め込まれていたもの
    customer = Card.regist_customer(params[:card_token], email) ## customerを作成
    @card = Card.new(customer_token: customer&.id)
    redirect_to action: "new", alert: "カードの登録に失敗しました。" and return if @card.invalid? ## カードの保存に失敗した場合
    ## 保存に成功した場合
    @card.user_id = current_user.id
    @card.save
    redirect_to cards_path and return
  end

  def show
    @card = Card.get_card(current_user.card&.customer_token)
  end

  def self.get_card(customer_token)  ## カード情報を取得する。支払い方法ページで使用する。
    return nil unless customer_token
    Payjp.api_key = Rails.application.credentials.payjp[:secret_key]
    customer = Payjp::Customer.retrieve(customer_token)
    card = {}
    card_data = customer.cards.retrieve(customer.default_card)
    card[:last4] = "************" + card_data.last4
    card[:exp_month]= card_data.exp_month
    card[:exp_year] = card_data.exp_year - 2000
    card[:brand] = card_data.brand
    return card
  end

  def destroy
    @card = current_user.card
    @card.destroy
    redirect_to cards_path
  end
end
