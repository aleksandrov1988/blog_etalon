class LikesController < ApplicationController
  before_action :check_authentication

  def create
    @post = Post.find(params[:post_id])
    @like = @current_user.likes.build(post: @post)
    if @like.save
      flash[:notice] = 'Отметка «Мне нравится» оставлена'
    else
      flash[:danger] = 'Не удалось оставить отметку «Мне нравится»'
    end
    redirect_to @like.post
  end

  def destroy
    @like = @current_user.likes.find(params[:id])
    @like.destroy
    redirect_to @like.post, notice: 'Отметка «Мне нравится удалена»'
  end
end
