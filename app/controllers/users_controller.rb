class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show, :destroy]

  def index
    @users = User.all
    render :index
  end

  def show
    if @user
      render :show
    else
      redirect_to new_user_url
    end 
  end

  def edit
    render :edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_url(@user)
    else
      flash.now[:errors] = @user.errors.full_messages
      render :edit
    end
  end

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_url(@user)
    else
      flash.now[:errors] = ['Fuck Your Couch']
      render :new
    end

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
