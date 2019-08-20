class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
    #@post = current_user.posts.find(params[:id])以前かいたやつ
  end

  def new
    @posts = Post.new
  end

  def edit
    if current_user.admin?
      @posts = Post.find(params[:id])
    else
      redirect_to root_path, notice: '権限がありません'
    end
    #if current_user.admin? then
    #  @posts = Post.find(params[:id])
    #elsif current_user && current_user.posts.find_by(params[:id]).empty? then
    #  @posts = current_user.posts.find(params[:id])
    #else
    #  redirect_to root_path, notice: '権限がありません'
    #end
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
    if current_user.admin?
      post = Post.find(params[:id])
      post.destroy
      redirect_to root_path, notice: 'Success!'
    else
      redirect_to root_path, notice: '権限がありません'
    end
  end

  def create
    @post = current_user.posts.new(post_params)

    if @post.save!
      redirect_to @post, notice: "「#{@post.title}」を投稿しました。"
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :description, :url)
  end
end