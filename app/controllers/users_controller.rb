class UsersController < ApplicationController
  before_action :authenticate_user!, :only => [:show]
  def index
    @users = User.page(params[:page]).reverse_order.per(6)
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
    @relationship = current_user.relationships.find_by(follow_id: @user.id)  
    @set_relationship = current_user.relationships.new
    @currentUserEntry=Entry.where(user_id: current_user.id)
    @userEntry=Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id then
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
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

  def followings
    @user = User.find(params[:id])
    @users = @user.followings.all
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
