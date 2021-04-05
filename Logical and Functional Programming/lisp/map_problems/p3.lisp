;; Define a function to tests the membership of a node 
;; in a n-tree represented as (root list_of_nodes_subtree1 ... list_of_nodes_subtreen)
;; Eg. tree is (a (b (c)) (d) (E (f))) and the node is "b" => true

(defun is_member (l el)
(cond
((eq l el) 1)
((atom l) 0)
(t (apply #'+ (mapcar #'(lambda (L) (is_member L el)) l)))
)
)

(defun is_member_wrapper (l el)
(cond 
((> (is_member l el) 0) t)
(t nil)
)
)

(write (is_member_wrapper '(a (b (c)) (d) (E (f))) 'b ))
(terpri)
(write (is_member_wrapper '(a (b (c)) (d) (E (f))) 1 ))













