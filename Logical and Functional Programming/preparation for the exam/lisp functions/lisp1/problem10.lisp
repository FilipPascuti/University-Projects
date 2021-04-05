;; 10.
;; a) Write a function to return the product of all the numerical atoms from a list, at superficial level.
;; b) Write a function to replace the first occurence of an element E in a given list with an other element
;; O.
;; c) Write a function to compute the result of an arithmetic expression memorised
;;  in preorder on a stack. Examples:
;;  (+ 1 3) ==> 4 (1 + 3)
;;  (+ * 2 4 3) ==> 11 [((2 * 4) + 3)
;;  (+ * 2 4 - 5 * 2 2) ==> 9 ((2 * 4) + (5 - (2 * 2))
;; d) Write a function to produce the list of pairs (atom n), where atom appears for n times in the
;; parameter list. Example:
;;  (A B A B A C A) --> ((A 4) (B 2) (C 1)).

;; a) => 8 d)

;; b) => 6 b)

;; c) preaty weird

;; d)

(defun insert (l el)
(cond
((null l) (list (list el 1)))
((eq (caar l) el) (append (list (list el (+ 1 (cadar l)))) (cdr l)) )
(t (append (list (car l)) (insert (cdr l) el))) 
)
)

(defun apar (l col)
(cond
((null l) col)
(t (apar (cdr l) (insert col (car l))))
)
)

(write (apar '(A B A B A C A) nil))
(terpri)














