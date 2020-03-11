class Item < ApplicationRecord
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  validates :name, :price, :detail, :condition, :delivery_fee_payer, :delivery_method, :delivery_agency, :delivery_days, :deal, presence: true
  validates :price, numericality:{greater_than_or_equal_to: 50,less_than_or_equal_to: 9999999}
  validates :item_images, length: { minimum: 1, message: "is none"}

  # Association
  has_many :item_images, dependent: :destroy
  belongs_to :categorie, class_name: 'Categorie', foreign_key: 'category_id'
  belongs_to :user
  accepts_nested_attributes_for :item_images, allow_destroy: true
  has_one :dealings, class_name: 'Dealing', foreign_key: 'item_id'

  enum condition:{"新品、未使用": 0, "未使用に近い": 1, "目立った傷や汚れなし": 2, "やや傷や汚れあり": 3, "傷や汚れあり": 4, "全体的に状態が悪い": 5}
  enum delivery_fee_payer:{"送料込み（出品者負担）": 0, "着払い（購入者負担）": 1}
  enum delivery_method:{"未定": 0, "らくらくメルカリ便": 1, "ゆうメール": 2, "レターパック": 3, "普通郵便（定形、定形外）": 4, "クロネコヤマト": 5, "ゆうパック": 6, "クリックポスト": 7, "ゆうパケット": 8}
  enum delivery_days:{"1〜2日で発送": 0, "2〜3日で発送": 1, "4〜7日で発送": 2}
  enum deal:{"販売中": 0, "売り切れ": 1, "取引中": 2}

  # スコープ 
  scope :with_dealing, -> { joins(:dealings) } ## Dealingsを内部結合
  scope :selling, -> { where(deal: 0) } ##販売中
  scope :sold, -> { where(deal: 1) } ##売り切れ
  scope :dealing, -> { where(deal: 2) } ##取引中
  scope :with_user, -> (user_id) { where(user_id: user_id) } ## ログインユーザー
  scope :with_buyer, -> (user_id) { where(dealings: { buyer_id: user_id } ) } ## 購入者


  # カテゴリの取得メソッド
  def self.search_by_category(category)
    return Item.where(category_id: category).includes(:item_images, :categorie)
  end

  ## 出品中の商品一覧取得メソッド
  def self.get_selling_items(user_id)
    return Item.with_user(user_id).selling.includes(:item_images, :categorie)
  end

  ## 売却済みの商品一覧取得メソッド
  def self.get_sold_items(user_id)
    return Item.with_user(user_id).sold.includes(:item_images, :categorie)
  end

  ## 取引中の商品一覧取得メソッド
  def self.get_selling_progress_items(user_id)
    return Item.with_user(user_id).dealing.includes(:item_images, :categorie)
  end

  ## 取引中の購入予定商品一覧取得メソッド
  def self.get_bought_progress_items(user_id)
    return Item.with_dealing.with_buyer(user_id).dealing.includes(:item_images, :categorie)
  end

  ## 過去に購入済みの商品一覧取得メソッド
  def self.get_bought_past_items(user_id)
    return Item.with_dealing.with_buyer(user_id).includes(:item_images, :categorie)
  end
end