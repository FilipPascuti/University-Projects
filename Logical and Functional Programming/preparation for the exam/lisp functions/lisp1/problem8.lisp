8.
;; a) Write a function to return the difference of two sets.
;; b) Write a function to reverse a list with its all sublists, on all levels.
;; c) Write a function to return the list of the first elements of all list elements of a given list with an odd
;; number of elements at superficial level. Example:
;;  (1 2 (3 (4 5) (6 7)) 8 (9 10 11)) => (1 3 9).
;; d) Write a function to return the sum of all numerical atoms in a list at superficial level.

;; a)
(defun is_member (l el)
(cond
((null l) nil)
((eq (car l) el) t)
((atom (car l)) (is_member (cdr l) el))
(t (or (is_member (car l) el) (is_member (cdr l) el) ))
)
)

(defun set_difference (l1 l2)
(cond
((null l1) nil)
((and (atom (car l1)) (is_member l2 (car l1))) (set_difference (cdr l1) l2))
(t (cons (car l1) (set_difference (cdr l1) l2)))
)
)

(write (set_difference '(1 2 3 4 5 6 7 8) '(2 3 4 7) ))
(terpri)

;; b)
(defun reverse_list (l col)
(cond
((null l) col)
((atom (car l)) (reverse_list (cdr l) (cons (car l) col)))
(t (reverse_list (cdr l) (append (list (reverse_list (car l) nil)) col) ))
)
)

(write (reverse_list '(1 2 3 (4 5) (6 7 (8 9))) nil ))
(terpri)
;; c)

(defun no_of_elems (l)
(cond
((null l) 0)
(t (+ 1 (no_of_elems (cdr l))))
)
)

(defun has_odd (l)
(cond
((oddp (no_of_elems l)) t)
(t nil)
)
)

(defun first_elem (l)
(cond
((atom (car l)) (car l))
(t (first_elem (car l)))
)
)

(defun keep_first (l)
(cond
((null l) nil)
((atom l) nil)
((has_odd l) (cons (first_elem l) (mapcan #'keep_first l)))
(t (mapcan #'keep_first l))
)
)

(write (keep_first '(1 2 (3 (4 5) (6 7)) 8 (9 10 11))))
(terpri)

;; d)
(defun sum_superf (l)
(cond
((null l) 0)
((numberp (car l)) (+ (car l) (sum_superf (cdr l))))
(t (sum_superf (cdr l)))
)
)

(write (sum_superf '(1 2 3 4 (5 5))))









