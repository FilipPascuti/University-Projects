;; 4.
;; a) Write a function to return the sum of two vectors.
;; b) Write a function to get from a given list the list of all atoms, on any
;;  level, but on the same order. Example:
;;  (((A B) C) (D E)) ==> (A B C D E)
;; c) Write a function that, with a list given as parameter, inverts only continuous
;;  sequences of atoms. Example:
;;  (a b c (d (e f) g h i)) ==> (c b a (d (f e) i h g))
;; d) Write a list to return the maximum value of the numerical atoms from a list, at superficial level.

;; a)
(defun sum_of_vectors (l1 l2 col)
(cond
((null l1) col)
(t (sum_of_vectors (cdr l1) (cdr l2) (cons (+ (car l1) (car l2)) col) ))
)
)


(write (sum_of_vectors '(1 2 3) '(4 3 2) nil))
(terpri)

;; b)

(defun flatten (l)
(cond
((null l) nil)
((atom l) (list l))
(t (mapcan #'flatten l))
)
)

(write (flatten '(((A B) C) (D E))))
(terpri)

;; c)

(defun reverse_cont (l col)
(cond
((null l) col)
((atom (car l)) (reverse_cont (cdr l) (cons (car l) col)))
(t (append col (list (reverse_cont (car l) nil)) (list (reverse_cont (cdr l) nil)) ))
)
)

(write (reverse_cont '(a b c (d (e f) g h i)) nil ))
(terpri)

;; d)
(defun max_superficial (l)
(cond
((null l) -9999)
((numberp (car l)) (max (car l) (max_superficial (cdr l))))
(t (max_superficial (cdr l)))
)
)

(write (max_superficial '(1 2 3 a b (5) 4) ))
(terpri)
