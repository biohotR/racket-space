#lang racket
(define (compare imga imgb)
    (or (> (image-height imga) (image-height imgb))
        (and (= (image-height imga) (image-height imgb))
            (> (image-width imga) (image-width imgb))))
)

;; the split function splits the list into two halves by appending to the left list every other element

(define (split lst)
    (let loop ((left '())
                (right lst)
                switch #t))
    (if (empty? right)
        (values (reverse left) right)
        (if switch
            (loop (cons (car right) left)
                (cdr right)
                (not switch))
            (loop left
                (cdr right)
                (not switch))
        )
    )
)


(define (mergesort lst)
  (cond
    [(empty? lst) lst]
    [(empty? (cdr lst)) lst]
    [else
     (let-values (((left right) (split-list lst)))
       (merge (mergesort left) (mergesort right)))]))



