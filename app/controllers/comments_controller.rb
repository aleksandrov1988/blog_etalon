class CommentsController < ApplicationController
  before_action :check_authentication
  before_action :set_post, only: :create
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :check_edit, only: [:edit, :update, :destroy]
  before_action :check_create, only: :create

  def edit
  end

  def create
    @comment = @current_user.comments.build(comment_params)
    @comment.post = @post
    if @comment.save
      redirect_to @comment.post, notice: t('.success')
    else
      render 'posts/show'
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.post, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    if @comment.destroy
      flash[:notice] = t('.success')
    else
      flash[:danger] = t('.failure')
    end
    redirect_to @comment.post
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_post
    @post = Post.find(params[:post_id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end

  def check_edit
    render_error unless @comment.edit_by?(@current_user)
  end

  def check_create
    render_error('Комментарии запрещены') if @post.no_comment?
  end
end
