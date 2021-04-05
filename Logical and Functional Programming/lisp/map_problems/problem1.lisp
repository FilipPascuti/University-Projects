;; Write a function to check if an atom is 
;; member of a list (the list is non-liniar)

(defun is_in (l el)
(cond
((eq l el) 1)
((atom l) 0)
    (t 
        (apply #'+ (mapcar #'(lambda (L) (is_in L el)) l))
    )
)
)

(defun is_in_wrapper (l el)
(cond 
((> (is_in l el) 0) t)
(t nil)
)
)

(write (is_in_wrapper '(1 2 ( 5  (3 9 ) )  6 4) 9 ))
(terpri)
(write (is_in_wrapper '(1 2 ( 5  (3 9 ) )  6 4) 10 ))






