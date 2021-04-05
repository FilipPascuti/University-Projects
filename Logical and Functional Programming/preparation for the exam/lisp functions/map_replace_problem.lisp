(defun replace_with (lista element replacement_list)
(cond
((eq lista element) replacement_list)
((atom lista) (list lista))
(t (list (apply #'append (mapcar #'(lambda (L) (replace_with L element replacement_list)) lista) ) ))
)
)

(defun replace_wrapper (l element replacement_list)
    (car (replace_with l element replacement_list))
)


(write (replace_wrapper '(1 2 3 (1 2 3)) 1 '(A B)))









