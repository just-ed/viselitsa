require_relative 'lib/game'
require_relative 'lib/result_printer'
require_relative 'lib/word_reader'
require 'unicode_utils'

VERSION = 'Игра "Виселица", версия 5. (с) Хороший программист'

words_file_name = "#{__dir__}/data/words.txt"
word = WordReader.new.read_from_file(words_file_name)

begin
  game = Game.new(word)
rescue NoMethodError
  abort "Слово не загадано, отгадывать нечего :("
end

game.version = VERSION

printer = ResultPrinter.new(game)

while game.in_progress?
  printer.print_status(game)
  game.ask_next_letter
end

# Выводим на экран итоговый результат
printer.print_status(game)
