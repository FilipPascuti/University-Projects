;; 6.
;; a) Write a function to test whether a list is linear.
;; b) Write a function to replace the first occurence of an element E in a given list with an other element
;; O.
;; c) Write a function to replace each sublist of a list with its last element.
;;  A sublist is an element from the first level, which is a list.
;;  Example: (a (b c) (d (e (f)))) ==> (a c (e (f))) ==> (a c (f)) ==> (a c f)
;;  (a (b c) (d ((e) f))) ==> (a c ((e) f)) ==> (a c f)
;; d) Write a function to merge_list two sorted lists without keeping double values.

;; a)
(defun is_linear (l)
(cond
((null l) t)
((atom (car l)) (is_linear (cdr l)))
(t nil)
)
)

;; b)
(defun replace_first_occ (l el repl)
(cond
((null l) nil)
((eq (car l) el) (cons repl (cdr l)))
(t (replace_first_occ (cdr l) el repl))
)
)

(write (replace_first_occ '(1 1 1 1) 1 999))
(terpri)

;; c)
(defun last_element (l)
(cond
((atom l) l)
((null (cdr l))
    (cond
    ((atom l) l)
    (t (last_element (car l)))
    )
)
(t (last_element (cdr l)))
)
)

(defun replace_sublists (l)
(cond
((null l) nil)
((atom (car l)) (cons (car l) (replace_sublists (cdr l))))
(t (cons (last_element (car l)) (replace_sublists (cdr l)) ))
)
)

(write (replace_sublists '(a (b c) (d (e (f)))) ))
(terpri)

;; d)

(defun remove_doubles (l)
(cond
((null (cdr l)) l)
((eq (car l) (cadr l)) (remove_doubles (cdr l)))
(t (cons (car l) (remove_doubles (cdr l))))
)
)

(defun merge_list (l1 l2)
(cond
((null l1) l2)
((null l2) l1)
((> (car l1) (car l2)) (cons (car l2) (merge_list l1 (cdr l2)))  )
((< (car l1) (car l2)) (cons (car l1) (merge_list (cdr l1) l2))  )
(t (cons (car l1) (merge_list (cdr l1) (cdr l2)) ))
)
)

(defun merge_without_doubles (l1 l2)
    (remove_doubles (merge_list l1 l2))
)

(write (merge_without_doubles '(1 2 2 3 4) '(2 3 3 4) ))





