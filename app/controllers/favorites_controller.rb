class FavoritesController < ApplicationController
  before_action :authenticate_user!
  def create
  	@product = Product.find(params[:product_id])
    favorite = current_user.favorites.new(product_id: @product.id)
    favorite.save
    redirect_to request.referer
  end

  def destroy
  	@product = Product.find(params[:product_id])
    favorite = current_user.favorites.find_by(product_id: @product.id)
    favorite.destroy
    redirect_to request.referer
  end

  def index
    @user = current_user
    @favorites = Favorite.where(user_id: @user.id).all
  end

  def show
    @product = Product.find(params[:product_id])
    @favorites = Favorite.where(product_id: @product.id).all
  end
end
