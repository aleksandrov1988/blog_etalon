class SessionsController < ApplicationController
  def new; end

  def create
    @login = params[:login].strip
    @user = User.find_by(login: @login)
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to root_path, notice: t('.success')
    else
      flash[:danger] = t('.failure')
      render :new
    end
  end

  def destroy
    session.delete(:user_id)
    redirect_to root_path, notice: t('.success')
  end
end
