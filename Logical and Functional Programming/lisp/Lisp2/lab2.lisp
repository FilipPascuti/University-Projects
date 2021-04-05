;; 12. Determine the list of nodes accesed 
;; in preorder in a tree of type (2).

(defun preorder (l)
(cond 
((null l) nil)
(t (append (list (car l)) (preorder (cadr l)) (preorder (caddr l)))) 
)
)

(write (preorder '(a(b () (f)) (d (e)))))
(terpri)
(write  (preorder '(A (B) (C (D) (E))) ))
(terpri)
(write (preorder '(A (B (D) (E (H))) (C (F (I)) (G))) ))













