;; 3.
;; a) Write a function that inserts in a linear list a given atom A after the 2nd, 4th, 6th, ... element.
;; b) Write a function to get from a given list the list of all atoms, on any
;;  level, but reverse_list order. Example:
;;  (((A B) C) (D E)) ==> (E D C B A)
;; c) Write a function that returns the greatest common divisor of all numbers in a nonlinear list.
;; d) Write a function that determines the number of occurrences of a given atom in a nonlinear list.


;; a)
(defun insert_after_even (l el parity)
(cond
((null l) nil)
((= parity 1) (cons (car l) (insert_after_even (cdr l) el (- 1 parity))))
((= parity 0) (cons (car l) (cons el (insert_after_even (cdr l) el (- 1 parity)))))
)
)

(write (insert_after_even '(1 2 3 4 5 6 7 8 9 10) 9999 1))
(terpri)

;; b)

(defun flatten (l)
(cond
((null l) nil)
((atom l) (list l))
(t (mapcan #'flatten l))
)
)

(defun reverse_list (l col)
(cond
((null l) col)
(t (reverse_list (cdr l) (cons (car l) col)))
)
)

(write (reverse_list (flatten '(((A B) C) (D E))) nil) )
(terpri)

;; c)

(defun hcd (n m)
(cond
((/= m 0) (hcd m (mod n m) ) )
(t n)
)
)

(defun greatest_com_div (l)
(cond
((null l) 0)
((numberp l) l)
((atom l) 0)
(t (hcd (car l) (greatest_com_div (cdr l))))
)
)

(write (greatest_com_div '(4 2 8)))
(terpri)

;; d)
(defun occurrences (l el)
(cond
((null l) 0)
((eq l el) 1)
((atom l) 0)
(t (+ (occurrences (car l) el) (occurrences (cdr l) el) ))
)
)

(write (occurrences '(1 2 2 2 1 1 3) 3))
(terpri)












