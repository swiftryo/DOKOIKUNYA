class ProductsController < ApplicationController
  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]
  def index
    @products = Product.all.includes(:user)
  end

  def show
    @product = Product.find(params[:id])
    @review = Review.new
  end

  def about
  end

  def top
  end

  def new
    @product = Product.new
  end

  def create
    product = Product.new(product_params)
    if product.save
      flash[:notice] = "場所を登録しました。"
      redirect_to product_path(product)
    else
      flash[:notice] = "登録できませんでした。"
      render :new
   end
  end

  def edit
    @product = Product.find(params[:id])
  end

  def update
    product = Product.find(params[:id])
    if product.update(product_params)
       redirect_to product_path(product.id)
    else
      render :edit
    end
  end

  def destroy
    product = Product.find(params[:id])
    product.destroy
    redirect_to products_path
  end

  private

  def product_params
    params.require(:product).permit(:name, :introduction, :image, :status, :genre_id, :genre_name, :prefecture_code, :city, :street)
  end

  def ensure_correct_user
    @product = Product.find(params[:id])
    unless @product.user == current_user
      redirect_to products_path
    end
  end
end
