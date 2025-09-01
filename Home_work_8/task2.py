# Грязные данные
row_email = " USER@DOMAIN.COM "

# Удаляем лишние пробелы
cleaned_email = row_email.strip()
# Выведем для проверки
print(cleaned_email)
# Переведем в нижний регистр
normalized_email = cleaned_email.lower()
# Выведем для проверки
print(normalized_email)
# Разделим на имя пользователя и домен
# c помощью split()
# Супер удобно, что можно присвоить значение двух переменным
# в одном выражении
# В Java так нельзя было делать
username, domain = normalized_email.split("@")
# формируем и выводим результат
result_string = f"Username: {username}, Domain: {domain}"
print(result_string)
