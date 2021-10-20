#lang racket
(require plot "marble.rkt" "track.rkt")

(provide make-marble make-driver make-follower
         make-htrack make-vtrack make-linear-track make-rot-track make-goal
         marble? marble-coords nearby-marble
         track? near-track? suggest-move null-track along-track?
         get-renderer render-marbles)

;;;; marble helpers ;;;;

(define/contract (marble? m)
  (-> any/c boolean?)
  (is-a? m marble%))

(define/contract (marble-coords m)
  (-> marble? complex?)
  (send m get-coords))

; look for a marble near a given position
; returns index of found marble, or #f if none found
(define/contract (nearby-marble marbles z)
  (-> (*list/c marble?) complex? (or/c exact-nonnegative-integer? false?))
  (let ([near-list (map (λ (m) (send m near? z)) marbles)])
    (index-of near-list #t)))

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

(define/contract null-track
  track?
  (new track% [type #f] [render #f]))

; if z-old and z-new are both near the given track,
; return a procedure that corresponds to moving from z-old to z-new on that track
; if not, return #f
(define/contract (along-track? z-old z-new track)
  (-> complex? complex? track? (or/c (-> complex? complex?) false?))
  (if (and (near-track? z-old track) (near-track? z-new track))
      (let ([delta ((send track get-inverse) z-new z-old)]
            [op (send track get-oper)])
        (λ (z) (op z delta)))
      #f))

;;;; marble + track helpers ;;;;
(define (render/c o) (object/c get-render))

(define/contract (get-renderer o)
  (-> render/c renderer2d?)
  (send o get-render))

; render a list of marbles as overlay in a given plot
(define/contract (render-marbles plot marbles)
  (-> (object/c set-overlay-renderers) (*list/c render/c) any/c)
  (send plot set-overlay-renderers (map get-renderer marbles)))
