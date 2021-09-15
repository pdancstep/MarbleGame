#lang racket
(require plot "utils.rkt")
(provide track% make-htrack make-vtrack make-linear-track make-rot-track)

(define track%
  (class object%
    (init type render)
    (super-new) ; required

    (define transform type) ; operation movement along this track represents (currently, + or *)
    (define renderer render)

    (define/public (get-oper)
      (match transform
        ['+ +]
        ['* *]))
    
    (define/public (get-inverse)
      (match transform
        ['+ -]
        ['* /]))
    (define/public (near? x y) #f) ; need a specific track type to determine if we're close to a point
    (define/public (suggest-movement source target) #f) ; need track type to suggest any movement
    (define/public (get-render) renderer)))

(define linear%
  (class track%
    (init p1 p2 type render)
    (super-new [type type] [render render])

    (define x1 (car p1))
    (define y1 (cdr p1))
    (define x2 (car p2))
    (define y2 (cdr p2))

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

    (define/override (near? x y)
      (cond
        ; vertical track
        [(= x1 x2) (and (< (abs (- x x1)) CLICK-TOLERANCE)
                        (< (- (min y1 y2) CLICK-TOLERANCE) y)
                        (< y (+ (max y1 y2) CLICK-TOLERANCE)))]
        ; point is past left end of track
        [(< x (min x1 x2)) (if (< x1 x2)
                               (< (distance x y x1 y1) CLICK-TOLERANCE)
                               (< (distance x y x2 y2) CLICK-TOLERANCE))]
        ; point is past right end of track
        [(< (max x1 x2) x) (if (< x1 x2)
                               (< (distance x y x2 y2) CLICK-TOLERANCE)
                               (< (distance x y x1 y1) CLICK-TOLERANCE))]
        ; point is within domain of track
        ; this is still not quite right: closest point on line could be outside line segment
        [else (< (distance-from-line x y x1 y1 x2 y2) CLICK-TOLERANCE)]))

    ; initial implmentation just pulls to closest point along steeper axis
    ; may want to refine
    (define/override (suggest-movement source target)
      (if (near? (car source) (cdr source))
          (let ([new-y (cond
                         [(< (cdr target) (min y1 y2)) (min y1 y2)]
                         [(< (max y1 y2) (cdr target)) (max y1 y2)]
                         [else (cdr target)])])
            (cond
              ; vertical track
              [(= x1 x2) (cons x1 new-y)]
              ; high slope: follow y-coordinate
              [(<= 1 (abs slope)) (cons (as-inverse new-y) new-y)]
              ; low slope: follow x-coordinate
              [else (let ([new-x (cond
                                   [(< (car target) (min x1 x2)) (min x1 x2)]
                                   [(< (max x1 x2) (car target)) (max x1 x2)]
                                   [else (car target)])])
                      (cons new-x (as-function new-x)))]))
          ; marble is not near this track at all, so we don't want to propose moving it
          #f))
    ))

(define arc%
  (class track%
    (init θmin θmax r type render)
    (super-new [type type] [render render])

    (define arc-begin θmin)
    (define arc-end θmax)
    (define radius r)

    (define cart-begin (let ([p (make-polar radius arc-begin)])
                         (cons (real-part p) (imag-part p))))
    (define cart-end (let ([p (make-polar radius arc-end)])
                         (cons (real-part p) (imag-part p))))
    
    (define/override (near? x y)
      (let* ([p (make-rectangular x y)]
             [r (magnitude p)]
             [θ (cond
                  [(zero? r) 0]
                  [(and (< (* 2 pi) arc-end) (<= 0 (angle p))) (+ (angle p) (* 2 pi))]
                  [else (normalize-angle (angle p))])])


        (and (< (abs (- radius r)) CLICK-TOLERANCE)
             (cond 
               [(< θ arc-begin) (< (- arc-begin θ) CLICK-TOLERANCE)]
               [(< θ arc-end) #t]
               [else (< (- θ arc-end) CLICK-TOLERANCE)]))))

    (define/override (suggest-movement source target)
      (if (near? (car source) (cdr source))
          (let* ([p (make-rectangular (car target) (cdr target))]
                 [θ (if (and (< (* 2 pi) arc-end) (<= 0 (angle p))) (+ (angle p) (* 2 pi))
                        (normalize-angle (angle p)))])
            (cond
              [(< θ arc-begin) cart-begin]
              [(< arc-end θ) cart-end]
              [else (let ([p (make-polar radius θ)])
                      (cons (real-part p) (imag-part p)))]))
          ; marble is not near this track at all, so we don't want to propose moving it
          #f))
    ))


(define (make-htrack xmin xmax y [type' +] #:color [c 'lightblue])
  (new linear%
       [p1 (cons xmin y)] [p2 (cons xmax y)] [type type]
       [render (lines `((,xmin ,y) (,xmax ,y)) #:width TRACK-PIXELS #:color c)]))

(define (make-vtrack x ymin ymax [type '+] #:color [c 'lightblue])
  (new linear%
       [p1 (cons x ymin)] [p2 (cons x ymax)] [type type]
       [render (lines `((,x ,ymin) (,x ,ymax)) #:width TRACK-PIXELS #:color c)]))

(define (make-linear-track x1 y1 x2 y2 [type '+] #:color [c 'lightblue])
  (new linear%
       [p1 (cons x1 y1)] [p2 (cons x2 y2)] [type type]
       [render (lines `((,x1 ,y1) (,x2 ,y2)) #:width TRACK-PIXELS #:color c)]))


(define (make-rot-track θmin θmax r [type '*] #:color [c 'orange])
  (new arc%
       [θmin θmin] [θmax θmax] [r r] [type type]
       [render (polar (λ (θ) r) θmin θmax #:width TRACK-PIXELS #:color c)]))
