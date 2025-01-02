<p align="center"><b>МОНУ НТУУ КПІ ім. Ігоря Сікорського ФПМ СПіСКС</b></p>
<p align="center">
<b>Звіт з лабораторної роботи 2</b><br/>
"Рекурсія"<br/>
дисципліни "Вступ до функціонального програмування"
</p>
<p align="right"><b>Студент</b>: Приліпко Максим Олександрович КВ-13</p>
<p align="right"><b>Рік</b>: 2025</p>

## Загальне завдання

Реалізуйте дві рекурсивні функції, які виконують певні дії зі списками, використовуючи різні типи рекурсії (за необхідністю). Функції визначаються варіантом (п. 2.1.1). Вимоги:

1. Має змінюватися через створення нового, а не зміну вхідного.
2. Не використовуйте функції вищого порядку або стандартні функції зі списками (окрім наведених у розділі 4 посібника).
3. Функція не повинна приймати інші функції як аргументи.
4. Не можна використовувати псевдофункції (деструктивний підхід).
5. Не можна використовувати цикли.

Функції потрібно протестувати з різними наборами даних. Тести оформити як модульні (п. 2.3).

## Варіант 15

Написати функцію spread-values , яка заміняє nil в списку на попередній не-nil елемент:

CL-USER> (spread-values ‘(nil 1 2 nil 3 nil nil 4 5))
(NIL 1 2 2 3 3 3 4 5)

2. Написати функцію delete-duplicates-sequence , яка видаляє всі послідовні дублікати тих 
елементів з вхідного списку атомів, послідовних дублікатів яких більше за задане число:

CL-USER> (delete-duplicates-sequence '(1 1 2 3 3 3 2 2 a a a b) 3)
(1 1 2 3 2 2 A B)

## Лістинг функції spread-values

```lisp
(defun spread-values (lst)
  (let ((prev nil))
    (if (null lst)
        nil
        (let ((current (car lst)))
          (if (null current)
              (cons prev (spread-values (cdr lst)))  
              (cons current (spread-values (cdr lst))))))))
```

### Тестові набори

```lisp
(defun test-spread-values ()
  (check-spread-values "Regular input" '(nil 1 2 nil 3 nil nil 4 5) :expected '(nil 1 2 2 3 3 3 4 5))
  (check-spread-values "All nils" '(nil nil nil) :expected '(nil nil nil))
  (check-spread-values "No nils" '(1 2 3) :expected '(1 2 3))
  (check-spread-values "Mixed nils" '(nil 1 nil 2 nil nil 3 nil) :expected '(nil 1 1 2 2 2 3 3)))
```

```lisp
CL-USER> (test-spread-values)
passed... Regular input
passed... No duplicates
passed... All duplicates
passed... Different length sequence

```

## Лістинг функції delete-duplicates-sequence
```lisp
(defun delete-duplicates-sequence (lst n)
  (let ((prev nil) (count 0))
    (if (null lst)
        nil
        (let ((current (car lst)))
          (if (eq current prev)  
              (if (>= count n)  
                  (delete-duplicates-sequence (cdr lst) n)
                  (progn
                    (setq count (1+ count))  
                    (cons current (delete-duplicates-sequence (cdr lst) n))))
              (progn
                (setq count 1) 
                (cons current (delete-duplicates-sequence (cdr lst) n))))))))
```

### Тестові набори

```lisp
(defun test-delete-duplicates-sequence ()
  (check-delete-duplicates-sequence "Regular input" '(1 1 2 3 3 3 2 2 a a a b) 3 :expected '(1 1 2 3 2 2 a b))
  (check-delete-duplicates-sequence "No duplicates" '(1 2 3 4 5) 3 :expected '(1 2 3 4 5))
  (check-delete-duplicates-sequence "All duplicates" '(1 1 1 1 1 1) 3 :expected '(1 1))
  (check-delete-duplicates-sequence "Different length sequence" '(1 1 2 2 2 3 3 3 4 4) 2 :expected '(1 1 2 2 3 3 4 4)))
```

### Тестування

```lisp
CL-USER> (test-spread-values)
passed... Regular input
passed... All nils
passed... No nils
passed... Mixed nils
```
