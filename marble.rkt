#lang racket
(require plot "utils.rkt")
(provide marble% make-marble make-driver make-pusher make-follower)


(define marble%
  (class object%
    (init z type color)
    (super-new) ; required

    ; fields
    (define location z)
    (define mtype type)
    (define mcolor color)
    (define renderer (points `((,(real-part z) ,(imag-part z))) #:sym 'fullcircle #:size MARBLE-PIXELS #:color mcolor))
    
    (define/public (get-coords) location)

    (define/public (get-render) renderer)

    (define/public (move-to p)
      (new marble% [z p] [type mtype] [color mcolor]))

    (define/public (near? z)
      (< (complex-distance z location) CLICK-TOLERANCE))

    (define/public (get-type) mtype)
    
    ; methods for driver/follower marble type
    (define/public (driver?)
      (and (pair? mtype)
           (equal? (car mtype) 'driver)))
    
    (define/public (pusher?)
      (and (pair? mtype)
           (equal? (car mtype) 'pusher)))
    
    (define/public (follower?)
      (and (pair? mtype)
           (equal? (car mtype) 'follower)))
    
    (define/public (drive-pair? m)
      (and (or (driver?) (pusher?))
           (send m follower?)
           (equal? (cdr mtype) (cdr (send m get-type)))))))

; build a marble at location (x,y)
(define (make-marble x y #:color [c 'black]) (new marble% [z (make-rectangular x y)] [type #f] [color c]))

; build a driver/pusher marble at location (x,y) with given label
; drivers always send the follower marble through the full transformation; pushers only suggest, so followers will stay on tracks
; don't yet have the third option: a marble that can ONLY move if its followers can move
(define (make-driver x y label #:color [c 'darkgreen]) (new marble% [z (make-rectangular x y)] [type (cons 'driver label)] [color c]))
(define (make-pusher x y label #:color [c 'darkgreen]) (new marble% [z (make-rectangular x y)] [type (cons 'pusher label)] [color c]))

; build a follower marble at location (x,y) with given label
(define (make-follower x y label #:color [c 'black]) (new marble% [z (make-rectangular x y)] [type (cons 'follower label)] [color c]))
