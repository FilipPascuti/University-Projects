;; (defun rev_ev (l)
;; (cond
;; ((and (numberp l) (evenp l)) (+ l 1))
;; ((atom l) l)
;; (t (mapcar #'rev_ev l))
;; )
;; )

;; (defun rev_ev (l)
;; (cond
;; ((null l) nil)
;; ((and (numberp l) (evenp l)) (+ 1 l) )
;; ((atom l) l)
;; (t (append (list (rev_ev (car l))) (list (rev_ev (cdr l))) ))
;; )
;; )

(defun max_odd (l level)
(cond
((and (oddp level) (numberp l)) l)
((atom l) -9999)
(t (apply #'max (mapcar #'(lambda (L) (max_odd L (+ 1 level)) ) l )))
)
)

(defun valid (l)
(cond
((evenp (max_odd l 0)) t )
(t nil)
)
)

(defun count_list (l)
(cond 
((atom l) 0)
((valid l) (+ 1 (apply #'+ (mapcar #'count_list l))) )
(t (apply #'+ (mapcar #'count_list l)))
)
)

;; (write (count_list '(a (b 2) (1 c 4) (1 (6 f)) (((g) 4) 6) )      ))

(defun repl(l level k)
(cond 
((and (= level k) (atom l)) (list l))
((atom l) nil)
(t (apply #'append (mapcar #'(lambda (L) (repl L (+ 1 level) k) ) l )))
)
)

(write (repl '(a (b (g)) (c (d (e)) (f))) -1 5 ))












