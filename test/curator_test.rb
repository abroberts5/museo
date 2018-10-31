require 'minitest/autorun'
require 'minitest/pride'
require './lib/curator'
require './lib/artist'
require './lib/photograph'
require 'csv'

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

  def test_it_can_find_photos_by_artists_name
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
                }

    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
                }

    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
                }

    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
                }

    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
                }

    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
                }

    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
                }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    diane_arbus = curator.find_artist_by_id("3")
    assert_equal [photo_3, photo_4], curator.find_photographs_by_artist(diane_arbus)
  end

  def test_it_returns_array_of_artists_with_multiple_photos
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
                }

    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
                }

    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
                }

    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
                }

    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
                }

    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
                }

    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
                }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    assert_equal [artist_3], curator.artists_with_multiple_photographs
    assert_equal 1, curator.artists_with_multiple_photographs.length
    assert artist_3 == curator.artists_with_multiple_photographs.first
  end

  def test_it_can_return_array_of_photos_taken_by_artist_from_country
    curator = Curator.new
    photo_1 = {
      id: "1",
      name: "Rue Mouffetard, Paris (Boy with Bottles)",
      artist_id: "1",
      year: "1954"
                }

    photo_2 = {
      id: "2",
      name: "Moonrise, Hernandez",
      artist_id: "2",
      year: "1941"
                }

    photo_3 = {
      id: "3",
      name: "Identical Twins, Roselle, New Jersey",
      artist_id: "3",
      year: "1967"
                }

    photo_4 = {
      id: "4",
      name: "Child with Toy Hand Grenade in Central Park",
      artist_id: "3",
      year: "1962"
                }

    artist_1 = {
      id: "1",
      name: "Henri Cartier-Bresson",
      born: "1908",
      died: "2004",
      country: "France"
                }

    artist_2 = {
      id: "2",
      name: "Ansel Adams",
      born: "1902",
      died: "1984",
      country: "United States"
                }

    artist_3 = {
      id: "3",
      name: "Diane Arbus",
      born: "1923",
      died: "1971",
      country: "United States"
                }

    curator.add_photograph(photo_1)
    curator.add_photograph(photo_2)
    curator.add_photograph(photo_3)
    curator.add_photograph(photo_4)

    curator.add_artist(artist_1)
    curator.add_artist(artist_2)
    curator.add_artist(artist_3)

    assert_equal [photo_2, photo_3, photo_4],curator.photographs_taken_by_artists_from("United States")
    assert_equal [], curator.photographs_taken_by_artists_from("Argentina")
  end

  def test_it_can_show_photos_taken_in_year_range
    curator = Curator.new
    curator.load_photographs('./data/photographs.csv')
    curator.load_artists('./data/artists.csv')
    assert_equal [1, 2], curator.photographs_taken_between(1950..1965)
  end
end
