#lang racket
(require plot "utils.rkt" "components.rkt" )
(provide make-level)

[plot-x-ticks no-ticks]
[plot-y-ticks no-ticks]
[plot-x-label #f]
[plot-y-label #f]

; given marble m constrained to move along the given set of tracks, return a pair containing:
; the position closest to z that the marble can move to
; and the track along which that movement takes place
(define (closest-allowed-position m z tracks)
  (let* ([current-coords (marble-coords m)]
         [nearby-tracks (filter ((curry near-track?) current-coords) tracks)]
         [possible-moves (map (λ (t) (cons (suggest-move current-coords z t) t)) nearby-tracks)])
    (if (empty? possible-moves)
        (cons current-coords #f)
        (let* ([dist (λ (info)
                       (let ([p (car info)])
                         (if p ; the car of each element of possible-moves is either a point (complex number) or #f
                             (complex-distance z p)
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
     (let ([m (nearby-marble marbles (make-rectangular x y))])
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
    
    ; mouse is being dragged: update position of active marble and any marbles following it
    [(and (send event dragging?) x y active-marble)
     (let* ([m (list-ref marbles active-marble)]
            [old-coords (send m get-coords)]
            [new-pos-info (if (send m follower?)
                              (cons old-coords #f)
                              (closest-allowed-position m (make-rectangular x y) tracks))]
            [new-coords (car new-pos-info)]
            [track-used (cdr new-pos-info)]
            [new-marbles (list-set marbles active-marble (send m move-to new-coords))]
            [final-marbles (if (send m driver?)
                               (let ([delta ((send track-used get-inverse) new-coords old-coords)]) ; watch out for divide-by-0
                                 (map (λ (follow) (if (send m drive-pair? follow)
                                                      (let* ([follow-coords (send follow get-coords)]
                                                             [target-coords ((send track-used get-oper) follow-coords delta)]
                                                             [new-coords (if (send m driver?)
                                                                             target-coords
                                                                             (car (closest-allowed-position follow target-coords tracks)))])
                                                        (send follow move-to new-coords))
                                                      follow))
                                      new-marbles))
                               new-marbles)])
       (send level set-mouse-event-callback (build-mouse-handler tracks final-marbles active-marble))
       (render-marbles level final-marbles))]

    ; nothing to do; just update marble display
    [else (render-marbles level marbles)]))

; build a level from a list of components
(define (make-level . components)
  (let* ([pieces (flatten components)]
         [tracks (filter track? pieces)]
         [marbles (filter marble? pieces)]
         [level (plot (cons unit-circle (map get-renderer tracks))
                      #:x-min PLOT-X-MIN #:x-max PLOT-X-MAX
                      #:y-min PLOT-Y-MIN #:y-max PLOT-Y-MAX)])
    (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))
    (render-marbles level marbles)
    level))
