#lang racket

; (define (remove-duplicates-left L)
;   (foldl (lambda (item acc)
;            (if (member item acc)
;                acc
;                (cons item acc)))
;          '()
;          L)
; )

; (define (remove-duplicates-right L)
;     (foldr (lambda (x acc)
;             (if (member x acc)
;                 acc
;                 (cons x acc))
;         )
;         '()
;         L
;     )
; )

; (define (overlay-> initial images)
;     (foldl (lambda (acc img)
;             (overlay acc img))
;             initial
;             images
;     )
; )

; (define (uncurry->curry f)
;   (lambda (x)
;     (lambda (y)
;       (f x y))))



;; Implementați funcția slim-horizontal care primește ca parametru o
;; matrice de imagini și întoarce o listă în care fiecare element reprezintă
;; imaginile suprapuse (stânga -> dreapta) de pe o linie.
;; Funcția trebuie implementată fără a folosi recursivitate explicit,
;; ci utilizând doar funcționale.
;; Hints: - Folosiți funcția overlay-> și funcția uncurry->curry
;;        - Pentru fundalul imaginilor puteți să folosiți empty-image

; (define (slim-horizontal matrix)
;   (map (lambda (row)
;         (((uncurry->curry overlay->) empty-image) row))
;         matrix
;   )
; )

;; Implementați funcția transpose care obține transpusa matricei dată
;; ca parametru.
;; Funcția trebuie implementată folosind cel puțin o funcțională.

; (define (transpose matrix)
;   (if (null? (car matrix)) ;; verifica daca primul rand e gol - caz de baza
;         '()                ;; daca - returneaza o lista goala
;         (cons (map car matrix)  ;; construieste o lista noua cu primul element al fiecarui rand (defapt prima coloana)
;             (transpose (map cdr matrix)) ;; apel recursiv asupra unei matrice formate din restul coloanelor (fara prima)
;             )
;     )
; )

; (define (overlay<- initial images)
;   (foldr (lambda (acc img)
;         (overlay acc img))
;         initial
;         images
;   )
; )

;; Implementați funcția slim-vertical care primește ca parametru o
;; matrice de imagini și întoarce o listă în care fiecare element reprezintă
;; imaginile suprapuse (jos -> sus) de pe o coloană.
;; Funcția trebuie implementată fără a folosi recursivitate explicit,
;; ci utilizând doar funcționale.

; (define (slim-vertical matrix)
;   (let [(transpose-matrix (transpose matrix))
;         ]
;         (map (lambda (row)
;             (overlay<- empty-image row))
;         transpose-matrix)
;   )
; )

;; Implementați funcția matrix-to-image care primește o matrice de imagini
;; și întoarce reprezentarea sub formă de imagine a acesteia folosind
;; funcțiile beside (reunește imaginile date ca parametri pe orizontală)
;; și above (reunește imaginile date ca parametri pe verticală).
;; Funcția trebuie implementată fără a folosi recursivitate explicit,
;; ci utilizând doar funcționale.

; (define (matrix-to-image matrix)
;     (define (row-to-image row)
;             (foldr beside empty-image row))
;     (define (rows-to-image rows)
;             (foldl above empty-image rows))
;     (rows-to-image (map row-to-image matrix)) 
; )

;; Pornind de la o listă de imagini L, se dorește:
;; (a) păstrarea doar a celor a căror înălțime este mai mare decât min-height;
;;     - pentru determinarea înălțimii, folosiți funcția (image-height img) care primește
;;     ca parametru o imagine img și întoarce înălțimea acesteia, ca integer
;; (b) construirea unei matrice, ale cărei linii sunt identice cu lista rezultată
;;     în urma punctului (a), dar în care fiecare imagine de pe diagonala principală
;;     este acum rotită cu 30 de grade înmulțit cu numărul liniei pe care se află (numerotarea
;;     liniilor va începe de la 1).
;; ATENȚIE! Utilizați funcționale în implementare! NU este permisă simularea accesului
;; aleator în listă (take, drop, list-ref sau alte funcții definite de voi în acest scop).
;; Rotirea unei imagini se poate face cu ajutorul funcției (rotate angle image) care primește ca
;; argumente un unghi (angle) și o imagine (image), întorcând astfel imaginea inițială, rotită cu
;; angle grade, în sens trigonometric.
;; Exercițiul nu trebuie rezolvat exclusiv cu funcționale, ci se poate combina cu recursivitate.

;; subpunctul a
(define (filter-by-height L min-height)
    (filter (lambda (img)
        (> (image-height img) min-height)) L
    )
)
;subpunctul b
(define (rotate-diag images min-height)
  (let ((filtered-images (filter-by-height images min-height)))
    (let build-matrix ((rows (length filtered-images)) (current-row 1))
      (if (> current-row rows)
          '()
          (cons (build-and-rotate-row filtered-images current-row)
                (build-matrix rows (+ current-row 1)))))))

(define (build-and-rotate-row images row-index)
  (map-indexed (lambda (index img)
                 (if (= index row-index)
                     (rotate (* 30 row-index) img)
                     img))
               images))

(define (map-indexed f lst)
  (letrec ((helper (lambda (lst index)
                     (if (null? lst)
                         '()
                         (cons (f index (car lst))
                               (helper (cdr lst) (+ index 1)))))))
    (helper lst 1)))

(define (filter-by-height L min-height)
  (filter (lambda (img) (> (image-height img) min-height)) L))
