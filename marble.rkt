#lang racket
(require plot)
[plot-x-ticks no-ticks]
[plot-y-ticks no-ticks]
[plot-x-label #f]
[plot-y-label #f]

(define unit-circle (polar (λ (θ) 1) #:color 'black))
(define PLOT-X-MIN -4)
(define PLOT-X-MAX 4)
(define PLOT-Y-MIN -4)
(define PLOT-Y-MAX 4)

(define (marble x y #:color [c 'black])
  (cons `(marble ,x ,y)
        (points `((,x ,y)) #:sym 'fullcircle #:size 12 #:color c)))

(define (htrack xmin xmax y [type '+] #:color [c 'lightblue])
  (cons `(track linear ((,xmin ,y) (,xmax ,y)) ,type)
        (lines `((,xmin ,y) (,xmax ,y)) #:width 18 #:color c)))

(define (rot-track θmin θmax r [type '+] #:color [c 'orange])
  (cons `(track arc TODO ,type)
        (polar (λ (θ) r) θmin θmax #:width 18 #:color c)))

(define ((build-mouse-handler components) level event x y)
  (cond [(send event button-down? 'left)
         ; on mouse-down, determine which marble and track we are on
         ]
        [(send event button-up? 'left) #f]
        [(send event dragging?) #f]))

(define (make-level components)
  (define level-plot
    (plot (cons unit-circle (map cdr components))
          #:x-min PLOT-X-MIN
          #:x-max PLOT-X-MAX
          #:y-min PLOT-Y-MIN
          #:y-max PLOT-Y-MAX))
  (send level-plot set-mouse-event-callback (build-mouse-handler components))
  level-plot)

(make-level (list (htrack -2 2 -2)
                  (rot-track (/ pi 2) pi 3 '*)
                  (marble 2 -2)
                  (marble -3 0)))
