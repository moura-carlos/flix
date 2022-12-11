class MoviesController < ApplicationController
  before_action :find_movie, only: [:show, :edit, :update]
  def index
    @movies = Movie.all
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


  private
  def movie_params
    params.require(:movie).permit(:title, :rating, :total_gross, :description, :released_on)
  end
  def find_movie
    @movie = Movie.find(params[:id])
  end
end
