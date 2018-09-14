class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.all
    render :index
  end

  def show
    render :show
  end

  def edit
  end

  def update
  end

  def new
  end

  def create
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end

  def find_user
    @user = User.find_by(id: params[:id])
  end


end
