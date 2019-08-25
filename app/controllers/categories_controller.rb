class CategoriesController < ApplicationController
  def index
    if @category_name = Post.find_by(category_name: params[:category_name])
      @q = Post.where(category_name: params[:category_name]).ransack(params[:q])
      @posts = @q.result(distinct: true).page(params[:page])
    else
      redirect_to root_path, notice: "投稿がまだありません"
    end
  end
end

#アプリケーションコントローラーで設定している、before_actionのset_searchをsessions_controllerと、categories_controllerでは外したい。
#before_actionの変数名と、コントローラーで定義している変数名はぶつかってしまうのか？？おそらく、対応するviewの部分でしか機能しないと思う。