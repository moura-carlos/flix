class Movie < ApplicationRecord
  def flop?
    total_gross.blank? || total_gross < 225_000_000
  end
  def self.released
    # select movies that have been released and order from newest released to oldest
    where("released_on < ?", Time.now).order("released_on desc")
  end
end
