class CategoriesController < ApplicationController
  def index
    if @category_name = Post.find_by(category_name: params[:category_name])
      @posts = Post.where(category_name: params[:category_name])
    else
      redirect_to root_path, notice: "投稿がまだありません"
    end
  end
end

def show
  @q = Post.find_by(category_name: params[:category_name]).ransack(params[:q])
  @post = @q.result(distinct: true).page(params[:page])
end