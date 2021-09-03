#lang racket
(require plot "marble.rkt" "track.rkt")

(provide make-marble make-htrack make-vtrack make-rot-track
         marble? warp! marble-coords nearby-marble
         track? near-track? suggest-move
         get-renderer render-marbles)

;;;; marble helpers ;;;;

(define/contract (marble? m)
  (-> any/c boolean?)
  (is-a? m marble%))

(define/contract (warp! m x y)
  (-> marble? real? real? any/c)
  (send m warp! x y))

(define/contract (marble-coords m)
  (-> marble? (cons/c real? real?))
  (send m get-coords))

; look for a marble near a given coordinate position
; marbles: list? marble%
; (x . y): coordinate to search
; returns: index of found marble in marbles, or #f if none found
(define (nearby-marble marbles x y)
  (define (check-marbles ms x y idx)
    (if (null? ms)
        #f
        (if (send (first ms) near? x y)
            idx
            (check-marbles (rest ms) x y (add1 idx)))))
  (check-marbles marbles x y 0))

;;;; track helpers ;;;;

(define/contract (track? t)
  (-> any/c boolean?)
  (is-a? t track%))

(define/contract (near-track? x y t)
  (-> real? real? track? boolean?)
  (send t near? x y))

(define/contract (suggest-move source target track)
  (-> (cons/c real? real?) (cons/c real? real?) track?
      (or/c (cons/c real? real?) false?))
  (send track suggest-movement source target))

;;;; marble + track helpers ;;;;
(define (render/c o) (object/c get-render))

(define/contract (get-renderer o)
  (-> render/c renderer2d?)
  (send o get-render))

; render a list of marbles as overlay in a given plot
(define/contract (render-marbles plot marbles)
  (-> (object/c set-overlay-renderers) (*list/c render/c) any/c)
  (send plot set-overlay-renderers (map get-renderer marbles)))
