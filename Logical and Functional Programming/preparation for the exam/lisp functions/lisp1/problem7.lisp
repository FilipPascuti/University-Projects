;; 7.
;; a) Write a function to eliminate the n-th element of a linear list.
;; b) Write a function to determine the successor of a number represented digit by digit as a list, without
;; transforming the representation of the number from list to number. Example: (1 9 3 5 9 9) --> (1 9 3 6
;; 0 0)
;; c) Write a function to return the set of all the atoms of a list.
;;  Exemplu: (1 (2 (1 3 (2 4) 3) 1) (1 4)) ==> (1 2 3 4)
;; d) Write a function to test whether a linear list is a set.

;; a)
(defun remove_nth (l n)
(cond
((null l) nil)
((= n 1) (cdr l))
(t (cons (car l) (remove_nth (cdr l) (- n 1))))
)
)

(write (remove_nth '(1 2 3 4 5 6) 4))
(terpri)

;; b)
(defun reverse_list (l col)
(cond
((null l) col)
(t (reverse_list (cdr l) (cons (car l) col)))
)
)

(defun successor_list (l flag)
(cond
((= flag -1) (cons (mod (+ 1 (car l)) 10) (successor_list (cdr l) (floor (+ 1 (car l)) 10)) ) )
((= flag 0) l)
(t (cons (mod (+ 1 (car l)) 10) (successor_list (cdr l) (floor (+ 1 (car l)) 10) ))   )
)
)

(defun successor_list_wrapper (l)
    (reverse_list (successor_list (reverse_list l nil) -1 ) nil)
)

(write (successor_list_wrapper '(1 9 3 5 9 9)))
(terpri)

;; c)
(defun is_member (l el)
(cond
((null l) nil)
((eq (car l) el) t)
((atom (car l)) (is_member (cdr l) el))
(t (or (is_member (car l) el) (is_member (cdr l) el) ))
)
)

(defun to_set (l col)
(cond
((null l) col)
((and (atom l) (is_member col l)) col)
((atom l) (cons l col))
(t (to_set (cdr l) (to_set (car l) col)))
)
)

(write (to_set '(1 (2 (1 3 (2 4) 3) 1) (1 4)) nil ))
(terpri)

;; d)
(defun is_set (l)
(cond
((null l) t)
((is_member (cdr l) (car l)) nil)
(t (is_set (cdr l)))
)
)

(write (is_set '(1 2 3 4 3) ))
(terpri)






















