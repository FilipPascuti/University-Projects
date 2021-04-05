;; Write a function that returns the sum 
;; of numeric atoms in a list, at any level.

(defun sum_num (l)
(cond
((numberp l) l)
((atom l) 0)
(t (apply #'+ (mapcar #'sum_num l)))
)
)

(write (sum_num '(1 2 3 a b c 4 g s) ))
(terpri)
(write (sum_num '( a b c  g s) ))


