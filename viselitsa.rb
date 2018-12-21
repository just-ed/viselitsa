# Подключаем файлы с классами Game, ResultPrinter и WordReader
require_relative "game"
require_relative "result_printer"
require_relative "word_reader"

# Создаем экземпляр класса ResultPrinter, сохраняем ссылку на него в переменную printer
# С его помощью будем выводить на экран текущий статус игры и итоговый результат игры
printer = ResultPrinter.new

# Создаем экземпляр класса WordReader, сохраняем ссылку на него в переменную word_reader
# С его помощью получаем загаданное слово
word_reader = WordReader.new

# Записываем в переменную words_file_name ссылку на путь к файлу с загадываемыми словами
words_file_name = "#{__dir__}/data/words.txt"

# Создаем экземпляр класса Game
# В качестве параметра передаем случайно выбранное слово из файла words.txt
begin
  game = Game.new(word_reader.read_from_file(words_file_name))
rescue NoMethodError
  abort "Слово не загадано, отгадывать нечего :("
end

# Основной цикл игры. Игра продолжается до тех пор, пока статус не изменится
# status ==  0 - слово еще не отгадано, ошибок меньше 7
# status ==  1 - слово отгадано, победа
# status == -1 - слово не отгадано, совершено 7 ошибок - поражение
while game.status == 0
  printer.print_status(game)
  game.ask_next_letter
end

# Выводим на экран итоговый результат
printer.print_status(game)
