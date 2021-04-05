;; 14.
;; a) Write a function to return the union of two sets.
;; b) Write a function to return the product of all numerical atoms in a list, at any level.
;; c) Write a function to sort a linear list with keeping the double values.
;; d) Build a list which contains positions of a minimum numeric element from a given linear list.

;; a)
(defun is_not_member (l el)
(cond
((null l) t)
((equal (car l) el) nil)
(t (is_not_member (cdr l) el))
)
)

(defun union_of_sets (l1 l2)
(cond
((null l1) l2)
((is_not_member l2 (car l1)) (cons (car l1) (union_of_sets (cdr l1) l2)))
(t (union_of_sets (cdr l1) l2))
)
)

(write (union_of_sets '(1 2 3 4 5 6) '(2 4 6 7 8 9 10) ))
(terpri)

;; b)

(defun list_product (l)
(cond
((null l) 1)
((numberp l) l)
((atom l) 1)
(t (apply #'* (mapcar #'list_product l)))
)
)

(write (list_product '(1 2 (3 5 (5)) 2)))
(terpri)

;; c)

(defun insert_cresc (l el)
(cond
((null l) (list el))
((< el (car l)) (cons el l))
(t (cons (car l) (insert_cresc (cdr l) el)))
)
)

(defun insertion_sort (l col)
(cond
((null l) col)
(t (insertion_sort (cdr l) (insert_cresc col (car l))))
)
)

(write (insertion_sort '(1 10 2 3 4 11 13 12) nil))
(terpri)

;; d)
(defun find_min (l)
(cond
((numberp l) l)
((atom l) -9999)
(t (apply #'min (mapcar #'find_min l)))
)
)

(defun min_positions (l el pos)
(cond
((null l) nil)
((eq (car l) el) (cons pos (min_positions (cdr l) el (+ 1 pos))))
(t (min_positions (cdr l) el (+ 1 pos)))
)
)

(write (min_positions '(5 1 7 1 9 1 11 23) 1 1))

















