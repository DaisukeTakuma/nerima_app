class CategoriesController < ApplicationController
  def index
    @posts = Post.where(category_name: params[:category_name])
  end
end