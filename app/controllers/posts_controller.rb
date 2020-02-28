class PostsController < ApplicationController
before_action :set_post, only: [:edit, :show]
# before_action :move_to_index, except: [:index, :show, :search]
  def index
    @posts = Post.includes(:user).order("created_at DESC").page(params[:page]).per(5)
  end

  def new
    @post = Post.new
  end

  def create
    Post.create(post_params)
    redirect_to root_path
  end

  def show
  end

  def edit
  end

  def search
    @posts = Post.search(params[:keyword])
  end

  def update
    # postには編集したいレコードの情報が入る
    post = Post.find(params[:id])
    # postをupdateメソッドによって更新しています
    post.update(post_params)
    redirect_to post_path(post.id)
  end

  def destroy
    post = Post.find(params[:id])
    post.destroy
    redirect_to root_path
  end

  private
  def post_params
    params.require(:post).permit(:title, :content).merge(user_id: current_user.id)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:id])
  end

  # def move_to_index
  #   redirect_to action: :index unless user_signed_in?
  # end

end



