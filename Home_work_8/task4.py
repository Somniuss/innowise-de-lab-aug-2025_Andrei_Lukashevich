# Дано:
words = ["hello", "world", "python", "code"]

# Создадим список длин слов
# len(i) длина текущего слова
# for i in words проходим по каждому слову
# Круто, что мы как бы помещаем функцию (ее результат)
# в список, проходя по списку, в Java пришлось бы писать намного больше кода
word_lengths = [len(i) for i in words]
# Выводим результат
print(word_lengths)
# отфильтруем слова длиннее 4 символов if len(i) > 4
# for i in words проходим по каждому слову
# и добавляем i-е слово, если оно соответствует условию
# И здесь тоже очень круто, что можно внести условие
long_words = [i for i in words if len(i) > 4]
# Проверим
print(long_words)
# Создадим словарь с помощью dict comprehension
# Словарь = {ключ:значение}
word_dict = {i: len(i) for i in words}
# Выведем результат
print(word_dict)
