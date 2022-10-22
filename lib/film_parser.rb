require 'addressable/uri'
require 'nokogiri'
require 'open-uri'

module FilmParser
  extend self

  WIKI_IMDB250_URL = 'https://ru.wikipedia.org/wiki/250_лучших_фильмов_по_версии_IMDb'

  def from_wiki_imdb250
    html = Nokogiri::HTML(URI.open(Addressable::URI.parse(WIKI_IMDB250_URL).normalize, &:read))
    films = html.css('tr')[1..250].map do |node|
      Film.new(node.css('td')[0].text.to_i,
               node.css('td')[1].text.chomp,
               node.css('td')[2].text.to_i,
               node.css('td')[3].text.chomp,
               node.css('td')[4].text.chomp)
    end

    FilmCollection.new(films)
  end

  def from_local_file
    files = File.join(File.dirname(__dir__), 'data', '*.txt')

    file_lines = Dir[files].map do |file_line|
      File.readlines(file_line, chomp: true)
    end

    films = file_lines.map { |line| Film.new(nil, line[0], line[2], line[1], nil) }

    FilmCollection.new(films)
  end
end
