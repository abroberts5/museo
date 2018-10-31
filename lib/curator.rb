class Curator
  attr_reader     :artists,
                  :photographs
  def initialize
    @artists     = []
    @photographs = []
  end

  def add_photograph(photos)
    @photographs << photos
  end

  def find_photograph_by_id(id)
    @photographs.find do |photo|
      photo[:id] == id
    end
  end

  def add_artist(artist_info)
    @artists << artist_info
  end

  def find_artist_by_id(id)
    @artists.find do |artist|
      artist[:id] == id
    end
  end

  def find_photographs_by_artist(artist)
    @photographs.find_all do |photo|
      photo[:artist_id] == artist[:id]
    end
  end

  def artists_with_multiple_photographs
    @artists.find_all do |artist|
      find_photographs_by_artist(artist).count > 1
    end
  end

  def photographs_taken_by_artists_from(country)
    photos = []
    new_list = @artists.find_all do |artist|
      artist[:country] == country
    end
    new_list.each do |artist|
      photos << find_photographs_by_artist(find_artist_by_id(artist[:id]))
    end
    photos.flatten
  end

end
