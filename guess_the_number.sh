#!/bin/bash

### Блок функций
# Создаем функцию для проверки числа больше нуля
is_number () {
    # Возвращаем количество символов или ноль, если это не число
    SYM_COUNT=$(expr match "$1" "^[0-9]*$");
    test "$SYM_COUNT" -eq "0" && return 1;
    return 0;
}

# Создаем функцию, в которой весь ход игры
game () {
    # Счетчик, считаем кол-во шагов
    COUNT=0;

    # До тех пор, пока он меньше либо равен кол-ву попыток
    while test "$COUNT" -le "$TRY_COUNT"
    do
        # Просим ввести число
        read -p"> " INPUT;

        # Проверяем что пользователь действительно ввёл число
        is_number "$INPUT" || {
            echo "Я загадал число, а не слово";
            continue;
        }

        # Увеличиваем счетчик на +1
        let COUNT+=1;

        # Проверяем не угадал ли игрок
        test "$INPUT" -lt "$RND" && {
            echo "Слишком маленькое число, нужно больше!";
            continue;
        }

        test "$INPUT" -gt "$RND" && {
            echo "Число слишком большое!";
            continue;
        }

        echo "Поздравляю! Ты угадал с $COUNT-й попытки";
        break;
    done

    # По завершению работы функции возвращаемся в точку вызова
}
###

### Блок переменных
# Максимально задуманное число
MAX_NUMBER=100;
# Количество попыток
TRY_COUNT=8;
# Случайное задуманное число
RND=$(($RANDOM%$MAX_NUMBER));
###

### Основной цикл программы
# Стартовое приглашение
echo "Хочешь выиграть авторучку?";
echo "Тогда угадай, какое я задумал число от 0 до $MAX_NUMBER";
echo "У тебя $TRY_COUNT попыток :)";
# Запускаем цикл
while true
do
    # Точка вызова функции game
    game;

    # После завершения игры спрашиваем сыграем ли еще
    read -p "Хочешь сыграть еще? (Yes/No) " QUERY;

    # Проверяем что ввел пользователь
    case $QUERY in
        # Если согласен, то генерируем новое число и цикл while повторяется
        [Yy][Ee][Ss] | [Yy])
            echo "Отлично! Я как раз задумал новое число!";
            RND=$(($RANDOM%$MAX_NUMBER));
        ;;
        # Если не согласен - прерываем цикл while
        [Nn][Oo] | [Nn])
            echo "Очень жаль! Мне будет скучно :(";
            break;
        ;;
        # Если ввел бред, тоже прерываем цикл
        *)
            echo "Ты невменяем! Я с такими не играю!";
            break;
        ;;
    esac
done
###

# Выход из программы
exit 0;

