#lang racket
(require plot "utils.rkt")
(provide marble% make-marble make-driver make-follower)


(define marble%
  (class object%
    (init x y type color)
    (super-new) ; required

    ; fields
    (define pos-x x)
    (define pos-y y)
    (define mtype type)
    (define mcolor color)
    (define renderer (points `((,x ,y)) #:sym 'fullcircle #:size MARBLE-PIXELS #:color mcolor))
    
    (define/public (get-coords)
      (cons pos-x pos-y))

    (define/public (get-render)
      renderer)

    (define/public (warp! x y)
      (set! pos-x x) (set! pos-y y)
      (set! renderer
            (points `((,x ,y)) #:sym 'fullcircle #:size MARBLE-PIXELS #:color mcolor)))

    (define/public (near? x y)
      (< (distance x y pos-x pos-y) CLICK-TOLERANCE))

    (define/public (get-type)
      mtype)
    
    ; methods for driver/follower marble type
    (define/public (driver?)
      (and (pair? mtype)
           (equal? (car mtype) 'driver)))
    
    (define/public (follower?)
      (and (pair? mtype)
           (equal? (car mtype) 'follower)))
    
    (define/public (drive-pair? m)
      (and (driver?)
           (send m follower?)
           (equal? (cdr mtype) (cdr (send m get-type)))))))

; build a marble at location (x,y)
(define (make-marble x y #:color [c 'black]) (new marble% [x x] [y y] [type #f] [color c]))

; build a driver marble at location (x,y) with given label
(define (make-driver x y label #:color [c 'darkgreen]) (new marble% [x x] [y y] [type (cons 'driver label)] [color c]))

; build a follower marble at location (x,y) with given label
(define (make-follower x y label #:color [c 'black]) (new marble% [x x] [y y] [type (cons 'follower label)] [color c]))
