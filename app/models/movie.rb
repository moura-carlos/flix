class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :characterizations, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :genres, through: :characterizations#, source: :genre

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :title, :released_on, :duration, presence: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "Must be a JPG or PNG format"
  }
  validates :rating, inclusion: { in: RATINGS }

  def flop?
    (self.reviews.size < 50 && self.average_stars < 4.0) &&
      (total_gross.blank? || total_gross < 225_000_000)
    # taking into consideration cult classic movies
    # movie.reviews.size > 50 && movie.average_stars >= 4.0
    # then the movie shouldn't be a flop regardless of the total gross
  end

  def self.released
    # select movies that have been released and order from newest released to oldest
    where("released_on < ?", Time.now).order("released_on desc")
  end

  # getting the average number of stars for the reviews given to a movie
  def average_stars
    # movie.reviews.average(:stars).to_s
    # if movie does not have any reviews return 0.0 as the average
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (self.average_stars / 5.0) * 100
  end

end
