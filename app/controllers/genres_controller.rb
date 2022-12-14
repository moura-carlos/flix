class GenresController < ApplicationController
  before_action :require_sign_in, except: [:index, :show]
  before_action :require_admin, except: [:index, :show]
  before_action :set_genre, except: [:index, :new, :create]

  def index
    @genres = Genre.all.order(:name)
  end

  def new
    @genre = Genre.new
  end

  def show
    # @genres = Genre.all.order(:name)
    # @movies = @genre.movies
    @genre = Genre.find(params[:id])
    @movies = @genre.movies
  end

  def create
    @genre = Genre.new(genre_params)
    if @genre.save
      redirect_to genres_path, status: :see_other, notice: "Genre successfully created!"
    else
      render :new, status: :unprocessable_entity, danger: "Oops, something went wrong! Please, try again!"
    end
  end

  def edit; end

  def update
    if @genre.update(genre_params)
      redirect_to genres_path, status: :see_other, notice: "Genre successfully updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if @genre.destroy
      redirect_to genres_url, status: :see_other, alert: "Genre successfully deleted!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def set_genre
    @genre = Genre.find(params[:id])
  end
  def genre_params
    params.require(:genre).permit(:name)
  end
end
