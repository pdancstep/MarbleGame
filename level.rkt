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
        (cons current-coords null-track)
        (let* ([dist (λ (info)
                       (let ([p (car info)])
                         (if p ; the car of each element of possible-moves is either a point (complex number) or #f
                             (complex-distance z p)
                             +inf.0)))])
          (argmin dist possible-moves)))))

; starting from the assumption that we transformed the starting marble with transform,
; perform the same transformation to marbles that follow start
; return list of (marble . bool), where the bool indicates whether the marble was moved
(define (drive-once marbles drive transform)
  (if (procedure? transform)
      (map (λ (follow) (if (send drive drive-pair? follow)
                           (cons (send follow move-to (transform (send follow get-coords))) #t)
                           (cons follow #f)))
           marbles)
      (map (λ (m) (cons m #f)) marbles)))

; given a marble movement and the track list, interpret the movement as a transformation
; (but only if we're trying)
(define ((make-transform-finder tracks) try? m-old m-new)
  (if try?
      (let* ([z-old (marble-coords m-old)]
             [z-new (marble-coords m-new)]
             [all-transforms (map ((curry along-track?) z-old z-new) tracks)])
        ; what happens if there's more than one possible result?
        (apply (xor-warn (string-append "Multiple tracks claiming secondary driver " (marble-info m-new)))
               all-transforms))
      #f))

; tail-recursive function that checks each marble moved by previous drivers and
; runs that transformation for its own followers.
; gives an error if it detects a marble being moved by multiple different drivers at once
(define (iterate-drive marbles transforms tracks)
  (let ([driver-idx (index-where transforms procedure?)])
    (if (and driver-idx ; if we have something to drive with
             (send (list-ref marbles driver-idx) driver?)) ; optimization: only drive drivers
        (let* ([next-data (drive-once marbles
                                      (list-ref marbles driver-idx)
                                      (list-ref transforms driver-idx))]
               [next-marbles (map car next-data)]
               [next-transforms (map (make-transform-finder tracks)
                                     (map cdr next-data)
                                     marbles
                                     next-marbles)]
               [merged-transforms (map (xor-warn "Possible cycle in driver/follower graph")
                                       (list-update transforms driver-idx not)
                                       next-transforms)])
          (iterate-drive next-marbles merged-transforms tracks))
        marbles)))

; top level driving procedure
(define (drive-movement marbles tracks starting-driver-idx transform)
  (let ([transform-list (list-update (map not marbles) starting-driver-idx (const transform))])
    (iterate-drive marbles transform-list tracks)))

; respond to mouse input
; tracks: list of track elements in the level
; marbles: list of marble elements in the level
; active-marble: index in marbles of the marble that was last clicked
; level event x y: required arguments for callback function to send to set-mouse-event-callback
(define ((build-mouse-handler tracks marbles active-marble-idx) level event x y)
  (cond
    ; clicked on something
    [(send event button-down? 'left)
     (let ([idx (nearby-marble marbles (make-rectangular x y))])
       ; does the clicked location correspond to a user-draggable marble?
       (if (and idx (send (list-ref marbles idx) can-drag?))
           ; if so, make that marble the active marble
           (send level set-mouse-event-callback (build-mouse-handler tracks marbles idx))
           ; if not, make sure there is no active marble or track
           (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))))]
    
    ; mouse released: make sure marble display is current and disable active marble
    [(send event button-up? 'left)
     (render-marbles level marbles)
     (send level set-mouse-event-callback (build-mouse-handler tracks marbles #f))]
    
    ; mouse is being dragged: update position of active marble and any marbles following it
    ; note x and y are being checked here because if the user drags outside the plot, they will be #f
    [(and (send event dragging?) x y active-marble-idx)
     (let* ([active-marble (list-ref marbles active-marble-idx)]
            [old-coords (send active-marble get-coords)]
            [new-pos-info (closest-allowed-position active-marble (make-rectangular x y) tracks)]
            [new-coords (car new-pos-info)]
            [track-used (cdr new-pos-info)]
            [new-marbles (list-set marbles active-marble-idx (send active-marble move-to new-coords))]
            [delta ((send track-used get-inverse) new-coords old-coords)] ; watch out for divide-by-0
            [final-marbles (drive-movement new-marbles tracks active-marble-idx (λ (z) ((send track-used get-oper) z delta)))])
       (send level set-mouse-event-callback (build-mouse-handler tracks final-marbles active-marble-idx))
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
