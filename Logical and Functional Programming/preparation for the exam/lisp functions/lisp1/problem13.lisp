;; 13.
;; a) A linear list is given. Eliminate from the list all elements from N to N steps, N-given.
;; b) Write a function to test if a linear list of integer numbers has a "valley" aspect (a list has a valley
;; aspect if the items decrease to a certain point and then increase. Eg. 10 8 6 17 19 20). A list must
;; have at least 3 elements to fullfill this condition.
;; c) Build a function that returns the minimum numeric atom from a list, at any level.
;; d) Write a function that deletes from a linear list of all occurrences of the maximum element.

;; a)

(defun eliminate_div_n (l pos n)
(cond
((null l) nil)
((= (mod pos n) 0) (eliminate_div_n (cdr l) (+ 1 pos) n))
(t (cons (car l) (eliminate_div_n (cdr l) (+ 1 pos) n) ))
)
)

(write (eliminate_div_n '(1 2 3 4 5 6 7 8 9 10) 1 2))
(terpri)
;; b)
;; Use the example from Zsuzsana

;; c)
(defun find_min (l)
(cond
((null l) 9999)
((numberp l) l)
((atom l) 9999)
(t (apply #'min (mapcar #'find_min l)))
)
)

(write (find_min '(5 1 7 1 9 1 11 23) ))
(terpri)

;; d)
(defun find_max (l)
(cond
((null l) -9999)
((numberp l) l)
((atom l) -9999)
(t (apply #'max (mapcar #'find_max l)))
)
)

(defun remove_max (l el)
(cond
((null l) nil)
((eq l el) nil)
((atom l) (list l))
(t (mapcan #'(lambda (L) (remove_max L el) ) l  ))
)
)

(write (remove_max '(5 1 23 7 23 1 9 1 11 23) 23 ))
(terpri)





















