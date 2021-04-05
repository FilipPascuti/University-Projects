(defun replace (l level k)
(cond
((and (atom l) (= level k)) (list 0))
((atom l) (list l))
(t (list (apply #' append (mapcar #'(lambda (L) (replace L (+ level 1) k) ) l  ))))
)
)

(defun replace_wrapper (l k)
    (car (replace l 0 k) )
)

;; (write (replace_wrapper '(a (1 (2 b)) (c (d))) 2 ))

;; (defun f(x &rest y)
;; (cond
;; ((null y) x)
;; (t (append x (mapcar #'car y)))
;; )
;; )

;; (write (append (f '(1 2)) (f '(3 4) '(5 6) '(7 8)) ) )

(defun f(l)
(cond
((null l) 0)
((> (f (car l)) 2) (+ (car l) (f (cdr l)) ) )
(t (f (car l)))
)
)

(write (f '(1 2 3 4 5)))






