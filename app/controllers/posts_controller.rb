class PostsController < ApplicationController
  def index
    #@posts = Post.all
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
    params.require(:post).permit(:title, :summary, :description, :category_name, :url)
  end
end



#def create
#  @post = current_user.posts.new(post_params)
#  @post.category_name.each do |cn1,cn2|
#    if cn2 == "1"
#      post = @post.category_name(cn1)
#      if post.save!
#        redirect_to @post, notice: "「#{@post.title}」を投稿しました。"
#      end
#    else
#      render :new
#    end
#  end
#end