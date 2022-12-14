class Genre < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :characterizations, dependent: :destroy
  has_many :movies, through: :characterizations#, source: :movie
  #GENRES = Genre.all
end
