;; Define a function that returns the depth of a tree represented as (root list_of_nodes_subtree1 ...
;; list_of_nodes_subtreen)
;; Eg. the depth of the tree (a (b (c)) (d) (e (f))) is 3

(defun return_depth (l level)
    (cond
        ((atom l) level)
        (t (apply #'max (mapcar #'(lambda (L) (return_depth L (+ level 1) )) l )))
    )
)

(defun return_depth_wrapper (l)
    (return_depth l 0)
)

(write (return_depth_wrapper '(a (b (c)) (d) (e (f))) ))















