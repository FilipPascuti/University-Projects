;; (defun g(l)
;;     (list (car l) (car l))
;; )

;; (setq q 'g)
;; (setq p q)

;; (write (funcall p '(A B C)))

(defun replace (l el level)
(cond
((and (atom l) (oddp level)) (list el))
((atom l) (list l))
(t (list (apply #'append (mapcar #'(lambda (L) (replace l el (+ level 1) ) ) l ) )))
)
)

(defun replace_wrapper (l el)
    (car (replace l el -1))
)

(write (replace_wrapper '(a (b (g)) (c (d (e)) (f))) 'h ))






