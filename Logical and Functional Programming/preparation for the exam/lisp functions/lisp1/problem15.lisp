;; 15.
;; a) Write a function to insert an element E on the n-th position of a linear list.
;; b) Write a function to return the sum of all numerical atoms of a list, at any level.
;; c) Write a function to return the set of all sublists of a given linear list. Ex. For list ((1 2 3) ((4 5) 6)) =>
;; ((1 2 3) (4 5) ((4 5) 6))
;; d) Write a function to test the equality of two sets, without using the difference of two sets.

;; a)

(defun insert_on_nth (l el n)
(cond
((= n 1) (cons el l))
((null l) nil)
(t (cons (car l) (insert_on_nth (cdr l) el (- n 1) )))
)
)

(write (insert_on_nth '(1 2 3 4 5) 100 5))
(terpri)

;; b)
(defun sum_of_elems (l)
(cond
((null l) 0)
((numberp l) l)
((atom l) 0)
(t (apply #'+ (mapcar #'sum_of_elems l)))
)
)

(write (sum_of_elems '((1 2 3) (4 5) ((4 5) 6)) ))
(terpri)

(defun all_sublists (l)
(cond
((null l) nil)
((atom l) nil)
(t (append (list l) (mapcan #'all_sublists l)))
)
)

(defun is_not_member (l el)
(cond
((null l) t)
((equal (car l) el) nil)
(t (is_not_member (cdr l) el))
)
)

(defun remove_duplicates (l)
(cond
((null (cdr l)) l)
((is_not_member (cdr l) (car l)) (append (list (car l)) (remove_duplicates (cdr l))))
(t (remove_duplicates (cdr l)))
)
)

(defun all_sublists_wrapper (l)
    (remove_duplicates (cdr (all_sublists l) ))
)

(write (all_sublists_wrapper '((1 2 3) (4 5) ((4 5) 6))))
(terpri)

;; d)

(defun is_included (l1 l2)
(cond
((null l1) t)
((is_not_member l2 (car l1)) nil)
(t (is_included (cdr l1) l2))
)
)

(defun equal_sets (l1 l2)
(cond
((and (is_included l1 l2) (is_included l2 l1)) t)
(t nil)
)
)

(write (equal_sets '(1 2 3 7) '(2 1 7 3 ) ))





