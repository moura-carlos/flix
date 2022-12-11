class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update, :destroy]
  def index
    # select movies that have been released and order from newest released to oldest
    @movies = Movie.released
  end

  def show; end

  def edit; end

  def update
    # @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, status: :see_other
    else
      render :edit
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, status: :see_other
    else
      render :new
    end
  end

  def destroy
    if @movie.destroy
      redirect_to root_url, status: :see_other, notice: "Movie successfully deleted!"
    else
      render :show
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :rating, :total_gross, :description, :released_on)
  end
  def find_movie
    @movie = Movie.find(params[:id])
  end
end
