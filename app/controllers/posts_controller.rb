class PostsController < ApplicationController
  def index
    @posts = current_user.posts
  end

  def show
    @post = current_user.posts.find(params[:id])
  end

  def new
    @posts = Post.new
  end

  def edit
    @posts = current_user.posts.find(params[:id])
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
    post = current_user.posts.find(params[:id])
    post.destroy
    redirect_to root_path, notice: 'Success!'
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