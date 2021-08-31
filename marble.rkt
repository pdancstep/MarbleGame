#lang racket
(require plot)

[plot-x-ticks no-ticks]
[plot-y-ticks no-ticks]
[plot-x-label #f]
[plot-y-label #f]

(define unit-circle (polar (λ (θ) 1) #:color 'black))

(define (marble x y #:color [c 'black])
  (points `((,x ,y)) #:sym 'fullcircle #:size 12 #:color c))

(define (htrack xmin xmax y #:color [c 'lightblue])
  (lines `((,xmin ,y) (,xmax ,y)) #:width 18 #:color c))

(define (rot-track θmin θmax r #:color [c 'orange])
  (polar (λ (θ) r) θmin θmax #:width 18 #:color c))

(define level
  (plot (list unit-circle
              (htrack -2 2 -2)
              (rot-track (/ pi 2) pi 3)
              (marble 2 -2)
              (marble -3 0))
        #:x-min -4
        #:x-max 4
        #:y-min -4
        #:y-max 4))

; figure out what a callback function for mouse events looks like, write it,
; and put it in place of the #f here
(send level set-mouse-event-callback #f)

level
