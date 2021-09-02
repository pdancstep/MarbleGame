#lang racket
(require plot "utils.rkt")
(provide track% linear% make-htrack make-rot-track)

(define track%
  (class object%
    (init type render)
    (super-new) ; required

    (define transform type) ; not used yet
    (define renderer render)

    (define/public (near? x y) #f) ; need a specific track type to determine if we're close to a point
    (define/public (get-render) renderer)))

(define linear%
  (class track%
    (init p1 p2 type render)
    (super-new [type type] [render render])

    (define x1 (car p1))
    (define y1 (cdr p1))
    (define x2 (car p2))
    (define y2 (cdr p2))

    (define/public (slope)
      (let ([dy (- y2 y1)]
            [dx (- x2 x1)])
        (if (zero? dx)
            #f
            (/ dy dx))))

    (define/override (near? x y)
      (< (distance-from-line-segment x y x1 y1 x2 y2) CLICK-TOLERANCE))

    ))

(define arc%
  (class track%
    (init θmin θmax r type render)
    (super-new [type type] [render render])

    (define arc-begin θmin)
    (define arc-end θmax)
    (define radius r)
    
    (define/override (near? x y)
      (let* ([p (make-rectangular x y)]
             [r (magnitude p)]
             [θ (angle p)])
        (and (< (abs (- radius r)) CLICK-TOLERANCE)
             (cond
               [(< θ arc-begin) (< (- arc-begin θ) CLICK-TOLERANCE)]
               [(< θ arc-end) #t]
               [else (< (- θ arc-end) CLICK-TOLERANCE)]))))
    ))


(define (make-htrack xmin xmax y [type '+] #:color [c 'lightblue])
  (new linear%
       [p1 (cons xmin y)] [p2 (cons xmax y)] [type type]
       [render (lines `((,xmin ,y) (,xmax ,y)) #:width TRACK-PIXELS #:color c)]))

(define (make-rot-track θmin θmax r [type '+] #:color [c 'orange])
  (new arc%
       [θmin θmin] [θmax θmax] [r r] [type type]
       [render (polar (λ (θ) r) θmin θmax #:width TRACK-PIXELS #:color c)]))
