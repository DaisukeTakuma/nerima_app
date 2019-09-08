class PostsController < ApplicationController

  def index
  end

  def show
    @post = Post.find(params[:id])
    @user = User.find(@post.user_id)
    @comments = @post.comments.page(params[:page]).recent.per(5)
    @comment = Comment.new
  end

  def new
    @posts = Post.new
  end

  def edit
    #未ログインユーザはelse内の処理を実行
    unless current_user.blank? then
      post = Post.find(params[:id])
      #ログインユーザがadminか、投稿者なら投稿内容を@postに代入
      if current_user.admin? || current_user.id == post.user_id
        @posts = post
      else
        redirect_to root_path, notice: '権限がありません'
      end
    else
      redirect_to root_path, notice: '権限がありません'
    end
  end

  def update
    post = current_user.posts.find(params[:id])
    if post.update(post_params)
      redirect_to root_path, notice: '編集が完了しました'
    else
      flash[:alert] = '編集の保存に失敗しました'
      render :edit
    end
  end

  def destroy
    #未ログインユーザはelse内の処理を実行
    unless current_user.blank? then
      post = Post.find(params[:id])
      #ログインユーザがadminか、投稿者なら削除を実行
      if current_user.admin? || current_user.id == post.user_id
        post.destroy
        redirect_to root_path, notice: '削除が完了しました'
      else
        redirect_to root_path, notice: '権限がありません'
      end
    else
      redirect_to root_path, notice: '権限がありません'
    end
  end

  def create
    #:category_nameは、カテゴリ名と0(チェックなし)または1(チェックあり)がペアの2次元配列
    params[:category_name].each do |cn1,cn2|
      #チェックが入っていたカテゴリ名をDBに登録
      if cn2 == "1"
        post = current_user.posts.new(post_params)
        post.category_name = cn1
        #if文で保存すると、複数回render、redirectしてしまうため使用不可
        post.save!
        redirect_to post, notice: "「#{post.title}」を投稿しました。"
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :description, :category_name, :image, :url)
  end
end