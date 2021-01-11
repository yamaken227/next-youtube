class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
#    @posts = @user.posts
    @lists = Kaminari.paginate_array(@user.posts).page(params[:page]).per(6)
  end
end
