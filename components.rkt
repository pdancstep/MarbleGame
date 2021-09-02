#lang racket
(require plot "utils.rkt")
(provide marble htrack rot-track)

;;;;; define marbles and tracks ;;;;;

(define (marble x y #:color [c 'black])
  (cons `(marble ,x ,y)
        (points `((,x ,y)) #:sym 'fullcircle #:size MARBLE-PIXELS #:color c)))

(define (htrack xmin xmax y [type '+] #:color [c 'lightblue])
  (cons `(track linear ((,xmin ,y) (,xmax ,y)) ,type)
        (lines `((,xmin ,y) (,xmax ,y)) #:width TRACK-PIXELS #:color c)))

(define (rot-track θmin θmax r [type '+] #:color [c 'orange])
  (cons `(track arc TODO ,type)
        (polar (λ (θ) r) θmin θmax #:width TRACK-PIXELS #:color c)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; move these to abstract APIs for marbles and tracks
(provide get-marble-index near-track? closest-allowed-position)

; find the index of a marble close to a given point, if there is one
(define (get-marble-index marbles x y)
  (define (check-marbles marbles x y idx)
    (if (null? marbles)
        #f
        (let* ([m (car marbles)]
               [l (cdr marbles)]
               [x-m (cadar m)]
               [y-m (caddar m)])
          (if (< (distance x y x-m y-m) CLICK-TOLERANCE)
              idx
              (check-marbles l x y (add1 idx))))))
  (check-marbles marbles x y 0))

; is the point (x,y) within CLICK-TOLERANCE from the path of a track?
(define (near-track? x y track)
  (match (car track)
    [`(track linear ((,x1 ,y1) (,x2 ,y2)) ,_)
     (< (distance-from-line-segment x y x1 y1 x2 y2) CLICK-TOLERANCE)]
    [_ #f]))

; given marble m constrained to move along the given set of tracks,
; return (list a b), where a,b is the position closest to x,y that the marble can move to
; TODO: implement a better algorithm for this. right now just checks if the point x,y itself
;       is reasonably close to a track, and moves there or stops accordingly
(define (closest-allowed-position m x y tracks)
  (if (ormap (λ (t) (near-track? x y t)) tracks)
      (list x y)
      (list (cadar m) (caddar m))))
