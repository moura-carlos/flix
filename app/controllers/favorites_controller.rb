class FavoritesController < ApplicationController
  before_action :require_sign_in
  before_action :set_movie

  def create
    @movie.favorites.create!(user: current_user)
    redirect_to @movie
  end

  def destroy
    #@favorite = @movie.favorites.find(params[:id])
    # making sure we only delete the favorite that was created by the currently logged in user.
    favorite = current_user.favorites.find(params[:id])
    if favorite.destroy
      # @movie is coming from the before action method :set_movie
      redirect_to @movie, danger: "This is no longer your favorite movie"
    end
  end

  private

  def set_movie
    @movie = Movie.find_by!(slug: params[:movie_id])
  end
end
