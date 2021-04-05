;; Write a function that removes all occurrences of an atom from any level of a list.

;; (defun remove_occ (l el)
;; (cond
;; ((eq l el) nil)
;; ((atom l) (list l))
;; (t (list (apply #'append (mapcar #'(lambda (L) (remove_occ L el)) l    ))))
;; )
;; )

(defun remove_occ (l el)
(cond
((eq l el) nil)
((atom l) (list l))
(t (list (mapcan #'(lambda (L) (remove_occ L el)) l    )))
)
)

(defun remove_occ_wrapper (l el)
(car (remove_occ l el))
)

(write (remove_occ_wrapper '(1 2 1 2 4 (1) 5 6) 1 ))




