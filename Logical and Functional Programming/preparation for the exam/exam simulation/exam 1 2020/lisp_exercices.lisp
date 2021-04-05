
;; (defun f (l)
;;     (cond
;;         ((atom l) -1)
;;         ((> (f (car l)) 0) (+ (car l) (f (car l)) (f (cdr l))))
;;         (t (f (cdr l)))
;;     )
;; )

;; (defun f (l)
;;     (cond
;;         ((atom l) -1)
;;         (t ( (lambda (L) 
;;             (cond
;;             ((atom l) -1)
;;             ((> L 0) (+ (car l) L (f (cdr l))))
;;             (t (f (cdr l)))
;;             )
;;         ) (f (car l)) ))
;;     )
;; )

;; (defun g (f l)
;;     (funcall f l)
;; )

(defun morph (l)
(cond
((and (numberp l) (evenp l)) (list (+ 1 l)))
((atom l) (list l))
(t (list (apply #' append (mapcar #'morph l))))
)
)

(defun morph_wrapper (l)
    (car (morph l))
)

(write (morph_wrapper '(1 s 4 (2 f (7)))))




































