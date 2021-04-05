;; 2.
;; a) Write a function to return the product of two vectors.
;; https://en.wikipedia.org/wiki/Dot_product
;; b) Write a function to return the depth of a list. Example: the depth of a linear list is 1.
;; c) Write a function to sort a linear list without keeping the double values.
;; d) Write a function to return the intersection of two sets.

;; a)

(defun dot_product (l1 l2)
(cond
((null l1) 0)
(t (+ (* (car l1) (car l2)) (dot_product (cdr l1) (cdr l2)) ))
)
)

(write (dot_product '(1 3 -5) '(4 -2 -1)))
(terpri)

;; b)
(defun depth_of_list (l dep)
(cond
((null l) dep)
((atom (car l)) (depth_of_list (cdr l) dep))
(t (max (depth_of_list (car l) (+ dep 1)) (depth_of_list (cdr l) dep) ))
)
)

(write (depth_of_list '(1 2 3 (5) 5 (3 (4 (5)))) 1))
(terpri)


;; c)
;; insert_sort(List,Sorted):-i_sort(List,[],Sorted).

;; i_sort([],Acc,Acc).
;; i_sort([H|T],Acc,Sorted):-insert(H,Acc,NAcc),i_sort(T,NAcc,Sorted).
   
;; insert(X,[],[X]).
;; insert(X,[Y|T],[X,Y|T]):-X<Y.
;; insert(X,[Y|T],[Y|T]):- X =:= Y.
;; insert(X,[Y|T],[Y|NT]):-X>Y,insert(X,T,NT).

(defun insert (el l)
(cond
((null l) (list el))
((< el (car l)) (cons el l))
((= el (car l)) l)
(t (cons (car l) (insert el (cdr l))))
)
)

(defun insert_sort (l rez)
(cond
((null l) rez)
(t (insert_sort (cdr l) (insert (car l) rez)))
)
)

(defun sort_wrapper (l)
(insert_sort l nil)
)

(write (sort_wrapper '(7 3 8 1 2 3 10) ))
(terpri)


;; d)

(defun is_member (l e)
(cond
((null l) nil)
((eq (car l) e) t)
((atom (car l)) (is_member (cdr l) e))
(t (or (is_member (car l) e) (is_member (cdr l )e )))
)
)

(defun intersect (l1 l2)
(cond
((null l1) nil)
((is_member l2 (car l1)) (cons (car l1) (intersect (cdr l1) l2)))
(t (intersect (cdr l1) l2))
)
)

(write (intersect '(1 2 3 4 5) '(3 4 5 6 7) ))




