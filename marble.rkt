#lang racket
(require plot "utils.rkt")
(provide marble% make-marble make-driver make-follower)


(define marble%
  (class object%
    (init z drv fol usr? color)
    (super-new) ; required

    ; fields
    (define location z)
    (define drive drv) ; list of labels to drive
    (define follow fol) ; list of labels to follow
    (define user-draggable? usr?)
    (define mcolor color)
    (define renderer (points `((,(real-part z) ,(imag-part z)))
                             #:sym 'fullcircle
                             #:size MARBLE-PIXELS
                             #:color mcolor))
    
    (define/public (get-coords) location)

    (define/public (get-render) renderer)

    (define/public (can-drag?) user-draggable?)

    (define/public (move-to p)
      (new marble% [z p] [drv drive] [fol follow] [usr? user-draggable?] [color mcolor]))

    (define/public (near? z)
      (< (complex-distance z location) CLICK-TOLERANCE))

    ; methods for driver/follower
    (define/public (driver?)
      (not (empty? drive)))
    
    (define/public (follower?)
      (not (empty? follow)))

    (define/public (get-follow-labels) follow)
    
    (define/public (drive-pair? m)
      (and (driver?)
           (send m follower?)
           (match-labels drive (send m get-follow-labels))))))

; build a marble at location (x,y)
(define (make-marble x y #:color [c 'black] #:drive [drv empty] #:follow [fol empty] #:draggable [drag (empty? fol)])
  (new marble% [z (make-rectangular x y)] [drv drv] [fol fol] [usr? drag] [color c]))

; build a driver marble at location (x,y) with given label
(define (make-driver x y [label 'default] #:color [c 'darkgreen])
  (new marble% [z (make-rectangular x y)] [drv (list label)] [fol empty] [usr? #t] [color c]))

; build a follower marble at location (x,y) with given label
(define (make-follower x y [label 'default] #:color [c 'black])
  (new marble% [z (make-rectangular x y)] [drv empty] [fol (list label)] [usr? #f] [color c]))
