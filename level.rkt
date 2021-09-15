#lang racket
(require plot "utils.rkt" "components.rkt" )
(provide make-level)

[plot-x-ticks no-ticks]
[plot-y-ticks no-ticks]
[plot-x-label #f]
[plot-y-label #f]

; given marble m constrained to move along the given set of tracks,
; return a pair containing:
; (a . b), the position closest to (x . y) that the marble can move to
; and the track along which that movement takes place
(define (closest-allowed-position m x y tracks)
  (let* ([current-coords (marble-coords m)]
         [nearby-tracks (filter ((curry near-track?) current-coords) tracks)]
         [possible-moves (map (λ (t) (cons (suggest-move current-coords (cons x y) t) t)) nearby-tracks)])
    (if (empty? possible-moves)
        (cons current-coords #f)
        (let* ([dist (λ (info)
                       (let ([p (car info)])
                         (if p ; the car of each element of possible-moves is either a point (a . b) or #f
                             (distance x y (car p) (cdr p))
                             +inf.0)))])
          (argmin dist possible-moves)))))
         

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
           (begin
             (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))
             (send level set-overlay-renderers (list (point-label (list x y) (angle-in-degrees x y)))))))]
    
    ; mouse released: make sure marble display is current and disable active marble
    [(send event button-up? 'left)
     (render-marbles level marbles)
     (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))]
    
    ; mouse is being dragged: update position of active marble and any marbles following it
    [(and (send event dragging?) active-marble)
     (let* ([m (list-ref marbles active-marble)]
            [old-coords (send m get-coords)]
            [new-pos-info (if (send m follower?)
                              (cons old-coords #f)
                              (closest-allowed-position m x y tracks))]
            [new-coords (car new-pos-info)]
            [track-used (cdr new-pos-info)]
            [new-marbles (list-set marbles active-marble (send m move-to new-coords))]
            [final-marbles (if (send m driver?)
                               (let ([delta (transform new-coords old-coords (send track-used get-inverse))]) ; watch out for divide-by-0
                                 (map (λ (follow) (if (send m drive-pair? follow)
                                                      (let* ([follow-coords (send follow get-coords)]
                                                             [target-coords (transform follow-coords delta (send track-used get-oper))]
                                                             [new-coords (car (closest-allowed-position follow (car target-coords) (cdr target-coords) tracks))])
                                                        (send follow move-to new-coords))
                                                      follow))
                                      new-marbles))
                               new-marbles)])
       (send level set-mouse-event-callback (build-mouse-handler tracks final-marbles active-marble))
       (render-marbles level final-marbles))]

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
