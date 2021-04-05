;; Write a function that returns the maximum of 
;; numeric atoms in a list, at any level.

(defun max_val (l)
(cond
((numberp l) l)
((atom l) -9999)
(t (apply #'max (mapcar #'max_val l)))
)
)

(write (max_val '(a v c 4 10 100) ))














