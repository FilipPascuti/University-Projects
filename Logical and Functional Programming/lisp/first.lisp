;; everything is a list in lisp
;; car -> first element in a list.
;; cdr -> rest of the list
;; '(1 2 3) -> that's how you represent a list
;; append -> concatenates two lists:
;; (append '(1 2 3) '(4 5 6))
;; (append (cdr '(1 2 3)) '(4 5 6))
;; NIL -> false or empty list

;; numberp -> is a number
;; atom -> true for atoms and numbers
;; listp -> checks if it is a list

;; To check if its an atom and not a number or list
;; (and (atom 'B) (not (numberp 'B)))

;; count the number of non number atoms in a list
;; calculeaza(l1..ln) = 
;;      0, n = 0
;;      1 + calculeaza(l2..ln), l1 is a non number atom
;;      calculeaza(l2..ln), l1 e atom numberic
;;      calculeaza(l1) + calculeaza(l2..ln), altfel

;; (defun calculeaza (l)
;; (
;; cond
;; ((null l) 0)
;; ((numberp (car l)) (calculeaza (cdr l)))
;; ((atom (car l)) (+ 1 (calculeaza (cdr l))))
;; ;; ((listp (car l)) )
;; (t (+ (calculeaza (car l)) (calculeaza (cdr l))))
;; )
;; )

