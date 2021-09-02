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

(define ((build-mouse-handler tracks marbles active-marble) level event x y)
  (cond
    [(send event button-down? 'left) ; clicked on something
     (let ([marb (get-marble-index marbles x y)]) ; is it a marble?
       (if marb
           ; if so, make that marble the active marble
           (send level set-mouse-event-callback (build-mouse-handler tracks marbles marb))
           ; if not, make sure there is no active marble or track
           (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))))]
    
    [(send event button-up? 'left)
     ; mouse released: make sure marble display is current and disable active marble
     (send level set-overlay-renderers (map cdr marbles))
     (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))]
    
    [(and (send event dragging?) active-marble)
     ; mouse is being dragged: update position of active marble
     (let* ([m (list-ref marbles active-marble)]
            [p (closest-allowed-position m x y tracks)]
            [new-m (marble (car p) (cadr p))]
            [new-marbles (list-update marbles active-marble (λ (_) new-m))])
       (send level
             set-mouse-event-callback
             (build-mouse-handler tracks new-marbles active-marble))
       (send level set-overlay-renderers (map cdr new-marbles)))]
    
    [else ; nothing to do; just update marble display
     (send level set-overlay-renderers (map cdr marbles))]))

; build a level from a list of components
(define (make-level components)
  (let* ([tracks (filter (λ (p) (eq? (caar p) 'track)) components)]
         [marbles (filter (λ (p) (eq? (caar p) 'marble)) components)]
         [level (plot (cons unit-circle (map cdr tracks))
                      #:x-min PLOT-X-MIN #:x-max PLOT-X-MAX
                      #:y-min PLOT-Y-MIN #:y-max PLOT-Y-MAX)])
    (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))
    (send level set-overlay-renderers (map cdr marbles))
    level))


(define example1
  (make-level (list (htrack -2 2 -2)
                    (rot-track (/ pi 2) pi 3 '*)
                    (marble 2 -2)
                    (marble -3 0))))

example1
