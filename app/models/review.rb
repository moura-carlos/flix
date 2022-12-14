class Review < ApplicationRecord
  belongs_to :movie
  belongs_to :user

  STARS = (1..5).to_a

  # validates :name, presence: true
  validates :comment, length: { minimum: 4 }
  validates :stars, inclusion: {
    in: STARS,
    message: "must be between 1 and 5"
  }

  # reviews that have been written in the past n days.
  scope :past_n_days, -> (days) { where("created_at >= ?", days.days.ago)}

  def stars_as_percent
    (stars / 5.0) * 100.0
  end

end
