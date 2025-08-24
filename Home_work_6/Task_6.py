def get_number(prompt):
    while True:
        try:
            return float(input(prompt))
        except ValueError:
            print("Ошибка: введено не число. Попробуйте снова.")

def get_operator(prompt):
    while True:
        op = input(prompt).strip()
        if op in ["+", "-", "*", "/"]:
            return op
        print("Ошибка: введите один из операторов (+, -, *, /). Попробуйте снова.")

while True:
    num1 = get_number("Введите первое число: ")
    num2 = get_number("Введите второе число: ")
    operator = get_operator("Введите оператор (+, -, *, /): ")

    if operator == "+":
        result = num1 + num2
    elif operator == "-":
        result = num1 - num2
    elif operator == "*":
        result = num1 * num2
    elif operator == "/":
        if num2 != 0:
            result = num1 / num2
        else:
            result = "Ошибка: деление на ноль!"

    print(f"{num1} {operator} {num2} = {result}")

    cont = input("Хотите выполнить ещё одну операцию? (да/нет): ").strip().lower()
    if cont != "да":
        print("Выход из калькулятора. До свидания!")
        break
