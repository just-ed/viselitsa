# Игра "Виселица" на Ruby

## Правила игры
Игроку загадывается слово, которое нужно отгадать по буквам не более чем за 7 попыток.  
Если игрок угадал букву, открываются все вхождения этой буквы в слове.  
Если игрок не угадал букву, эта буква добавляется в список ошибочных, количество ошибок увеличивается на 1.

## Как запустить игру
```
bundle install
bundle exec ruby viselitsa.rb
```

## Как добавить новые слова
Откройте файл **"words.txt"** в папке **"data"**, введите желаемые слова в файл.   
Каждое слово должно начинаться с новой строки.  
Сохраните и закройте файл. Теперь можно запускать игру и отгадывать новые слова :)
