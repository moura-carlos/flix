class ReviewsController < ApplicationController
  before_action :require_sign_in
  before_action :set_movie

  def index
    @reviews = @movie.reviews
  end
  def new
    @review = @movie.reviews.new
  end
  def create
    @review = @movie.reviews.new(review_params)
    @review.user = current_user
    if @review.save
      redirect_to movie_reviews_path(@movie), status: :see_other, notice: "Thanks for your review!"
    else
      render :new, status: :unprocessable_entity#, danger: "Something went wrong! Please, try again."
    end
  end
  def destroy
    @review = @movie.reviews.find(params[:id])
    if @review.user == current_user && @review.destroy
      redirect_to movie_reviews_url, status: :see_other, alert: "Review successfully deleted!"
    else
      render :index, danger: "Something went wrong. Please, try again!"
    end
  end
  def edit
    @review = @movie.reviews.find(params[:id])
  end
  def update
    @review = @movie.reviews.find(params[:id])
    if @review.user == current_user && @review.update(review_params)
      redirect_to movie_reviews_path(@movie), status: :see_other, notice: "Review successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end
  private
  def review_params
    params.require(:review).permit(:stars, :comment)
  end
  def set_movie
    @movie = Movie.find(params[:movie_id])
  end
end
