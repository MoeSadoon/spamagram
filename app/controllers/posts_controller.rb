class PostsController < ApplicationController

  def index
    @posts = Post.all
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.create(post_params)
    if @post.save
      flash[:success] = "Your post has been created"
      redirect_to posts_path
    else
      flash[:alert] = "You need to upload an image"
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end


end
