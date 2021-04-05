;; Write a function that returns the number of atoms in a list, at any level.

(defun no_of_atoms (l)
(cond
((atom l) 1)
(t (apply #'+ (mapcar #'no_of_atoms l)))
)
)

(write (no_of_atoms '(1 2 3 4 5 6 7 8 9 a)))






