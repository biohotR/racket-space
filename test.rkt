#lang racket

(define (remove-duplicates-left L)
    (define (helper L acc)
        (if (null? L)
            (reverse acc)
            
        (if (member (car L) acc)
            (helper (cdr L) acc)
            (helper (cdr L) (cons (car L) acc))))
    )
    (helper L '())
)

(define (remove-duplicates-right L)
    )