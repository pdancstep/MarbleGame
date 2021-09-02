#lang racket
(require "components.rkt" "level.rkt")


(define example1
  (make-level (list (make-htrack -2 2 -2)
                    (make-rot-track (/ pi 2) pi 3 '*)
                    (make-marble 2 -2)
                    (make-marble -3 0))))

example1
