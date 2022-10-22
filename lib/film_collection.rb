# frozen_string_literal: true

class FilmCollection
  def initialize(films)
    @films = films
  end

  def uniq_produsers_sort_by_name
    @films.map(&:producer).uniq.sort
  end

  def number_of_uniq_producers
    uniq_produsers_sort_by_name.length
  end

  def film_for_the_evening(choice)
    @films.select do |film|
      film.producer == uniq_produsers_sort_by_name[choice - 1]
    end .sample.to_s
  end
end
