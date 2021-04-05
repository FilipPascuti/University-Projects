;; Write a function that computes the sum of even numbers and 
;; the decrease the sum of odd numbers, at any level of a list.

;; (defun sum_even (l)
;; (cond
;; ((and (numberp l) (= (mod l 2) 0)) l)
;; ((atom l) 0)
;; (t (apply #'+ (mapcar #'sum_even l)))
;; )
;; )

;; (defun sum_odd (l)
;; (cond
;; ((and (numberp l) (= (mod l 2) 1)) l)
;; ((atom l) 0)
;; (t (apply #'+ (mapcar #'sum_odd l)))
;; )
;; )

(defun sum_even_minus_odd (l)
(cond
((and (numberp l) (= (mod l 2) 1)) (- 0 l))
((and (numberp l) (= (mod l 2) 0)) l)
((atom l) 0)
(t (apply #'+ (mapcar #'sum_even_minus_odd l)))
)
)


;; (write (sum_even '(1 2 3 4 5 4 7 9) ))
;; (terpri)
;; (write (sum_odd '(1 2 3 4 5 4 7 9) ))
;; (terpri)
(write (sum_even_minus_odd '(1 2 3 4 5 4 7 9) ))




