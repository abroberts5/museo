require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/artist'
require './lib/photograph'

class CuratorTest < Minitest::Test
  def test_it_exists
    curator = Curator.new
    assert_instance_of Curator, curator
  end

  def test_artists_and_photographs_start_with_empty_array
    curator = Curator.new
    assert_equal [], curator.artists
    assert_equal [], curator.photographs
  end

  def test_it_can_add_photographs_to_array
    curator = Curator.new
    photo_1 = {id: "1",
               name: "Rue Mouffetard, Paris (Boy with Bottles)",
               artist_id: "1",
               year: "1954"}

    photo_2 = {name: "Moonrise, Hernandez",
               artist_id: "2",
               year: "1941"}

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    expected = "Rue Mouffetard, Paris (Boy with Bottles)"
    assert_equal [photo_1, photo_2], curator.photographs
    assert_equal photo_1, curator.photographs.first
    assert_equal expected, curator.photographs.first[:name]
  end

  def test_it_can_add_artists_to_array
    curator = Curator.new
    artist_1 = {id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"}

    artist_2 = {name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"}

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal [artist_1, artist_2], curator.artists
    assert_equal artist_1, curator.artists.first
    assert_equal "Henri Cartier-Bresson", curator.artists.first[:name]
  end

  def test_it_can_artists_by_id
    curator = Curator.new
    artist_1 = {id: "1",
                name: "Henri Cartier-Bresson",
                born: "1908",
                died: "2004",
                country: "France"}

    artist_2 = {name: "Ansel Adams",
                born: "1902",
                died: "1984",
                country: "United States"}

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)

    assert_equal artist_1, curator.find_artist_by_id("1")
  end

  def test_it_can_find_photographs_by_id
    curator = Curator.new
    photo_1 = {id: "1",
               name: "Rue Mouffetard, Paris (Boy with Bottles)",
               artist_id: "1",
               year: "1954"}

    photo_2 = {id: "2",
               name: "Moonrise, Hernandez",
               artist_id: "2",
               year: "1941"}

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)

    assert_equal photo_2, curator.find_photograph_by_id("2")
  end
end

#=> #<Photograph:0x00007fd3a1801278 @artist_id="2", @id="2", @name="Moonrise, Hernandez", @year="1941">
