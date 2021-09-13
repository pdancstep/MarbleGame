#lang racket
(require "components.rkt" "level.rkt")


(define example1
  (make-level (list (make-htrack -2 2 -2)
                    (make-rot-track (/ pi 2) (* 6/5 pi) 3 '*)
                    (make-marble 2 -2)
                    (make-vtrack 0 -2 3)

                    (make-marble 0 -2)
                    (make-rot-track (* 7/4 pi) (* 9/4 pi) 2)
                    
                    (make-linear-track 0 -1 2 0))))

example1
