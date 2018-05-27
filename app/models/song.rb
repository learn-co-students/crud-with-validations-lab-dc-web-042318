class Song < ActiveRecord::Base
  validates :title, :artist_name, presence: true
  validates :title, uniqueness: {
    scope: [:release_year, :artist_name],
    message: 'song already submitted'
  }
  validates :released, inclusion: { in: [true, false] }
  with_options if: :released do |song|
    song.validates :release_year, presence: true
    song.validates :release_year, numericality: { less_than: Time.now.year }
  end
end
