import random

secret_number = random.randint(1, 5)
guess = int(input("Я загадал число от 1 до 5. Попробуй угадать! "))

if guess == secret_number:
    print("Ты угадал!")
elif guess > secret_number:
    print("Слишком много!")
else:
    print("Слишком мало!")
