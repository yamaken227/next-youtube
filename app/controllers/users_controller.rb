class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :update]
  before_action :set_user, only: [:show, :edit, :update]
  def show
    #    @posts = @user.posts
    @lists = Kaminari.paginate_array(@user.posts).page(params[:page]).per(9)
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:channel_name, :subscribers_num, :channel_url, :what_channel, :twitter_url)
  end
end
