class PostsController < ApplicationController
  before_action :authenticate_user!
  def index
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def edit
    @post = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      redirect_to posts_path, notice: "Post created"
    else
      @posts = Post.all
      render :index
    end
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: "Post updated"
    else
      render :edit
    end
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.present?
      post.destroy
    end
    redirect_to posts_path
  end

  private
  def post_params
      params.require(:post).permit(:title, :description)
  end
end
