#lang racket
(require "components.rkt" "level.rkt"
         "principles.rkt"
         "additive.rkt" "opposing-inputs.rkt"
         "rotation.rkt" "scaling.rkt" "zero-point.rkt"
         "ratchet.rkt"
         "sharing.rkt")

(define arctest
  (make-level (make-rot-track pi (* 3/2 pi) 2)
              (make-rot-track pi (* 3/2 pi) 2 #:center 0+2i)
              (make-rot-track (* 7/4 pi) (* 9/4 pi) 2 #:center 1)))
