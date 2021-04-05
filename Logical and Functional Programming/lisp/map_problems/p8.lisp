;; Write a function to determine the number of nodes on the level k from a n-tree represented as follows:
;; (root list_nodes_subtree1 ... list_nodes_subtreen)
;; Eg: tree is (a (b (c)) (d) (e (f))) and k=1 => 3 nodes

(defun at_level (l k level)
(cond
((and (atom l) (= level k)) 1)
((atom l) 0)
((= level k) (+ 1 (apply #'+ (mapcar #'(lambda (L) (at_level L k (+ level 1))) (cdr l) ))))
(t (apply #'+ (mapcar #'(lambda (L) (at_level L k (+ level 1))) (cdr l) )   ) )
)
)

(defun at_level_wrapper (l k)
    (at_level l k 0)
)

(write (at_level_wrapper '(a (b (c)) (d) (e (f))) 1 ))












