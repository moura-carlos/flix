class MoviesController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :find_movie, only: [:show, :edit, :update, :destroy]
  def index
    # select movies that have been released and order from newest released to oldest
    @movies = Movie.released
  end

  def show
    @fans = @movie.fans
    @genres = @movie.genres.order(:name)
    if current_user
      @favorite = current_user.favorites.find_by(movie_id: @movie.id)
    end
  end

  def edit; end

  def update
    # @movie = Movie.find(params[:id])
    if @movie.update(movie_params)
      redirect_to @movie, status: :see_other, notice: "Movie successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.new(movie_params)
    if @movie.save
      redirect_to @movie, status: :see_other, notice: "Movie successfully created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    # redirect_to movies_url, status: :see_other, danger: "I can't do that!"
    if @movie.destroy
      redirect_to movies_url, status: :see_other, alert: "Movie successfully deleted!"
    else
      render :show, danger: "Something went wrong! Please, try again."
    end
  end

  private
  def movie_params
    params.require(:movie).permit(:title, :rating, :total_gross, :description, :released_on, :director, :duration, :image_file_name, genre_ids: [])
  end
  def find_movie
    @movie = Movie.find(params[:id])
  end
end
