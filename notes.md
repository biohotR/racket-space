# Includes stuff that I feel are important

## Higher order functions in racket

### map
**map** is higher-order function that applies a given function to each element of one or more lists
collecting the result in a new list that it returns

Basic overview:
``(map function list1 list2)``

Simple example:
``(map + '(1 2 3) '(4 5 6))`` ;; will return '(5 7 9)

### filter
**filter** returns the elements of the list that satisfy a predicate p

Basic overview:
``(filter p L)``

Simple example:
``(filter (lambda (x) (>= x 5)) '(5 3 1 7 9))`` ;; returns '(5 7 9)


### foldl
**foldl** iteratively applies a function f to an accumulator and the elements of one or more lists,
from left to right, therefore "folding" into a single value

Basic overview:
``(foldl f acc L)``

Simple example:
``(foldl + 0 '(1 2 2 5))`` ;;  returns 10