;; (format t "~S" (calculeaza '(1 2 3 e e (1 a b ))) )

;; append, list, cons

;; append ----> merge in principiu numai cu liste
;; (append '(1 2 3)
;; (append '(1 2) '(3 4) '(5 6))
;; (append '(1 2) 3) ----> merge
;; (append  3  '(1 2)) ----> da eroare
;; list ----> ii mai de treaba
;; (list '(1 2 3))
;; (list 1 '(1 2 3) 'h)

;; cons ----> permite doar 2 parametri
;;      ----> elementele pot fi si atomi si liste
;; (cons '1 '2) ----> (1 . 2)
;; (cons '1 '(2 3 4)) ----> (1 2 3 4)
;; (cons '(1 1 1) '(2 3 4)) ----> ((1 1 1) 2 3 4)
;; (cons '(1 1 1) '2) ----> ((1 1 1) . 2)

;; ca sa ramana prima lista sublista => cons
;; lista liniara => append

;; oddp -> isOdd ---- (oddp 1) => T
;; evenp -> isEven ---- (evenp 1) => F/Nil
;; (= 0 (mod 6 2))

;; equal ---- mere cu toate si cu liste intregi === WOW
;; eq ---- the same object
;; setq pentru definit variabile


;; Sa se stearga atomii nenumerici dintr-o lista
;; sterge(l1..ln) :=
;;      [], n = 0
;;      l1 U sterge(l2..ln), l1 e atom numeric
;;      sterge(l2..ln), l1 e atom nenumeric
;;      sterge(l1) U sterge(l2..ln), l1 e lista

;; (defun sterge (l) 
;; (cond
;; ((null l) nil)
;; ((numberp (car l)) (cons (car l) (sterge (cdr l))))
;; ((atom (car l)) (sterge ( cdr l)))
;; (t (cons (sterge (car l)) (sterge (cdr l))))
;; )
;; )

;; (format t "~s" (sterge '(1 2 3 4 e d f g (e))))


;; factorial(n) :=
;;      1, n = 0
;;      n * factorail(n-1), otherwise

;; (defun factorial (n)
;; (cond
;; ((= n 0) 1)
;; (t (* n (factorial (- n 1))))
;; )
;; )


;; (format t "~s" (factorial 5)) 


;; 11.
;; a) Determine the least common multiple of the numerical 
;; values of a nonlinear list.
;; b) Write a function to test if a linear list of numbers has 
;; a "mountain" aspect (a list has a "mountain"aspect if the 
;; items increase to a certain point and then decreases.
;;  Eg. (10 18 29 17 11 10). The list must have at least 
;; 3 atoms to fullfil this criteria.
;; c) Remove all occurrences of a maximum numerical element 
;; from a nonlinear list.
;; d) Write a function which returns the product of numerical
;;  even atoms from a list, to any level.

;; Solutions


;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; a)
;; gcd(n1, n2) - returns the greatest common divisor

;; (defun hcd (n m)
;; (cond
;; ((/= m 0) (hcd m (mod n m) ) )
;; (t n)
;; )
;; )

;; (defun lcmn (n m)
;;     (/ (* n m) (hcd n m))
;; )

;; (defun lcml (lista current)
;; (cond
;; ((null lista) current)
;; ((numberp (car lista)) (lcml (cdr lista) (lcmn (car lista) current)) )
;; ((atom (car lista)) (lcml (cdr lista ) current) )
;; (t (lcml (cdr lista) (lcmn (lcml (car lista) 1) current) ) )
;; )
;; )

;; (defun hasNumber (lista)
;; (cond
;; ((null lista) nil)
;; ((numberp (car lista)) t)
;; (t (hasNumber (cdr lista)) ) 
;; )
;; )

;; (defun lcmlWrapper (lista)
;; (cond
;; ((hasNumber lista) (lcml lista 1))
;; (t 0)
;; )
;; )


;; (format t "~d" (lcmlWrapper '("b" (5 2) 3 7 "a") ))
;; (terpri)
;; (format t "~d" (lcmlWrapper '("b" "a") ))

;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; b) Write a function to test if a linear list of numbers has 
;; a "mountain" aspect (a list has a "mountain"aspect if the 
;; items increase to a certain point and then decreases.
;;  Eg. (10 18 29 17 11 10). The list must have at least 

;; (defun isMountain (lista flag)
;; (cond
;; ((and (<= (length lista) 1) (= flag 0)) nil )
;; ((and (<= (length lista) 1) (= flag 1)) t)
;; ((and (< (car lista) (car (cdr lista))) (= flag 0)) (isMountain (cdr lista) 0 ))
;; ((and (>= (car lista) (car (cdr lista))) (= flag 0)) (isMountain (cdr lista) 1 ))
;; ((and (> (car lista) (car (cdr lista))) (= flag 1)) (isMountain (cdr lista) 1 ))
;; (t nil)
;; )
;; )

;; (defun isMountainWrapper (lista)
;; (isMountain lista 0)
;; )

;; (write (isMountainWrapper '(1 2 3 2 1)) )


;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; c) Remove all occurrences of a maximum numerical element 
;; from a nonlinear list.

;; (defun findMax (lista current)
;; (cond
;; ((null lista) current)
;; ((and (numberp (car lista)) (> (car lista) current)) (findMax (cdr lista) (car lista)) ) 
;; ((atom (car lista)) (findMax (cdr lista) current))
;; (t (findMax (cdr lista) (findMax (car lista) current) ))
;; )
;; )

;; (defun removeMax (lista maxValue)
;; (cond
;; ((null lista) nil)
;; ((and (numberp (car lista)) (= maxValue (car lista))) (removeMax (cdr lista) maxValue) )
;; ((atom (car lista)) (cons (car lista) (removeMax (cdr lista) maxValue)) )
;; (t (cons (removeMax (car lista) maxValue) (removeMax (cdr lista) maxValue)))
;; )
;; )

;; (defun removeMaxWrapper (lista)
;; (removeMax lista (findMax lista 0))
;; )

;; (write (removeMaxWrapper '(1 2 (3 55) 4 55 ))) 

;; (defun sterge (l) 
;; (cond
;; ((null l) nil)
;; ((numberp (car l)) (cons (car l) (sterge (cdr l))))
;; ((atom (car l)) (sterge ( cdr l)))
;; (t (cons (sterge (car l)) (sterge (cdr l))))
;; )
;; )


;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; -------------------------------------------------------------
;; d) Write a function which returns the product of numerical
;;  even atoms from a list, to any level.

;; (defun evenProduct (lista)
;; (cond
;; ((and (numberp lista) (= (mod lista 2) 0)) lista)
;; ((atom lista) 1)
;; (t (* (evenProduct (car lista)) (evenProduct (cdr lista)) ) )
;; )
;; )

;; (defun hasEvenNumber (lista)
;; (cond
;; ((null lista) nil)
;; (( and(numberp (car lista)) (= (mod (car lista) 2) 0) ) t)
;; (t (hasEvenNumber (cdr lista)) ) 
;; )
;; )

;; (defun evenProductWrapper (lista)
;; (cond
;; ((hasEvenNumber lista) (evenProduct lista))
;; (t 0)
;; )
;; )

;; (format t "~d" (evenProductWrapper '("b" (5 2) 3 2 4 "a") ))
;; (terpri)
;; (format t "~d" (evenProductWrapper '("b" (5) 3 "a") ))



;; -------------------------------------------------------------------
;; -------------------------------------------------------------------
;; ---------------------------- Seminar 5 ---------------------------- 
;; -------------------------------------------------------------------
;; -------------------------------------------------------------------




;; (format t "This is seminar 5.")
;; (terpri)
;; (format t "Problem 1:")
;; (terpri)

;; (defun mergeList (l1 l2)
;; (cond
;; ((or (null l1) (null l2)) (append l1 l2))
;; ;; ((null l2) l1)
;; ;; ((null l1) l2)
;; ((< (car l1) (car l2)) (cons (car l1) (mergeList (cdr l1) l2) ))
;; ((< (car l2) (car l1)) (cons (car l2) (mergeList l1 (cdr l2)) ))
;; ((= (car l1) (car l2)) (cons (car l1) (mergeList (cdr l1) (cdr l2))))
;; )
;; )

;; (format t "~s" (mergeList '(1 3 5) '(1 2 3 7)))
;; (terpri)

;; (format t "Problem 2:")
;; (terpri)

;; ;; (defun remove_occurences (l el)
;; ;; (cond
;; ;; ((and (atom l) (equal l el)) nil)
;; ;; ((atom l) (list l))
;; ;; (t (append (remove_occurences (car l) el) (remove_occurences (cdr l) el)))
;; ;; )
;; ;; )

;; (defun remove_occurences (l el)
;; (cond
;; ((null l) nil)
;; ((equal (car l) el) (remove_occurences (cdr l) el))
;; ((atom (car l)) (cons (car l) (remove_occurences (cdr l) el)) )
;; (t (cons (remove_occurences (car l) el) (remove_occurences (cdr l) el)))
;; )
;; )

;; (format t "~s" (remove_occurences '(1 2 1 3 1 4 5 (1 1)) 1))
;; (terpri)

;; (format t "Problem 3: ")
;; (terpri)

;; (defun MinimumNumber (l myMin pos i)
;; (cond
;; ((null l) pos)
;; ((equal (car l) myMin) (MinimumNumber (cdr l) myMin (append pos (list i)) (+ i 1) ) )
;; (( and (numberp (car l)) (or (null myMin) (< (car l) myMin))) (MinimumNumber (cdr l) (car l) (list i) (+ i 1)) )
;; (t (MinimumNumber (cdr l) myMin pos (+ i 1)))
;; )
;; )


;; (format t "~s" (MinimumNumber '(2 2 1 3 1) nil nil 1))
;; (terpri)

;; (defun isInList (l elem)
;; (cond
;; ((null l) nil)
;; ((equal (car l) elem) t)
;; ((listp (car l)) (or (isInList (car l) elem) (isInList (cdr l) elem)) )
;; (t (isInList (cdr l) elem))
;; )
;; )

;; (defun replaceFirst (l el o)
;; (cond
;; ((null l) nil)
;; ((equal (car l) el) (cons o (cdr l)))
;; ((atom (car l)) (cons (car l) (replaceFirst (cdr l) el o)))
;; ((isInList (car l) el) (cons (replaceFirst (car l) el o) (cdr l)))
;; (t (cons (car l) (replaceFirst (cdr l) el o)))
;; )
;; )

;; (write (replaceFirst '(2 2 3 (2 ("a")) "a" 1 4 1 5 ) "a" "b"))


;; (defun getSublists (l)
;; (cond
;; ((null l) nil)
;; ((atom (car l)) (getSublists (cdr l)) )
;; (t (cons (car l) ( append (getSublists (car l)) (getSublists (cdr l))) ))
;; )
;; )

;; (defun getSublistsWrapper (l)
;;     (cons l (getSublists l))
;; )


;; (write (getSublistsWrapper '(1 2 (3 (4 5) (6 7)) 8 (9 10))))


;; (defun f (l)
;; (cond
;; ((null l) t)
;; (((lambda (v)
;;     (cond
;;     ((numberp v) t)
;;     (t nil)
;;     )
;;     )
;;     (car l)
;;     ) nil)
;; (t (f (cdr l)))
;; )
;; )

;; (write (f '(a b 1 d (c 1))))

;; (defun atomii (l)
;; (cond
;; ((atom l) (list l))
;; (t (mapcan #'atomii l))
;; )
;; )

;; (defun nrap (k l)
;; (cond
;; ((and (atom l) (not (equal k l))) 0)
;; ((equal k l) 1)
;; (t (apply #'+ (mapcar #'(lambda (L) 
;;                             (nrap k L)
;;                         ) l)))
;; )
;; )

;; (defun sterge (l)
;; (cond
;; (( and (numberp l) (< l 0)) nil )
;; ((atom l) (list l))
;; (t (list (apply #'append (mapcar #'sterge l))))
;; )
;; )

;; (defun stergere (l)
;;     (car (sterge l))
;; )

;; (defun nrNoduri (l)
;; (cond
;; ((atom l) 1)
;; (t (apply #'+ (mapcar #'nrNoduri l)))
;; )
;; )

;; (defun adancime (l)
;; (cond
;; ((null (cdr l)) 0)
;; (t (+ 1 (apply #'max (mapcar #'adancime (cdr l)))))
;; )
;; )

;; (defun lista (l a k)
;; (cond
;; ((> k a) nil)
;; ((and (equal a k) (atom l)) (list l))
;; ((atom l) nil)
;; (t (mapcan #'(lambda (L)
;;               (lista L a (+ 1 k))  
;;             ) l) )
;; )
;; )



;; -------------------------------------------------------------------
;; -------------------------------------------------------------------
;; ---------------------------- Seminar 6 ---------------------------- 
;; -------------------------------------------------------------------
;; -------------------------------------------------------------------

;; (format t "Seminar 6:")
;; (terpri)

;; ;; Problem 1
;; ;; Compute the product of the numbers from a list.

;; (defun product (l)
;; (cond
;; ((numberp l) l)
;; ((atom l) 1)
;; (t (apply #'* (mapcar #'product l)))
;; )
;; )

;; (write (product '((1 A (2 C 3) 6 (A (B 5) 2) 5))))
;; (terpri)

;; ;; Problem 2
;; ;; Compute the number of nodes from the even levels of an n-ary
;; ;; tree represented as (root (subtree_1) (subtree_2) ... (subree_n))
;; ;; Ex: ()

;; (defun no_of_even_aux (l level)
;; (cond
;; ((and (atom l) (evenp level)) 1)
;; ((atom l) 0)
;; (t (apply #'+ (mapcar #'(lambda (L) (no_of_even_aux L (+ 1 level))) l )))
;; )
;; )

;; (defun no_of_even (l)
;;     (no_of_even_aux l 0)    
;; )


;; (write (no_of_even '(a (b (c)) (d) (e (f))) ))
;; (terpri)

;; ;; Problem 3
;; ;; You are given a nonlinear list. Compute the number of sublists 
;; ;; (including the initial list) where the first numeric atom (on any level) 
;; ;; is 5. For example, for the list 
;; ;; (A 5 (B C D) 2 1 (G (5 H) 7 D) 11 14) 
;; ;; the lists that should be counted are: (5 H), the initial list, 
;; ;; (G (5 H) 7 D) => 3

;; (format t "Problem 3:")
;; (terpri)


;; ;; TODO ---- fix this function because it's not completely right!
;; (defun validate (l)
;; (cond
;; ((null l) nil)
;; ((atom l) nil)
;; ((eq 5 (car l)) T)
;; ((numberp (car l)) nil)
;; ((atom (car l)) (validate (cdr l)))
;; ((validate (car l)) T)
;; (t (validate (cdr l)))
;; )
;; )

;; (defun count_sublists (l)
;; (cond
;; ((atom l) 0)
;; ((validate l) (+ 1 (apply #'+ (mapcar #'count_sublists l)  )))
;; (t (apply #'+ (mapcar #'count_sublists l)) )
;; )
;; )

;; (write (count_sublists '(G (5 H) 7 D)  ))
























;; -------------------------------------------------------------------
;; -------------------------------------------------------------------
;; ---------------------------- Exam Prep ---------------------------- 
;; -------------------------------------------------------------------
;; -------------------------------------------------------------------




;; get the number of sublists at any level of a given list,
;; having an odd number of nonnumeric atoms on even levels


;; (defun odd_on_even (l level)
;; (cond
;; ((null l) 0)
;; ((numberp (car l)) (odd_on_even (cdr l) level))
;; ((and (= (mod level 2) 0) (atom (car l))) (+ 1 (odd_on_even (cdr l) level)) )
;; ((atom (car l)) (odd_on_even (cdr l) level) )
;; (t (+ (odd_on_even (car l) (+ level 1)) (odd_on_even (cdr l) level) ) )
;; )
;; )

;; (defun isValid (l)
;; (cond
;; ((atom l) 0)
;; (( = ( mod (odd_on_even l 1) 2) 1) 1)
;; (t 0)
;; )
;; )

;; (defun collect (l)
;; (cond
;; ((null l) 0)
;; ((atom (car l)) (collect (cdr l)))
;; ((listp (car l)) 
;;     (cond 
;;     ((isValid (car l)) (+ 1 (collect (car l)) (collect (cdr l))) )
;;     (t (+ (collect (car l)) (collect (cdr l)) ))
;;     )
;; )
;; )
;; )

;; (defun collect (l) 
;; (cond
;; ((null l) 0)
;; ((atom l) 0)
;; (t  (cond
;;         ((isValid (car l)) (+ 1 (collect (car l)) (collect (cdr l))) )
;;         (t (+ (collect (car l)) (collect (cdr l)) ))
;;     )
;; )
;; )
;; )

;; (defun collect (l) 
;; (cond
;; ((null l) 0)
;; ((atom l) 0)
;; (t  (apply #'+ (cons (isValid l)
;;                 (mapcar #'collect l)
;;                 ))
;;     )
;; )
;; )


;; (defun collectWrapper (l)
;; (cond
;; ((isValid l) (- (collect l) 1))
;; (t (collect l))
;; )
;; )

;; (write (collectWrapper '(a (b 2) (1 c 4) (1 (6 f)) (((g) 4) 6) ) ))







;; get the number of sublists at any level of a given list,
;; where the last atom (at any level) is nonnumeric


;; (defun lastnn (l)
;; (cond
;; ((and (null (cdr l)) (numberp (car l))) 0)
;; ((and (null (cdr l)) (atom (car l))) 1)
;; ((and (null (cdr l)) (listp (car l))) (lastnn (car l)))
;; (t (lastnn (cdr l)))
;; )
;; )

;; (defun collect2 (l) 
;; (cond
;; ((null l) 0)
;; ((atom l) 0)
;; (t  (apply #'+ (cons (lastnn l)
;;                 (mapcar #'collect2 l)
;;                 ))
;;     )
;; )
;; )


;; (defun collectWrapper (l)
;; (cond
;; ((lastnn l) (- (collect2 l) 1))
;; (t (collect2 l))
;; )
;; )


;; (write (collectWrapper '(a (b 2) (1 c 4) (d 1 (6 f)) ((G 4) 6) f )))

























































