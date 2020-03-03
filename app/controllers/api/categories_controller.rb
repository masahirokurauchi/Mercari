class Api::CategoriesController < ApplicationController

  def index
    category = Categorie.find(params[:category_id])
    @categories = category.children
  end
end