# тестовая строка
test_string = "Python Programming"

# Найдем длину строки и выведем ее
# len возвращает длину строки
print (f"Длина строки Python Programming: {len(test_string)}")

# выведем символ с индексом 7
# индекс символа по позиции в строке помещается в []
# и начинается с 0
seventh_symbol = test_string[7]
print (f"Седьмой символ в строке Python Programming это: {seventh_symbol}")

# выведем последние три символа
# отрицательные индексы начинаются с конца строки
# и начинаются с -1
# ИИ подсказывает, что можно так сделать
# three_last_symbols = test_string[-3:]
# но, поскольку в презентации этого не было, я решал так:
three_last_symbols = test_string[-3]+test_string[-2]+test_string[-1]
print (f"Последние три символа в строке Python Programming это: {three_last_symbols}")

# проверка находится ли подстрока в строке
# может быть решена, например, с помощью in
# if substring in test_string,
# а можно решить через срезы и цикл
substring = "gram"
# устанавливаем флаг
found = False
for i in range(len(test_string) - len(substring) + 1):
    if test_string[i:i+len(substring)] == substring:
        found = True
        # как только нашли выходим из цикла
        break

if found:
    print(f"Подстрока '{substring}' найдена!")
else:
    print(f"Подстрока '{substring}' не найдена.")
