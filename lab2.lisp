(defun spread-values (lst)
  (let ((prev nil))
    (if (null lst)
        nil
        (let ((current (car lst)))
          (if (null current)
              (cons prev (spread-values (cdr lst)))  
              (cons current (spread-values (cdr lst))))))))

(defun delete-duplicates-sequence (lst n)
  (labels ((helper (lst prev count)
             (cond
               ((null lst) nil)
               ((equal (car lst) prev)
                (if (< count n)
                    (cons (car lst) (helper (cdr lst) prev (1+ count)))
                    (helper (cdr lst) prev count)))
               (t
                (cons (car lst) (helper (cdr lst) (car lst) 1))))))
    (if (null lst)
        nil
        (cons (car lst) (helper (cdr lst) (car lst) 1)))))

(defun check-spread-values (name lst &key expected)
  (format t "~:[FAILED~;passed~]... ~a~%" 
          (equal (spread-values lst) expected) 
          name))

(defun check-delete-duplicates-sequence (name lst n &key expected)
  (format t "~:[FAILED~;passed~]... ~a~%" 
          (equal (delete-duplicates-sequence lst n) expected) 
          name))

(defun test-spread-values ()
  (check-spread-values "Regular input" '(nil 1 2 nil 3 nil nil 4 5) :expected '(nil 1 2 2 3 3 3 4 5))
  (check-spread-values "All nils" '(nil nil nil) :expected '(nil nil nil))
  (check-spread-values "No nils" '(1 2 3) :expected '(1 2 3))
  (check-spread-values "Mixed nils" '(nil 1 nil 2 nil nil 3 nil) :expected '(nil 1 1 2 2 2 3 3)))

(defun test-delete-duplicates-sequence ()
  (check-delete-duplicates-sequence "Regular input" '(1 1 2 3 3 3 2 2 a a a b) 3 :expected '(1 1 2 3 2 2 a b))
  (check-delete-duplicates-sequence "No duplicates" '(1 2 3 4 5) 3 :expected '(1 2 3 4 5))
  (check-delete-duplicates-sequence "All duplicates" '(1 1 1 1 1 1) 3 :expected '(1 1))
  (check-delete-duplicates-sequence "Different length sequence" '(1 1 2 2 2 3 3 3 4 4) 2 :expected '(1 1 2 2 3 3 4 4)))

(test-spread-values)
(test-delete-duplicates-sequence)
