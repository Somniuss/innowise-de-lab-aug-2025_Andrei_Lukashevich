# Исходный список
fruits = ["apple", "banana"]

# list.append(x) добавляет элемент в конец списка
fruits.append("orange")
# Проверяем
print(fruits)
# list.insert(i, x) Вставка элемента по индексу
fruits.insert(0, "grape")
# Проверяем
print(fruits)
# list.remove(x) Удаляет первое вхождение элемента x
fruits.remove("banana")
# Проверяем
print(fruits)
# list.sort() Сортирует список на месте (in-place)
fruits.sort()
# Проверяем
print(fruits)
# list.reverse() Разворачивает порядок элементов в списке
fruits.reverse()
# Проверяем
print(fruits)
