class PostsController < ApplicationController
  def index
    @posts = Post.order("RAND()").limit(9)
  end
  def new
    @post = Post.new
  end
  def create
    @post = Post.new(post_params)
    url = params[:post][:video_url]
    url = url.slice(-11,11)
    @post.video_url = url
    if @post.save
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :highlights, :video_url)
    .merge(user_id: current_user.id)
  end
end
