class PostsController < ApplicationController
  before_action :check_authentication, except: [:index, :show]
  before_action :set_post, only: [:edit, :update, :destroy, :versions]
  before_action :check_edit, only: [:edit, :update, :destroy]

  def index
    @posts = Post.ordering.full.page(params[:page])
  end

  def show
    @post = Post.includes(:user, comments: :user).find(params[:id])
    @post.increment!(:views_count)
    @comment = Comment.new(post: @post)
  end

  def new
    @post = Post.new
  end

  def edit
  end

  def create
    @post = @current_user.posts.build(post_params)
    if @post.save
      redirect_to @post, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @post.update(post_params)
      redirect_to @post, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    if @post.destroy
      redirect_to posts_path, ntoice: t('.success')
    else
      flash[:danger] = t('.failure')
      redirect_to @post
    end
  end

  def versions
    @versions = @post.versions.reverse
  end

  private

  def set_post
    @post = Post.full.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body)
  end

  def check_edit
    render_error unless @post.edit_by?(@current_user)
  end
end
