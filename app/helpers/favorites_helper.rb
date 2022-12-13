module FavoritesHelper
  def fave_or_unfave_button(favorite, movie)
    if favorite
      button_to "Unfave", movie_favorite_path(movie_id: movie.id, id: favorite.id), method: :delete
    else
      button_to "♥️ Fave", movie_favorites_path(movie)
    end
  end
end
