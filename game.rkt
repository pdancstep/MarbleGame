#lang racket
(require plot "components.rkt" "marble.rkt" "level.rkt" "utils.rkt")


(define example1
  (make-level (list (htrack -2 2 -2)
                    (rot-track (/ pi 2) pi 3 '*)
                    (make-marble 2 -2)
                    (make-marble -3 0))))

example1
