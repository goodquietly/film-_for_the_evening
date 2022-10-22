# frozen_string_literal: true

require_relative 'lib/film'
require_relative 'lib/film_collection'
require_relative 'lib/film_parser'

collection =
  begin
    FilmParser.from_wiki_imdb250
  rescue StandardError
    FilmParser.from_local_file
  end

puts 'Программа «Фильм на вечер»'

collection.uniq_produsers_sort_by_name.each.with_index(1) do |producer, index|
  puts "#{index}. #{producer}"
end

puts 'Фильм какого режиссера вы хотите сегодня посмотреть?'
user_choice = nil

until (1..collection.number_of_uniq_producers).include?(user_choice)
  puts
  puts('Введите номер продюссера от 1 до ' \
       "#{collection.number_of_uniq_producers} и нажмите Enter (Выход - 0)")
  user_choice = STDIN.gets.to_i

  exit if user_choice == 0
end

puts 'И сегодня вечером рекомендую посмотреть:'
puts collection.film_for_the_evening(user_choice)
