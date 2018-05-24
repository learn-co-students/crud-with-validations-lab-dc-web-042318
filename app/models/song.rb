class Song < ActiveRecord::Base
	validates :title, presence:true
	validates :artist_name, presence:true
	validate :no_repetition
	validate :release_check

	def no_repetition
		song = Song.find_by(title: self.title)
		if !song.nil? && song.id != self.id
			if song.artist_name == self.artist_name && song.release_year == self.release_year
				self.errors.add(:title, "the song exist in the database")
				false
			end
		else
			true
		end
	end

	def release_check
		if self.released == true
			if self.release_year.nil? || self.release_year > Time.now.year
				self.errors.add(:release_year, "Invalid release date")
				false
			end
		else
			true
		end
	end
end
