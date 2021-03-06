class PostsController < ApplicationController
  before_action :find_post, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, except: [:index, :show]
  before_action :own_post, only: [:edit, :update, :destroy]

  def index
    @posts = Post.all.order('created_at DESC').page params[:page]
  end

  def new
    @post = current_user.posts.build
  end

  def create
    @post = current_user.posts.build(post_params)
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

  def own_post
    unless current_user == @post.user
      flash[:alert] = "That post does not belong to you!"
      redirect_to root_path
    end
  end

end
