class ProfilesController < ApplicationController
  before_action :owned_profile, only: [:edit, :update]
  before_action :set_user

  def show
    @user = User.find_by(username: params[:username])
    @posts = User.find_by(username: params[:username]).posts.order('created_at DESC')
  end

  def edit
    @user = User.find_by(username: params[:username])
  end

  def update
    @user = User.find_by(username: params[:username])
    if @user.update(profile_params)
      flash[:success] = 'Your profile has been updated.'
      redirect_to profile_path(@user.username)
    else
      @user.errors.full_messages
      flash[:error] = @user.errors.full_messages
      render :edit
    end
  end

  private

  def profile_params
    params.require(:user).permit(:avatar, :bio)
  end

  def owned_profile
      @user = User.find_by(username: params[:username])
      unless current_user == @user
        flash[:alert] = "You cannot edit this!"
        redirect_to root_path
      end
    end

  def set_user
    @user = User.find_by(username: params[:username])
  end

end
