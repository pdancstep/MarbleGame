#lang racket
(require plot "utils.rkt" "components.rkt")
(provide make-level)

[plot-x-ticks no-ticks]
[plot-y-ticks no-ticks]
[plot-x-label #f]
[plot-y-label #f]


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