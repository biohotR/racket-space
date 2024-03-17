#lang racket

(define (remove-duplicates-left L)
  (foldl (lambda (item acc)
           (if (member item acc)
               acc
               (cons item acc)))
         '()
         L)
)

(define (remove-duplicates-right L)
    (foldr (lambda (x acc)
            (if (member x acc)
                acc
                (cons x acc))
        )
        '()
        L
    )
)

(define (overlay-> initial images)
    (foldl (lambda (acc img)
            (overlay acc img))
            initial
            images
    )
)

(define (uncurry->curry f)
  (lambda (x)
    (lambda (y)
      (f x y))))



;; Implementați funcția slim-horizontal care primește ca parametru o
;; matrice de imagini și întoarce o listă în care fiecare element reprezintă
;; imaginile suprapuse (stânga -> dreapta) de pe o linie.
;; Funcția trebuie implementată fără a folosi recursivitate explicit,
;; ci utilizând doar funcționale.
;; Hints: - Folosiți funcția overlay-> și funcția uncurry->curry
;;        - Pentru fundalul imaginilor puteți să folosiți empty-image

(define (slim-horizontal matrix)
  (map (lambda (row)
        (((uncurry->curry overlay->) empty-image) row))
        matrix
  )
)

;; Implementați funcția transpose care obține transpusa matricei dată
;; ca parametru.
;; Funcția trebuie implementată folosind cel puțin o funcțională.

(define (transpose matrix)
  (if (null? (car matrix)) ;; verifica daca primul rand e gol - caz de baza
        '()                ;; daca - returneaza o lista goala
        (cons (map car matrix)  ;; construieste o lista noua cu primul element al fiecarui rand (defapt prima coloana)
            (transpose (map cdr matrix)) ;; apel recursiv asupra unei matrice formate din restul coloanelor (fara prima)
            )
    )
)

(define (overlay<- initial images)
  (foldr (lambda (acc img)
        (overlay acc img))
        initial
        images
  )
)

;; Implementați funcția slim-vertical care primește ca parametru o
;; matrice de imagini și întoarce o listă în care fiecare element reprezintă
;; imaginile suprapuse (jos -> sus) de pe o coloană.
;; Funcția trebuie implementată fără a folosi recursivitate explicit,
;; ci utilizând doar funcționale.

(define (slim-vertical matrix)
  (let [(transpose-matrix (transpose matrix))
        ]
        (map (lambda (row)
            (overlay<- empty-image row))
        transpose-matrix)
  )
)
