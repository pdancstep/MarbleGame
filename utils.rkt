#lang racket
(require plot)
(provide unit-circle PLOT-X-MIN PLOT-X-MAX PLOT-Y-MIN PLOT-Y-MAX
         MARBLE-PIXELS TRACK-PIXELS
         CLICK-TOLERANCE
         distance
         distance-from-line-segment)


(define unit-circle (polar (λ (θ) 1) #:color 'black))
(define PLOT-X-MIN -4)
(define PLOT-X-MAX 4)
(define PLOT-Y-MIN -4)
(define PLOT-Y-MAX 4)

(define MARBLE-PIXELS 12)
(define TRACK-PIXELS 18)


; how close do we need to be to the center of a marble to click it?
(define CLICK-TOLERANCE 0.05)


; pythagorean distance between 2 points in the plane
(define (distance x1 y1 x2 y2) (sqrt (+ (sqr (- x1 x2)) (sqr (- y1 y2)))))

; find the smallest distance from (x,y) to the line segment connecting (x1,y1) with (x2,y2)
(define (distance-from-line-segment x y x1 y1 x2 y2)
  (let ([d1 (distance x y x1 y1)]
        [d2 (distance x y x2 y2)]
        [length (distance x1 y1 x2 y2)]
        [area (abs (- (* (- x2 x1) (- y1 y)) (* (- x1 x) (- y2 y1))))])
    ; this is the distance from the LINE; need to figure out checking if we're off the ends
    (/ area length)))

