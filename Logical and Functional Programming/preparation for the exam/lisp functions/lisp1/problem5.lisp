;; 5.
;; a) Write twice the n-th element of a linear list. Example: for (10 20 30 40 50) and n=3 will produce (10
;; 20 30 30 40 50).
;; b) Write a function to return an association list with the two lists given as parameters.
;;  Example: (A B C) (X Y Z) --> ((A.X) (B.Y) (C.Z)).
;; c) Write a function to determine the number of all sublists of a given list, on any level.
;;  A sublist is either the list itself, or any element that is a list, at any level. Example:
;;  (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 lists:
;; (list itself, (3 ...), (4 5), (6 7), (9 10)).
;; d) Write a function to return the number of all numerical atoms in a list at superficial level.

;; a)
(defun double_nth (l n)
(cond
((= n 1) (append (list (car l) (car l)) (cdr l)))
(t (cons (car l) (double_nth (cdr l) (- n 1))))
)
)

(write (double_nth '(10 20 30 40 50) 3))
(terpri)
;; b)
(defun assocc_list (l1 l2)
(cond
((null l1) nil)
(t (append (list (cons (car l1) (car l2))) (assocc_list (cdr l1) (cdr l2)) ))
)
)

(write (assocc_list '(A B C) '(X Y Z)))
(terpri)

;; c)
(defun no_of_sublists (l)
(cond
((null l) 0)
((atom l) 0)
(t (+ 1 (apply #'+ (mapcar #'no_of_sublists l))))
)
)

(write (no_of_sublists '(1 2 (3 (4 5) (6 7)) 8 (9 10))))
(terpri)

;; d)
(defun numbers_superf (l)
(cond
((null l) 0)
((numberp (car l)) (+ 1 (numbers_superf (cdr l))))
(t (numbers_superf (cdr l)))
)
)

(write (numbers_superf '(1 2 (3 (4 5) (6 7)) 8 (9 10))))
(terpri)
















