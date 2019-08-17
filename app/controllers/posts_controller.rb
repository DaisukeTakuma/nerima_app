class PostsController < ApplicationController
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def new
    @posts = Post.new
  end

  def edit
    @posts = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to root_path, notice: 'Success!'
    else
      flash[:alert] = 'Save error'
      render :edit
    end
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path, notice: 'Success!'
  end

  def create
    post = Post.new(post_params)
    post.save!
    redirect_to root_path, notice: "「#{post.title}」を投稿しました。"
  end

  private

  def post_params
    params.require(:post).permit(:title, :summary, :description, :url)
  end
end