# Класс для печати промежуточных и итоговых результатов игры
class ResultPrinter
  def initialize(game)
    # Массив с псевдографикой (7 "картинок")
    @status_image = []

    # Устанавливаем счетчик цикла
    counter = 0

    # Цикл, в котором в @status_image записывется содержимое файлов с псевдографикой
    # Индекс элемента в массиве соответствует количеству ошибок польлзователя
    until counter > game.max_mistakes
      # Записываем ссылку на путь к файлу с псевдографикой в переменную file_name
      file_name = "#{__dir__}/../image/#{counter}.txt"

      # Проверяем существует ли файл
      if File.exist?(file_name)
        # Если да, то прочитать его содержимое и добавить в @status_image
        file = File.new(file_name, "r:UTF-8")
        @status_image << file.read
        file.close
      else
        # Если файл не найден, то заменить его "заглушкой"
        @status_image << "\n [ изображение не найдено ] \n"
      end

      # Инкрементируем счетчик
      counter += 1
    end
  end

  # Метод, выводящий на экран изображение виселицы в зависимости от количества ошибок
  def print_viselitsa(mistakes)
    puts @status_image[mistakes]
  end

  # Метод, выводящий на экран текущий статус игры
  def print_status(game)
    # Очищаем экран
    cls

    puts
    # Выводим на экран угадываемое слово с подчеркиваниями
    puts "Слово: #{get_word_for_print(game.letters, game.good_letters)}"

    # Выводим через запятую список неправильных букв, введенных пользователем
    puts "Ошибки: #{game.bad_letters.join(", ")}"

    # Вызываем метод print_viselitsa для текущего количества ошибок
    print_viselitsa(game.mistakes)

    # Если пользователь проиграл, сообщить ему об этом и показать загаданное слово
    if game.lost?
      puts "\nВы проиграли :(\n\n"
      puts "Загаданное слово было: " + game.letters.join("")
      puts
    # Если выиграл - поздравить
    elsif game.won?
      puts "\nПоздравляем, вы выиграли!\n\n"
    # Если игра не завершена, сообщить количество оставшихся ошибок
    else
      puts "У вас осталось ошибок: #{game.mistakes_left}"
    end
  end

  # Метод, выводящий на экран угадываемое слово с подчеркиваниями
  def get_word_for_print(letters, good_letters)
    result = ''

    letters.each do |letter|
      result +=
        if good_letters.include?(letter)
          letter + ' '
        else
          '_ '
        end
    end

    result
  end

  def cls
    system("clear") || system("cls")
  end
end
