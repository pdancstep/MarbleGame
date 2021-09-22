#lang racket
(require "components.rkt" "level.rkt")

(define example1
  (make-level (list (make-htrack -2.5 2.5 0 #:color 'gray)
                    (make-rot-track 0 (* 2 pi) .5 #:color 'gray)
                    (make-rot-track 0 (* 2 pi) 1.5 #:color 'gray)
                    (make-goal 2.5 0)

                    (make-rot-track 0 pi 3.5)
                    (make-htrack -.5 .5 -2.5)

                    
                    (make-driver -.5 -2.5 'a)
                    (make-driver -3.5 0 'a)
                    (make-follower -2.5 0 'a))))

(define example2
  (make-level (list (make-vtrack 0 -1 1.5 #:color 'gray)
                    (make-goal 0 -1)
                    (make-follower 0 1.5 'a)

                    (make-vtrack 0 2 3.5 '* #:color 'orange)
                    (make-driver 0 3.5 'a)

                    (make-vtrack 0 -3 -2)
                    (make-driver 0 -2 'a))))

(define example3
  (make-level (list (make-htrack -2.5 2.5 0 #:color 'gray)
                    (make-rot-track pi (* 1.25 pi) 2.5 #:color 'gray)
                    (make-rot-track (* -.25 pi) 0 2.5 #:color 'gray)
                    (make-goal (- (* 2.5 (cos (* 1.25 pi)))) (* 2.5 (sin (* 1.25 pi))))
                    
                    (make-rot-track (* pi .375) (* pi .625) 2.5)
                    (make-htrack -2.5 2.5 -2.5)

                    
                    (make-driver -2.5 -2.5 'a)
                    (make-driver (* 2.5 (cos (* .625 pi))) (* 2.5 (sin (* .625 pi))) 'a)
                    (make-follower (* 2.5 (cos (* 1.25 pi))) (* 2.5 (sin (* 1.25 pi))) 'a))))

(define example4
  (make-level (list (make-vtrack -3 -2 2.5)
                    (make-driver -3 -2 'a)
                    (make-htrack -2 2 -3)
                    (make-driver -2 -3 'a)
                    
                    (make-follower -2 -2 'a)
                    ; TODO make grid into an actual maze
                    (for/list ([n '(-2 -1 0 1 2)])
                      (list (make-htrack -2 2 n #:color 'gray) (make-vtrack n -2 2 #:color 'gray)))
                    (make-goal 2 2.5)
                    (make-vtrack 2 2 2.5 #:color 'gray))))


(define example5
  (make-level (list (make-htrack 1/3 10/3 0 #:color 'gray)
                    (make-follower 1/3 0 'a)
                    (make-goal 10/3 0)

                    (make-vtrack 0 2/3 4/3 '* #:color 'orange)
                    (make-driver 0 2/3 'a)
                    (make-htrack -1/3 1/3 -1)
                    (make-driver -1/3 -1 'a))))
