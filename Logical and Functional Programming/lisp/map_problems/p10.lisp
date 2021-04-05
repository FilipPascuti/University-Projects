;; Define a function that replaces one node with another one in a n-tree represented as: root
;; list_of_nodes_subtree1... list_of_nodes_subtreen)
;; Eg: tree is (a (b (c)) (d) (e (f))) and node 'b' 
;; will be replace with node 'g' => tree (a (g (c)) (d) (e (f)))}

(defun replace_node (l el k)
(cond
((eq l el) (list k))
((atom l) (list l))
(t (list (mapcan #'(lambda (L) (replace_node L el k)) l) ))
)
)

(defun replace_node_wrapper (l el k)
    (car (replace_node l el k))
)

(write (replace_node_wrapper '(a (b (c)) (d) (e (f))) 'b 'g ))











