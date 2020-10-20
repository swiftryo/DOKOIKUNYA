class UsersController < ApplicationController
  def index
    @users = User.page(params[:page])
  end

  def edit
    @user = User.find(params[:id])
    if @user == current_user
      render "edit"
    else
      redirect_to root_path
    end
  end

  def update
    @user = User.find(params[:id])
    @user.update(user_params)
    redirect_to user_path(@user.id)
  end

  def show
    @user = User.find(params[:id])
  end

  def withdraw
  end

  def usubscribe
      @user = User.find(current_user.id)
      if @user.update!(is_deleted: true)
         sign_out current_user
      end
      redirect_to root_path
  end

  def search
    @user_or_product = params[:option]
    if @user_or_product == "1"
       @users = User.search(params[:search], @user_or_product)
    elsif @user_or_product == "2"
       @products = Product.search(params[:search], @user_or_product)
    else
      @prefecture_code = Product.search(params[:search], @user_or_product)
    end
  end


  private
  def user_params
    params.require(:user).permit(:name, :prefecture_code, :email, :biography, :profile_image)
  end

  def ensure_correct_user
    @user = User.find(params[:id])
    unless @user == current_user
      redirect_to user_path(current_user)
    end
  end
end
