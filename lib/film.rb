require 'date'

class Film
  attr_reader :producer

  def initialize(number_rate, title, year, producer, genre)
    @number_rate = number_rate(number_rate)
    @title = title
    @producer = producer
    @year = year
    @genre = genre(genre)
  end

  def to_s
    "#{@number_rate} #{@producer} - #{@title}#{@genre} (#{@year})"
  end

  private

  def number_rate(number_rate)
    if number_rate.nil?
      'Личная коллекция!!!'
    else
      "Номер #{number_rate} по рейтингу IMDB(#{Date.today.strftime('%d %b %Y')})!!!"
    end
  end

  def genre(genre)
    if genre.nil?
      ', Любимое'
    else
      ", #{genre}"
    end
  end
end
