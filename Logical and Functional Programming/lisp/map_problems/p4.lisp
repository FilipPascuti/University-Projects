;; Write a function that returns the product 
;; of numeric atoms in a list, at any level.

(defun prod (l)
(cond
((numberp l) l)
((atom l) 1)
(t (apply #'* (mapcar #'prod l)))
)
)

(write (prod '(1 a 2 b 5 c) )  )















