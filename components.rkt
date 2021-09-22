#lang racket
(require plot "marble.rkt" "track.rkt")

(provide make-marble make-driver make-pusher make-follower
         make-htrack make-vtrack make-linear-track make-rot-track make-goal
         marble? marble-coords nearby-marble
         track? near-track? suggest-move
         get-renderer render-marbles)

;;;; marble helpers ;;;;

(define/contract (marble? m)
  (-> any/c boolean?)
  (is-a? m marble%))

(define/contract (marble-coords m)
  (-> marble? complex?)
  (send m get-coords))

; look for a marble near a given coordinate position
; marbles: list? marble%
; (x . y): coordinate to search
; returns: index of found marble in marbles, or #f if none found
(define (nearby-marble marbles z)
  (define (check-marbles ms z idx)
    (if (null? ms)
        #f
        (if (send (first ms) near? z)
            idx
            (check-marbles (rest ms) z (add1 idx)))))
  (check-marbles marbles z 0))

;;;; track helpers ;;;;

(define/contract (track? t)
  (-> any/c boolean?)
  (is-a? t track%))

(define/contract (near-track? z t)
  (-> complex? track? boolean?)
  (send t near? z))

(define/contract (suggest-move source target track)
  (-> complex? complex? track? (or/c complex? false?))
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
