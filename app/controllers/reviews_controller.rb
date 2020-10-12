class ReviewsController < ApplicationController
  before_action :authenticate_user!, only: [:create]
  def index
  	@product = Product.find(params[:product_id])
    @reviews = @product.reviews
  end

  def create
  	@review = Review.new(review_params)
    @review.user_id =current_user.id
    if @review.save
      redirect_to product_reviews_path(@review.product)
    else
      @product = Product.find(params[:id])
      render "products/show"
    end
  end

  def destroy
  end
  
  private
  def review_params
    params.require(:review).permit(:product_id, :score, :content)
  end
end
