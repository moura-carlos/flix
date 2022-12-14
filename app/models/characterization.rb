class Characterization < ApplicationRecord
  belongs_to :movie
  belongs_to :genre

  # getting the genre_ids that have at least one movie associated with them.
  def self.get_genre_ids
    genre_ids = select(:genre_id).distinct.map do |element|
      element.genre_id
    end
  end
end
