;; Write a function to determine the depth of a list.

(defun return_depth (l level)
    (cond
        ((atom l) level)
        (t (apply #'max (mapcar #'(lambda (L) (return_depth L (+ level 1) )) l )))
    )
)

(defun return_depth_wrapper (l)
    (return_depth l 0)
)

(write (return_depth_wrapper '(1 2 3 (2 3 (1 2)) (2 3 (1 (5) 2))) ))




















