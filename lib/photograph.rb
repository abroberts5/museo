class Photograph
  attr_reader     :id,
                  :name,
                  :artist_id,
                  :year
                  
  def initialize(data_info)
    @id = data_info[:id]
    @name = data_info[:name]
    @artist_id = data_info[:artist_id]
    @year = data_info[:year]
  end
end
