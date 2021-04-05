;; 11.
;; a) Determine the least common multiple of the numerical 
;; values of a nonlinear list.
;; b) Write a function to test if a linear list of numbers has 
;; a "mountain" aspect (a list has a "mountain"aspect if the 
;; items increase to a certain point and then decreases.
;;  Eg. (10 18 29 17 11 10). The list must have at least 
;; 3 atoms to fullfil this criteria.
;; c) Remove all occurrences of a maximum numerical element 
;; from a nonlinear list.
;; d) Write a function which returns the product of numerical
;;  even atoms from a list, to any level.

;; Solutions


;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; a)
;; hcd(n1, n2) - returns the greatest common divisor

(defun hcd (n m)
(cond
((/= m 0) (hcd m (mod n m) ) )
(t n)
)
)

(defun lcmn (n m)
    (/ (* n m) (hcd n m))
)

;; (defun lcml (lista current)
;; (cond
;; ((null lista) current)
;; ((numberp (car lista)) (lcml (cdr lista) (lcmn (car lista) current)) )
;; ((atom (car lista)) (lcml (cdr lista ) current) )
;; (t (lcml (cdr lista) (lcmn (lcml (car lista) 1) current) ) )
;; )
;; )

(defun lcml (lista)
(cond
((numberp lista) lista)
((atom lista) 1)
(t (lcmn (lcml (car lista)) (lcml (cdr lista))))
)
)

(defun hasNumber (lista)
(cond
((null lista) nil)
((numberp (car lista)) t)
(t (hasNumber (cdr lista)) ) 
)
)

(defun lcmlWrapper (lista)
(cond
((hasNumber lista) (lcml lista))
(t 0)
)
)

(format t "Subpoint a)")
(terpri)
(format t "~d" (lcmlWrapper '("b" (5 2) 3 7 "a") ))
(terpri)
(format t "~d" (lcmlWrapper '("b" "a") ))
(terpri)

;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; b) Write a function to test if a linear list of numbers has 
;; a "mountain" aspect (a list has a "mountain"aspect if the 
;; items increase to a certain point and then decreases.
;;  Eg. (10 18 29 17 11 10). The list must have at least 

(defun isMountain (lista flag)
(cond
((and (<= (length lista) 1) (= flag 0)) nil )
((and (<= (length lista) 1) (= flag 1)) t)
((and (< (car lista) (cadr lista)) (= flag 0)) (isMountain (cdr lista) 0 ))
((and (>= (car lista) (cadr lista)) (= flag 0)) (isMountain (cdr lista) 1 ))
((and (> (car lista) (cadr lista)) (= flag 1)) (isMountain (cdr lista) 1 ))
(t nil)
)
)

(defun isMountainWrapper (lista)
(isMountain lista 0)
)

(format t "Subpoint b)")
(terpri)
(write (isMountainWrapper '(1 2 3 2 1)) )
(terpri)
(write (isMountainWrapper '(1 2 3 2 3)) )
(terpri)
(write (isMountainWrapper '(1 2)) )
(terpri)

;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; c) Remove all occurrences of a maximum numerical element 
;; from a nonlinear list.

;; (defun findMax (lista current)
;; (cond
;; ((null lista) current)
;; ((and (numberp (car lista)) (> (car lista) current)) (findMax (cdr lista) (car lista)) ) 
;; ((atom (car lista)) (findMax (cdr lista) current))
;; (t (findMax (cdr lista) (findMax (car lista) current) ))
;; )
;; )

(defun findMax (lista)
(cond
((numberp lista) lista)
((atom lista) -9999)
(t (max (findMax (car lista)) (findMax (cdr lista))))
)
)

(defun removeMax (lista maxValue)
(cond
((null lista) nil)
((and (numberp (car lista)) (= maxValue (car lista))) (removeMax (cdr lista) maxValue) )
((atom (car lista)) (cons (car lista) (removeMax (cdr lista) maxValue)) )
(t (cons (removeMax (car lista) maxValue) (removeMax (cdr lista) maxValue)))
)
)

(defun removeMaxWrapper (lista)
(removeMax lista (findMax lista))
)

(format t "Subpoint c)")
(terpri)
(write (removeMaxWrapper '(1 2 (3 55) 4 55 ))) 
(terpri)
(write (removeMaxWrapper '(a b (c d) e f )))
(terpri)

;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; d) Write a function which returns the product of numerical
;;  even atoms from a list, to any level.

(defun evenProduct (lista)
(cond
((and (numberp lista) (= (mod lista 2) 0)) lista)
((atom lista) 1)
(t (* (evenProduct (car lista)) (evenProduct (cdr lista)) ))
)
)

(defun hasEvenNumber (lista)
(cond
((null lista) nil)
((and(numberp (car lista)) (= (mod (car lista) 2) 0) ) t)
(t (hasEvenNumber (cdr lista)) ) 
)
)

(defun evenProductWrapper (lista)
(cond
((hasEvenNumber lista) (evenProduct lista))
(t 0)
)
)

(format t "Subpoint d)")
(terpri)
(format t "~d" (evenProductWrapper '("b" (5 2) 3 2 4 "a") ))
(terpri)
(format t "~d" (evenProductWrapper '("b" (5) 3 "a") ))