class UsersController < ApplicationController
  before_action :check_authentication, only: [:edit, :update, :destroy]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_edit, only: [:edit, :update, :destroy]

  def index
    @users = User.ordering.page(params[:page])
  end

  def show
    @posts = @user.posts.page(params[:page])
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to login_path, notice: t('.success')
    else
      render :new
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: t('.success')
    else
      render :edit
    end
  end

  def destroy
    if @user.destroy
      redirect_to user_path, notice: t('.success')
    else
      flash[:danger] = t('.failure')
      redirect_to @user
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :login, :password, :password_confirmation)
  end

  def check_edit
    render_error unless @user.edit_by?(@current_user)
  end
end
