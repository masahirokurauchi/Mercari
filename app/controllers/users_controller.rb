class UsersController < ApplicationController

    ## マイページ用レイアウトを使用
	layout "mypage"
    
    ## ログインユーザーのid取得
	before_action :get_user_id

	def show ## マイページ
	end

	def selling ## 出品中の商品一覧
		@items = Item.get_selling_items(@user_id)
	end

	def selling_progress ## 取引中の商品一覧
		@items = Item.get_selling_progress_items(@user_id)
	end

	def sold ## 売却済みの商品一覧
		@items = Item.get_sold_items(@user_id)
	end

	def bought_progress ## 取引中の購入予定商品一覧
		@items = Item.get_bought_progress_items(@user_id)
	end

	def bought_past ## 過去に購入済みの商品一覧
		@items = Item.get_bought_past_items(@user_id)
	end

	private
	def get_user_id
		@user_id = current_user.id
	end
end
