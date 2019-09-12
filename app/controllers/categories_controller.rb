class CategoriesController < ApplicationController
  def index
    if @category_name = Post.find_by(category_name: params[:category_name])
      @q = Post.where(category_name: params[:category_name]).ransack(params[:q])
      @posts = @q.result(distinct: true).page(params[:page]).recent
    else
      redirect_to root_path, flash: {info: "#{params[:category_name]}カテゴリには、まだ記事がありません。"}
    end
  end
end