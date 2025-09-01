# Вводные данные:
student_data = [
    {'name': 'Алексей', 'scores': [85, 92, 78, 95]},
    {'name': 'Марина', 'scores': [65, 70, 58, 82]},
    {'name': 'Светлана', 'scores': [98, 95, 100]}
]

# Создадим функцию которая принимает список оценок
# и опциональный параметр ignore_lowest
# Чтобы функция могла работать в двух режимах
# По дефолту он будет false
def calculate_average_score(scores, ignore_lowest=False):
    # Если количество оценок больше одной,
    # Удалим худшую оценку
    # ignore_lowest = true
    if ignore_lowest and len(scores) > 1:
        # Создаем копию списка без самой низкой оценки
        scores_to_use = scores.copy()
        # И удаляем минимальную оценку
        scores_to_use.remove(min(scores_to_use))
    else:
        # Если оценка одна
        # Значит это все, с чем мы работаем
        # Будем выводить ее,
        # Или
        scores_to_use = scores
     # Вычисляем среднее значение, это сумма использованных оценок
    # разделенная на длинну списка (количество оценок)
    average = sum(scores_to_use) / len(scores_to_use)
    return average

# Проходим по списку студентов, первый раз учитываем все оценки
# И смотрим с точностью до двух знаков
print("Средний балл без отброса худшей оценки с точностью до сотых:")
for student in student_data:
    avg_score = calculate_average_score(student['scores'])
    # Точность вывода средней оценки avg_score:.2f
    # Два знака после запятой
    print(f"{student['name']}: {avg_score:.2f}")

# Второй раз — отбросив худшие оценки
# С точностью до
print("\nСредний балл с отбрасыванием худшей оценки с точностью до десятых:")
for student in student_data:
    avg_score = calculate_average_score(student['scores'], ignore_lowest=True)
    print(f"{student['name']}: {avg_score:.1f}")
