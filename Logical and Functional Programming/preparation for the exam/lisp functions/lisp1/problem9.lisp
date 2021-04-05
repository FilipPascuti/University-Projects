;; 9.
;; a) Write a function that merges two sorted linear lists and keeps double values.
;; b) Write a function to replace an element E by all elements of a list L1 at all levels of a given list L.
;; c) Write a function to determines the sum of two numbers in list representation, and returns the
;; corresponding decimal number, without transforming the representation of the number from list to
;; number.
;; d) Write a function to return the greatest common divisor of all numbers in a linear list.

;; a)
(defun merge_lists (l1 l2)
(cond
((null l1) l2)
((null l2) l1)
((> (car l1) (car l2)) (cons (car l2) (merge_lists l1 (cdr l2))) )
(t (cons (car l1) (merge_lists (cdr l1) l2)))
)
)

(write (merge_lists '(1 2 3 3 4 5) '(2 3 5 5) ))
(terpri)

;; b)
(defun replace_with_list (l el repl)
(cond
((null l) nil)
((eq l el) repl)
((atom l) (list l))
(t (list (apply #' append(mapcar #'(lambda (L) (replace_with_list L el repl)) l))))
)
)

(defun replace_with_list_wrapper (l el repl)
(car (replace_with_list l el repl))
)

(write (replace_with_list_wrapper '(1 2 2 1 (1 2) 5) 1 '(3 3 3) ))

;; c)
;; TODO -- this ugly problem

;; d) Same as problem 3 c)












