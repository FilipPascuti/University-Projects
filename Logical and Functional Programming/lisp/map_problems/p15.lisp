;; Write a function that reverses a list
;; together with all its sublists elements, at any level.

(defun reverse_list (l)
(cond
((atom l) l)
(t (mapcar #'reverse_list (reverse l)))
)
)

(write (reverse_list '(1 2 3 (4 5) (6 7) 8)))














