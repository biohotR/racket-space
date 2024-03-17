#lang racket

(define (to-numbers M)
  (if (null? M)
      '()
      (cons (to-number (car M)) (to-numbers (cdr M)))))
 
(to-numbers matrix) ; '(123 456 789)
