#lang racket
(require plot "utils.rkt")
(provide marble% make-marble nearby-marble render-marbles)

(define marble%
  (class object%
    (init x y type color)
    (super-new) ; required

    ; fields
    (define pos-x x)
    (define pos-y y)
    (define mtype type) ; not yet used
    (define mcolor color)
    (define renderer (points `((,x ,y)) #:sym 'fullcircle #:size MARBLE-PIXELS #:color color))
    
    (define/public (get-coords)
      (cons pos-x pos-y))

    (define/public (get-render)
      renderer)

    (define/public (warp! x y)
      (set! pos-x x) (set! pos-y y)
      (set! renderer
            (points `((,x ,y)) #:sym 'fullcircle #:size MARBLE-PIXELS #:color mcolor)))))

; build a marble at location (x,y)
(define (make-marble x y #:color [c 'black]) (new marble% [x x] [y y] [type #f] [color c]))

; look for a marble near a given coordinate position
; marbles: list? marble%
; (x,y): coordinate to search
; returns: index of found marble in marbles, or #f if none found
(define (nearby-marble marbles x y)
  (define (check-marbles ms x y idx)
    (if (null? ms)
        #f
        (let ([m (first ms)]
              [ms (rest ms)])
          (match (send m get-coords)
            [(cons xm ym) (if (< (distance x y xm ym) CLICK-TOLERANCE)
                              idx
                              (check-marbles ms x y (add1 idx)))]
            [_ (check-marbles ms x y (add1 idx))]))))
  (check-marbles marbles x y 0))

; render a list of marbles as overlay in a given plot
(define (render-marbles plot marbles)
  (send plot set-overlay-renderers (map (λ (m) (send m get-render)) marbles)))
