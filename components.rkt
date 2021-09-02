#lang racket
(require plot "utils.rkt")
(provide htrack rot-track)

;;;;; define marbles and tracks ;;;;;

(define (htrack xmin xmax y [type '+] #:color [c 'lightblue])
  (cons `(track linear ((,xmin ,y) (,xmax ,y)) ,type)
        (lines `((,xmin ,y) (,xmax ,y)) #:width TRACK-PIXELS #:color c)))

(define (rot-track θmin θmax r [type '+] #:color [c 'orange])
  (cons `(track arc TODO ,type)
        (polar (λ (θ) r) θmin θmax #:width TRACK-PIXELS #:color c)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

; move these to abstract APIs for marbles and tracks
(provide near-track? closest-allowed-position)

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
      (cons x y)
      (send m get-coords)))
