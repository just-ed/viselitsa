# Класс, с помощью которого получаем загаданное слово
class WordReader
  # Метод для получения загаданного слова из консоли
  def read_from_args
    ARGV[0]
  end

  # Метод для получения загаданного слова из файла со словами
  def read_from_file(file_name)
    lines = File.readlines(file_name)

    lines.sample.chomp
  end
end
