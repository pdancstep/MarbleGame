#lang racket
(require plot "components.rkt" "level.rkt" "utils.rkt")


(define example1
  (make-level (list (htrack -2 2 -2)
                    (rot-track (/ pi 2) pi 3 '*)
                    (marble 2 -2)
                    (marble -3 0))))

example1
