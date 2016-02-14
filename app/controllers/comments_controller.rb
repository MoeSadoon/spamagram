class CommentsController < ApplicationController
  before_action :find_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "Your comment has been posted"
      redirect_to :back
    else
      flash[:alert] = "Error, check comment form"
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    flash[:success] = "Comment successfully deleted"
    redirect_to root_path
  end



  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

end
