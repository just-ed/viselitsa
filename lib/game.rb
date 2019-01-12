# Класс, с помощью которого реализуется процесс игры
class Game
  attr_reader :mistakes, :status, :letters, :good_letters, :bad_letters

  attr_accessor :version

  MAX_MISTAKES = 7

  def initialize(word)
    # Сохраняем в поле класса @letters загаданное слово, полученное из метода get_letters
    @letters = get_letters(word)
    # Количество ошибок. Начальное значение - 0
    @mistakes = 0

    # Массив "хороших" букв, в который попадают отгаданные буквы
    @good_letters = []
    # Массив "плохих" букв, введенных пользователем и не входящих в загаданное слово
    @bad_letters = []

    # Текущий статус игры
    # :in_progress - в процессе игры
    # :won - победа
    # :lost - поражение
    @status = :in_progress
  end

  # Метод возвращает загаданное слово в виде массива букв
  def get_letters(word)
    word.encode('UTF-8').downcase.split("")
  end

  def max_mistakes
    MAX_MISTAKES
  end

  def mistakes_left
    MAX_MISTAKES - @mistakes
  end

  def good?(letter)
    @letters.include?(letter) ||
    (letter == "е" && @letters.include?("ё")) ||
    (letter == "ё" && @letters.include?("е")) ||
    (letter == "и" && @letters.include?("й")) ||
    (letter == "й" && @letters.include?("и"))
  end

  def add_letter_to(letters, letter)
    # Если введенная буква входит в загаданное слово - положить её в массив "хороших" букв
    letters << letter
    # Также делаем буквы е-ё и и-й равноценными:
    # Если введена "е", а в слове есть "ё" (и наоборот) - добавить обе буквы в "хорошие"
    # Если введена "и", а в слове есть "й" (и наоборот) - добавить обе буквы в "хорошие"
    case letter
    when 'ё' then letters << 'е'
    when 'е' then letters << 'ё'
    when 'и' then letters << 'й'
    when 'й' then letters << 'и'
    end
  end

  def solved?
    (@letters - @good_letters).empty?
  end

  def repeated?(letter)
    @good_letters.include?(letter) || @bad_letters.include?(letter)
  end

  def is_valid?(letter)
    ("а".."я").include?(letter)
  end

  def lost?
    @status == :lost
  end

  def in_progress?
    @status == :in_progress
  end

  def won?
    @status == :won
  end


  # Метод, определяющий что надо сделать после ввода пользователя
  def next_step(letter)
    letter = letter.downcase
    # Делаем предварительные проверки на случай, если пользователь уже выиграл или проиграл
    return if @status == :lost || @status == :won
    # или если он повторно ввел введеную ранее букву
    return if repeated?(letter)

    if good?(letter)
      # Если буква подходит - добавляем ее в массив "хороших"
      add_letter_to(@good_letters, letter)

      @status = :won if solved?

    else
      # Если буква не подходит - добавляем ее в массив "плохих" букв
      add_letter_to(@bad_letters, letter)

      # Увеличиваем счетчик ошибок на 1
      @mistakes += 1

      # Если пользователь ошибся 7 раз - проигрыш
      @status = :lost if @mistakes >= MAX_MISTAKES
    end
  end

  # Метод, запрашивающий у пользователя ввод буквы
  def ask_next_letter
    # Запрашивать ввод пользователя, пока он не введет букву из массива valid_letters
    letter = ""
    until is_valid?(letter)
      print "\nВведите следующую букву: "
      letter = STDIN.gets.encode("UTF-8").chomp
    end

    # Вызываем метод next_step, передаем ему введенную пользователем букву
    next_step(letter)
  end
end
