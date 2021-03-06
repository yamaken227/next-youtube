class PostsController < ApplicationController
  impressionist actions: [:show]
  before_action :authenticate_user!, only: [:new, :create, :edit, :destroy]
  before_action :set_post, only: [:edit, :update]
#  before_action :set_cache_headers, only: [:index,:show]
  
  def home
  end

  def index
    if params[:text] == nil || params[:text] == ""
      @posts = Post.order('RAND()').limit(8)
    else
      @posts = Post.where('title LIKE(?)', "%#{params[:text]}%").order('RAND()').limit(8)   
#    @posts = Post.search(params[:keyword]).order('RAND()').limit(8)
    end
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    url = params[:post][:video_url]
    url = url.slice(-11, 11)
    @post.video_str = url
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  def show
    @post = Post.find(params[:id])
    impressionist(@post, nil, unique: [:session_hash])
    @message = Message.new
    @messages = @post.messages.order(id: 'DESC')
  end

  def destroy
    post = Post.find(params[:id])
    post_user = post.user_id
    if current_user.id == post.user_id
      post.destroy
      redirect_to user_path(post_user)
    else
      render 'users/show'
    end
  end

  def edit
    redirect_to posts_path unless current_user.id == @post.user.id
  end

  def update
    url = params[:post][:video_url]
    url = url.slice(-11, 11)
    @post.video_str = url
    if @post.update(post_params)
      redirect_to user_path(@post.user_id)
    else
      render :edit
    end
  end


  private

  def post_params
    params.require(:post).permit(:title, :highlights, :video_url)
          .merge(user_id: current_user.id)
  end

  def set_post
    @post = Post.find(params[:id])
  end
  def set_cache_headers
#    response.headers["Cache-Control"] = "no-store"
  end
end
