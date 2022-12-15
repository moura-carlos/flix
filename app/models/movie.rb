class Movie < ApplicationRecord
  before_save :set_slug
  # has_many :reviews, dependent: :destroy
  has_many :reviews, -> { order(created_at: :desc) }, dependent: :destroy
  has_many :favorites, dependent: :destroy
  has_many :characterizations, dependent: :destroy
  has_many :fans, through: :favorites, source: :user
  has_many :genres, through: :characterizations#, source: :genre

  has_one_attached :main_image

  RATINGS = %w(G PG PG-13 R NC-17)

  validates :title, :released_on, :duration, presence: true
  validates :title, uniqueness: true
  validates :description, length: { minimum: 25 }
  validates :total_gross, numericality: { greater_than_or_equal_to: 0 }
=begin
  validates :image_file_name, format: {
    with: /\w+\.(jpg|png)\z/i,
    message: "Must be a JPG or PNG format"
  }
=end
  validates :rating, inclusion: { in: RATINGS }
  validate :acceptable_image

  scope :released, -> { where("released_on < ?", Time.now).order("released_on desc") }
  scope :upcoming, -> { where("released_on > ?", Time.now).order("released_on asc") }
  scope :recent, -> (max = 5) { released.limit(max) } # returns an arbitrary number of released movies, by default returs 5
  scope :flops, -> { released.where("total_gross < 22500000").order(total_gross: :asc) }
  scope :hits, -> { released.where("total_gross   >= 300000000").order("total_gross desc") }
  scope :grossed_less_than, -> (amount) { released.where("total_gross < ?", amount) }
  scope :grossed_greater_than, -> (amount) { released.where("total_gross > ?", amount) }
  def flop?
    (self.reviews.size < 50 && self.average_stars < 4.0) &&
      (total_gross.blank? || total_gross < 225_000_000)
    # taking into consideration cult classic movies
    # movie.reviews.size > 50 && movie.average_stars >= 4.0
    # then the movie shouldn't be a flop regardless of the total gross
  end

=begin
  def self.released
    # select movies that have been released and order from newest released to oldest
    where("released_on < ?", Time.now).order("released_on desc")
  end
=end

  # upcoming -> all the movies that have not yet been released, ordered with the soonest first.
=begin
  def self.upcoming
    where("release_on > ?", Time.now).order("released_on asc")
  end
=end

  # getting the average number of stars for the reviews given to a movie
  def average_stars
    # movie.reviews.average(:stars).to_s
    # if movie does not have any reviews return 0.0 as the average
    reviews.average(:stars) || 0.0
  end

  def average_stars_as_percent
    (self.average_stars / 5.0) * 100
  end

  # overriding the default value returned by the to_param method
  def to_param
    slug
  end

  private
  def set_slug
    self.slug = title.parameterize
  end

  def acceptable_image
    return unless main_image.attached?

    unless main_image.blob.byte_size <= 1.megabyte
      errors.add(:main_image, "is too big")
    end
    acceptable_types = ["image/jpeg", "image/png"]

    unless acceptable_types.include?(main_image.content_type)
      errors.add(:main_image, "must be a JPEG or PNG")
    end
  end
end
