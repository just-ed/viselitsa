# Класс, с помощью которого реализуется процесс игры
class Game
  attr_reader :errors, :status, :letters, :good_letters, :bad_letters

  def initialize(slovo)
    # Сохраняем в поле класса @letters загаданное слово, полученное из метода get_letters
    @letters = get_letters(slovo)

    # Количество ошибок. Начальное значение - 0
    @errors = 0

    # Массив "хороших" букв, в который попадают отгаданные буквы
    @good_letters = []
    # Массив "плохих" букв, введенных пользователем и не входящих в загаданное слово
    @bad_letters = []

    # Текущий статус игры
    # status = 0 - в процессе игры
    # status = 1 - победа
    # status = - 1 - поражение
    @status = 0
  end

  # Метод возвращает загаданное слово в виде массива букв
  def get_letters(slovo)
    slovo.encode('UTF-8').split("")
  end

  # Метод, определяющий что надо сделать после ввода пользователя
  # Принимает в качестве параметра введеную букву
  def next_step(bukva)
    # Делаем предварительные проверки на случай, если пользователь уже выиграл или проиграл,
    # или если он повторно ввел введеную ранее букву
    return if @status == -1 || @status == 1

    return if @good_letters.include?(bukva) || @bad_letters.include?(bukva)

    # Если введенная буква входит в загаданное слово - положить её в массив "хороших" букв
    # Также делаем буквы е-ё и и-й равноценными:
    # Если введена "е", а в слове есть "ё" (и наоборот) - добавить обе буквы в "хорошие"
    # Если введена "и", а в слове есть "й" (и наоборот) - добавить обе буквы в "хорошие"
    if @letters.include?(bukva) ||
      (bukva == "е" && @letters.include?("ё")) ||
      (bukva == "ё" && @letters.include?("е")) ||
      (bukva == "и" && @letters.include?("й")) ||
      (bukva == "й" && @letters.include?("и"))

      good_letters << bukva

      good_letters << "ё" if bukva == "е"
      good_letters << "е" if bukva == "ё"
      good_letters << "й" if bukva == "и"
      good_letters << "и" if bukva == "й"

      # Вычитаем из массива букв загаданного слова массив отгаданных букв
      # если в результате получен пустой массив - изменить значение status на "1" - слово отгадано
      if (@letters - @good_letters).empty?
        @status = 1
      end

    # Если буква не входит в загаданное слово - добавить букву в массив "плохих" букв
    else
      @bad_letters << bukva
      # Увеличить счетчик ошибок на 1
      @errors += 1

      # Если пользователь ошибся 7 раз - изменить значение status на "-1" - поражение
      @status = -1 if @errors == 7
    end
  end

  # Метод, запрашивающий у пользователя ввод буквы
  def ask_next_letter
    # Массив букв русского алфавита
    valid_letters = "а".."я"

    # Запрашивать ввод пользователя, пока он не введет букву из массива valid_letters
    letter = ""
    until valid_letters.include?(letter)
      print "\nВведите следующую букву: "
      letter = STDIN.gets.encode("UTF-8").downcase.chomp
    end

    # Вызываем метод next_step, передаем ему введенную пользователем букву
    next_step(letter)
  end
end
