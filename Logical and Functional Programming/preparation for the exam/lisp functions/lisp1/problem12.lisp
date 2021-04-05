;; 12.
;; a) Write a function to return the dot product of two vectors. https://en.wikipedia.org/wiki/Dot_product
;; b) Write a function to return the maximum value of all the numerical atoms of a list, at any level.
;; c) All permutations to be replaced by: Write a function to compute the result of an arithmetic
;; expression memorised
;;  in preorder on a stack. Examples:
;;  (+ 1 3) ==> 4 (1 + 3)
;;  (+ * 2 4 3) ==> 11 [((2 * 4) + 3)
;;  (+ * 2 4 - 5 * 2 2) ==> 9 ((2 * 4) + (5 - (2 * 2))
;; d) Write a function to return T if a list has an even number of elements on the first level, and NIL on
;; the contrary case, without counting the elements of the list.

;; a) === 2 a)

;; b) 

(defun max_value (l)
(cond
((null l) -9999)
((numberp l) l)
((atom l) -9999)
(t (apply #'max (mapcar #'max_value l)))
)
)

(write (max_value '(1 2 5 3 (4 (10)) 2 2)))
(terpri)

;; c) like 10 c)

;; d)

(defun no_of_elems (l)
(cond
((null l) 0)
(t (+ 1 (no_of_elems (cdr l))))
)
)

(defun has_even (l)
(cond
((evenp (no_of_elems l)) t)
(t nil)
)
)

(write (has_even '(1 (2) 3 (4(3)))))
(terpri)








