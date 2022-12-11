class Movie < ApplicationRecord
  has_many :reviews, dependent: :destroy

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
    total_gross.blank? || total_gross < 225_000_000
  end

  def self.released
    # select movies that have been released and order from newest released to oldest
    where("released_on < ?", Time.now).order("released_on desc")
  end

end
