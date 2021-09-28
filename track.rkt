#lang racket
(require plot "utils.rkt")
(provide track% make-htrack make-vtrack make-linear-track make-rot-track make-goal)

(define track%
  (class object%
    (init type render)
    (super-new) ; required

    (define transform type) ; operation movement along this track represents (currently, + or *)
    (define renderer render)

    (define/public (get-oper)
      (match transform
        ['+ +]
        ['* *]
        [else identity]))
    
    (define/public (get-inverse)
      (match transform
        ['+ -]
        ['* /]
        [else identity]))
    (define/public (near? z) #f) ; need a specific track type to determine if we're close to a point
    (define/public (suggest-movement source target) #f) ; need track type to suggest any movement
    (define/public (get-render) renderer)))

(define linear%
  (class track%
    (init p1 p2 type render)
    (super-new [type type] [render render])

    (define z1 p1)
    (define z2 p2)
    (define x1 (real-part p1))
    (define y1 (imag-part p1))
    (define x2 (real-part p2))
    (define y2 (imag-part p2))
    

    (define slope (let ([dy (- y2 y1)]
                        [dx (- x2 x1)])
                    (if (zero? dx)
                        #f
                        (/ dy dx))))
    (define intercept (if slope
                          (- y1 (* x1 slope))
                          #f))

    (define (as-function x) (+ (* slope x) intercept))
    (define (as-inverse y) (/ (- y intercept) slope))

    (define/override (near? z)
      (let ([x (real-part z)]
            [y (imag-part z)])
        (cond
          ; vertical track
          [(= x1 x2) (and (< (abs (- x x1)) CLICK-TOLERANCE)
                          (< (- (min y1 y2) CLICK-TOLERANCE) y)
                          (< y (+ (max y1 y2) CLICK-TOLERANCE)))]
          ; point is past left end of track
          [(< x (min x1 x2)) (if (< x1 x2)
                                 (< (complex-distance z z1) CLICK-TOLERANCE)
                                 (< (complex-distance z z2) CLICK-TOLERANCE))]
          ; point is past right end of track
          [(< (max x1 x2) x) (if (< x1 x2)
                                 (< (complex-distance z z2) CLICK-TOLERANCE)
                                 (< (complex-distance z z1) CLICK-TOLERANCE))]
          ; point is within domain of track
          ; this is still not quite right: closest point on line could be outside line segment
          [else (< (distance-from-line x y x1 y1 x2 y2) CLICK-TOLERANCE)])))

    ; initial implmentation just pulls to closest point along steeper axis
    ; may want to refine
    (define/override (suggest-movement source target)
      (if (near? source)
          (let* ([x (real-part target)][xmin (min x1 x2)][xmax (max x1 x2)]
                 [y (imag-part target)][ymin (min y1 y2)][ymax (max y1 y2)]
                 [new-y (cond [(< y ymin) ymin] [(< ymax y) ymax] [else y])])
            (cond
              ; vertical track
              [(= x1 x2) (make-rectangular x1 new-y)]
              ; high slope: follow y-coordinate
              [(<= 1 (abs slope)) (make-rectangular (as-inverse new-y) new-y)]
              ; low slope: follow x-coordinate
              [else (let ([new-x (cond [(< x xmin) xmin] [(< xmax x) xmax] [else x])])
                      (make-rectangular new-x (as-function new-x)))]))
          ; marble is not near this track at all, so we don't want to propose moving it
          #f))))

(define arc%
  (class track%
    (init θmin θmax r center type render)
    (super-new [type type] [render render])

    (define arc-begin θmin)
    (define arc-end θmax)
    (define radius r)
    (define circle-center center)

    (define begin-point (+ (make-polar radius arc-begin) center))
    (define end-point (+ (make-polar radius arc-end) center))
    
    (define/override (near? z)
      (let* ([r (complex-distance z circle-center)]
             [θ (cond
                  [(zero? r) 0]
                  [(< (* 2 pi) arc-end) (+ (angle (- z circle-center)) (* 2 pi))]
                  [else (normalize-angle (angle (- z circle-center)))])])
        (and (< (abs (- radius r)) CLICK-TOLERANCE)
             (cond 
               [(< θ arc-begin) (< (- arc-begin θ) CLICK-TOLERANCE)]
               [(< θ arc-end) #t]
               [else (< (- θ arc-end) CLICK-TOLERANCE)]))))

    (define/override (suggest-movement source target)
      (if (near? source)
          (let* ([θ (if (< (* 2 pi) arc-end)
                        (+ (angle (- target circle-center)) (* 2 pi))
                        (normalize-angle (angle (- target circle-center))))])
            (cond
              [(< θ arc-begin) begin-point]
              [(< arc-end θ) end-point]
              [else (+ (make-polar radius θ) circle-center)]))
          ; marble is not near this track at all, so we don't want to propose moving it
          #f))))

(define goal%
  (class track%
    (init z render)
    (super-new [type #f] [render render])

    (define location z)

    (define/override (near? z)
      (< (complex-distance z location) CLICK-TOLERANCE))

    (define/override (suggest-movement source target)
      (if (and (near? source))
          location
          #f))))


(define (make-htrack xmin xmax y [type #f] #:color [c #f])
  (let ([color (or c (match type ['+ 'lightblue] ['* 'orange] [else 'gray]))])
    (new linear%
         [p1 (make-rectangular xmin y)] [p2 (make-rectangular xmax y)] [type type]
         [render (lines `((,xmin ,y) (,xmax ,y)) #:width TRACK-PIXELS #:color color)])))

(define (make-vtrack x ymin ymax [type #f] #:color [c #f])
  (let ([color (or c (match type ['+ 'lightblue] ['* 'orange] [else 'gray]))])
    (new linear%
         [p1 (make-rectangular x ymin)] [p2 (make-rectangular x ymax)] [type type]
         [render (lines `((,x ,ymin) (,x ,ymax)) #:width TRACK-PIXELS #:color color)])))

(define (make-linear-track x1 y1 x2 y2 [type #f] #:color [c #f])
  (let ([color (or c (match type ['+ 'lightblue] ['* 'orange] [else 'gray]))])
    (new linear%
         [p1 (make-rectangular x1 y1)] [p2 (make-rectangular x2 y2)] [type type]
         [render (lines `((,x1 ,y1) (,x2 ,y2)) #:width TRACK-PIXELS #:color color)])))


(define WIGGLE-ANGLE 0.01)
(define (make-rot-track θmin θmax r [type #f] #:color [c #f] #:center [center 0])
  (let* ([color (or c (match type ['+ 'lightblue] ['* 'orange] [else 'gray]))]
         [x (real-part center)]
         [y (imag-part center)]
         [make-render (λ (min max)
                        (parametric (λ (t) (list (+ (* r (cos t)) x) (+ (* r (sin t)) y)))
                                    min max #:width TRACK-PIXELS #:color color))])
    (if (>= θmax (* pi 2))
        (list (new arc%
                   [θmin θmin] [θmax (- (* pi 2) WIGGLE-ANGLE)]
                   [r r] [center center] [type type]
                   [render (make-render θmin (* pi 2))])
              (new arc%
                   [θmin (- (* pi 2) WIGGLE-ANGLE)] [θmax θmax]
                   [r r] [center center] [type type]
                   [render (make-render 0 (- θmax (* pi 2)))]))
        (new arc%
             [θmin θmin] [θmax θmax]
             [r r] [center center] [type type]
             [render (make-render θmin θmax)]))))
  
(define (make-goal x y #:color [c 'gray])
  (new goal%
       [z (make-rectangular x y)]
       [render (points `((,x ,y)) #:sym 'fullcircle #:size (* TRACK-PIXELS 2) #:color c)]))
