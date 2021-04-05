;; 1.
;; a) Write a function to return the n-th element of a list, or NIL if such an element does not exist.
;; b) Write a function to check whether an atom E is a member of a list which is not necessarily linear.
;; c) Write a function to determine the list of all sublists of a given list, on any level.
;;  A sublist is either the list itself, or any element that is a list, at any level. Example:
;;  (1 2 (3 (4 5) (6 7)) 8 (9 10)) => 5 sublists :
;;  ( (1 2 (3 (4 5) (6 7)) 8 (9 10)) (3 (4 5) (6 7)) (4 5) (6 7) (9 10) )
;; d) Write a function to transform a linear list into a set.


;; a)
(defun return_nth (l n)
(cond
((null l) nil)
((eq n 1) (car l))
(t (return_nth (cdr l) (- n 1)))
)
)

(write (return_nth '(3 3 3 4 500 3) 7))
(terpri)

;; b)
(defun is_member (l e)
(cond
((null l) nil)
((eq (car l) e) t)
((atom (car l)) (is_member (cdr l) e))
(t (or (is_member (car l) e) (is_member (cdr l )e )))
)
)

(write (is_member '(1 2 (5) 4) 3))
(terpri)

;; c)
(defun no_of_sublists (l)
(cond
((null l) 0)
((atom l) 0)
(t (+ 1 (apply #'+ (mapcar #'no_of_sublists l))))
)
)


(write (no_of_sublists '(1 2 (3 (4 5) (6 7)) 8 (9 10)) ))
(terpri)

;; d)

(defun to_set (l)
(cond
((null l) nil)
((is_member (cdr l) (car l)) (to_set (cdr l)))
(t (cons (car l) (to_set (cdr l))))
)
)

(write (to_set '(1 2 3 3 2 2 1 4) ))
(terpri)
























