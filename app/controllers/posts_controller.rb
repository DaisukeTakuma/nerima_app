class PostsController < ApplicationController

  def index
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @posts = Post.new
  end

  def edit
    post = Post.find(params[:id])
    if current_user.admin? || current_user.id == post.user_id
      @posts = post
    else
      redirect_to root_path, notice: '権限がありません'
    end
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, notice: 'Success!'
    else
      flash[:alert] = 'Save error'
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    if current_user.admin? || current_user.id == post.user_id
      post.destroy
      redirect_to root_path, notice: 'Success!'
    else
      redirect_to root_path, notice: '権限がありません'
    end
  end

  def create
    #:category_nameは、カテゴリ名と0か1がペアの配列。
    #category_nameカラムに、配列に代わって、カテゴリ名を上書き登録する
    params[:category_name].each do |cn1,cn2|
      if cn2 == "1"
        @post = current_user.posts.new(post_params)
        @post.category_name = cn1
        #if文で保存すると、複数回render、redirectしてしまうため使えない。
        @post.save!
        redirect_to @post, notice: "「#{@post.title}」を投稿しました。"
      end
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :description, :category_name, :image, :url)
  end
end