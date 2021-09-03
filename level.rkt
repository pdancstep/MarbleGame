#lang racket
(require plot "utils.rkt" "components.rkt")
(provide make-level
         make-marble make-htrack make-vtrack make-rot-track)

[plot-x-ticks no-ticks]
[plot-y-ticks no-ticks]
[plot-x-label #f]
[plot-y-label #f]

; given marble m constrained to move along the given set of tracks,
; return (a . b), the position closest to (x . y) that the marble can move to
(define (closest-allowed-position m x y tracks)
  (let* ([current-coords (send m get-coords)]
         [nearby-tracks (filter ((curry near-track?) x y) tracks)]
         [possible-moves (map ((curry suggest-move) current-coords (cons x y)) nearby-tracks)])
    (if (empty? possible-moves)
        current-coords
        (let* ([dist (λ (p) (if p ; each element of possible-moves is either a point (a . b) or #f
                                (distance x y (car p) (cdr p))
                                +inf.0))]
               [best-move (argmin dist possible-moves)])
          (or best-move current-coords)))))
         

; respond to mouse input
; tracks: list of track elements in the level
; marbles: list of marble elements in the level
; active-marble: index in marbles of the marble that was last clicked
; level event x y: required arguments for callback function to send to set-mouse-event-callback
(define ((build-mouse-handler tracks marbles active-marble) level event x y)
  (cond
    ; clicked on something
    [(send event button-down? 'left)
     (let ([m (nearby-marble marbles x y)])
       ; does the clicked location correspond to a marble?
       (if m
           ; if so, make that marble the active marble
           (send level set-mouse-event-callback (build-mouse-handler tracks marbles m))
           ; if not, make sure there is no active marble or track
           (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))))]
    
    ; mouse released: make sure marble display is current and disable active marble
    [(send event button-up? 'left)
     (render-marbles level marbles)
     (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))]
    
    ; mouse is being dragged: update position of active marble
    [(and (send event dragging?) active-marble)
     (let ([m (list-ref marbles active-marble)])
       (match (closest-allowed-position m x y tracks)
         [(cons a b) (warp! m a b)])) ; pull marble to the required position
     (render-marbles level marbles)]

    ; nothing to do; just update marble display
    [else (render-marbles level marbles)]))

; build a level from a list of components
(define (make-level components)
  (let* ([tracks (filter track? components)]
         [marbles (filter marble? components)]
         [level (plot (cons unit-circle (map get-renderer tracks))
                      #:x-min PLOT-X-MIN #:x-max PLOT-X-MAX
                      #:y-min PLOT-Y-MIN #:y-max PLOT-Y-MAX)])
    (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))
    (render-marbles level marbles)
    level))
