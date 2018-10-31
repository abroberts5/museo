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
end
