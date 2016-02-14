class CommentsController < ApplicationController
  before_action :find_post

  def create
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id

    if @comment.save
      respond_to do |format|
        format.html {redirect_to root_path}
        format.js
      end

      # flash[:success] = "Your comment has been posted"
      # redirect_to :back
    else
      flash[:alert] = "Error, check comment form"
      render root_path
    end
  end

  def destroy
    @comment = @post.comments.find(params[:id])
    if @comment.user_id == current_user.id
      @comment.delete
      respond_to do |format|
        format.html { redirect_to root_path }
        format.js
      end
    end
  end



  private

  def comment_params
    params.require(:comment).permit(:content)
  end

  def find_post
    @post = Post.find(params[:post_id])
  end

end
