;; (defun remove_el (l el)
;; (cond 
;; ((eq l el ) nil)
;; ((atom l) (list l))
;; (t (list (apply #'append (mapcar #'(lambda (L) (remove_el L el)) l ) ) ))
;; )
;; )

;; (defun remove (l el)
;;     (car (remove_el l el))
;; )

;; (write (remove '(1 (2(3))) 'A ))

(defun last_num (l)
(cond
((null (cdr l)) 
    (cond
    ((numberp (car l)) nil)
    ((atom (car l)) t)
    (t (last_num (car l)))    
    )
)
(t (last_num (cdr l)))
)
)

(defun count_sublists (l)
(cond
((atom l) 0)
((last_num l) (+ 1 (apply #'+ (mapcar #'count_sublists l) )))
(t (apply #'+ (mapcar #'count_sublists l) ))
)
)

(defun count_sublists_wrapper (l)
(cond 
((last_num l) (- (count_sublists l) 1))
(t (count_sublists l))
)
)

;; (write (count_sublists_wrapper '(a (b 2) (1 c 4) (d 1 (6 f)) ((g 4) 6)f ) ))

(defun replace_el (l)
(cond
((and (numberp l) (evenp l)) (+ l 1) )
((atom l) l)
(t (mapcar #'replace_el l))
)
)

(write (replace_el '(1 2 (3 4 (5 6) 6) 5 4) ))

