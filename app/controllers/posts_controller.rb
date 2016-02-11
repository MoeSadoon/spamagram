class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]

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

  def show
  end

  def edit
  end

  def update
    @post.update(post_params)
    if @post.save
      flash[:success] = "Post successfully updated"
      redirect_to(post_path(@post))
    end
  end

  def destroy
    @post.destroy
    flash[:success] = "Post successfully deleted"
    redirect_to(root_path)
  end

  private

  def post_params
    params.require(:post).permit(:image, :caption)
  end

  def find_post
    @post = Post.find(params[:id])
  end


end
