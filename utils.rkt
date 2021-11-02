#lang racket
(require plot)
(provide unit-circle PLOT-X-MIN PLOT-X-MAX PLOT-Y-MIN PLOT-Y-MAX
         MARBLE-PIXELS TRACK-PIXELS
         CLICK-TOLERANCE
         normalize-angle
         distance
         complex-distance
         distance-from-line
         angle-in-degrees
         match-labels
         xor-warn)


(define unit-circle (polar (λ (θ) 1) #:color 'black))
(define PLOT-X-MIN -4)
(define PLOT-X-MAX 4)
(define PLOT-Y-MIN -4)
(define PLOT-Y-MAX 4)

(define MARBLE-PIXELS 12)
(define TRACK-PIXELS 18)


; how close do we need to be to the center of a marble to click it?
(define CLICK-TOLERANCE 0.12)

(define (normalize-angle θ)
  (cond
    [(< θ 0) (normalize-angle (+ θ (* 2 pi)))]
    [(< (* 2 pi) θ) (normalize-angle (- θ (* 2 pi)))]
    [else θ]))

; pythagorean distance between 2 points in the plane
(define (distance x1 y1 x2 y2) (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2)))))
(define (complex-distance z1 z2) (magnitude (- z1 z2)))

; find smallest distance from (x,y) to the line through (x1,y1) and (x2,y2)
(define (distance-from-line x y x1 y1 x2 y2)
  (let ([d1 (distance x y x1 y1)]
        [d2 (distance x y x2 y2)]
        [length (distance x1 y1 x2 y2)]
        [area (abs (- (* (- x2 x1) (- y1 y)) (* (- x1 x) (- y2 y1))))])
    (/ area length)))

; angle of a given coordinate in degrees, as a string. use only for printing user-friendly output
(define (angle-in-degrees x y)
  (string-append (number->string (inexact->exact (round (* (/ 180 pi) (normalize-angle (angle (make-rectangular x y)))))))
                 "°"))

; do the arguments have any labels in common?
(define (match-labels left right)
  (let ([ls (flatten left)]
        [rs (flatten right)])
    (ormap (λ (l) (member l rs)) ls)))

; get the non-false value if there is exactly one, log error if there are multiple
(define ((xor-warn message) . ls)
  (let ([tail (memf identity ls)]) ; find first non-false element
    (if tail ; did we find one?
        (begin (when (ormap identity (cdr tail))
                 (log-warning message)) ; rest of list should be false
               (car tail))
        #f)))
