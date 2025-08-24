import random

while True:
    print("\nВыберите программу:")
    print("1 - Приветствие")
    print("2 - Площадь прямоугольника")
    print("3 - Конвертер температуры")
    print("4 - Угадай число")
    print("5 - Четное или нечетное")
    print("6 - Калькулятор")
    print("0 - Выход")

    choice = input("Ваш выбор: ")

    if choice == "1":
        name = input("Как тебя зовут? ")
        print(f"Привет, {name}! Приятно познакомиться.")

    elif choice == "2":
        length = int(input("Введите длину прямоугольника: "))
        width = int(input("Введите ширину прямоугольника: "))
        area = length * width
        print(f"Площадь прямоугольника: {area}")

    elif choice == "3":
        celsius = float(input("Введите температуру в градусах Цельсия: "))
        fahrenheit = (celsius * 9 / 5) + 32
        print(f"{celsius:.1f}°C это {fahrenheit:.1f}°F")

    elif choice == "4":
        secret_number = random.randint(1, 5)
        guess = int(input("Я загадал число от 1 до 5. Попробуй угадать! "))
        if guess == secret_number:
            print("Ты угадал!")
        elif guess > secret_number:
            print("Слишком много!")
        else:
            print("Слишком мало!")

    elif choice == "5":
        number = int(input("Введите целое число: "))
        if number % 2 == 0:
            print(f"Число {number} — четное.")
        else:
            print(f"Число {number} — нечётное.")

    elif choice == "6":
        while True:
            try:
                num1 = float(input("Введите первое число: "))
                num2 = float(input("Введите второе число: "))
                op = input("Введите оператор (+, -, *, /): ").strip()
            except ValueError:
                print("Ошибка: введено не число. Попробуйте снова.")
                continue

            if op == "+":
                result = num1 + num2
            elif op == "-":
                result = num1 - num2
            elif op == "*":
                result = num1 * num2
            elif op == "/":
                if num2 != 0:
                    result = num1 / num2
                else:
                    result = "Ошибка: деление на ноль!"
            else:
                result = "Ошибка: неверный оператор."

            print(f"{num1} {op} {num2} = {result}")

            cont = input("Хотите выполнить ещё одну операцию? (да/нет): ").strip().lower()
            if cont != "да":
                print("Выход из калькулятора.")
                break

    elif choice == "0":
        print("Выход. До свидания!")
        break
    else:
        print("Ошибка: выберите номер из списка.")
