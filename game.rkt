#lang racket
(require "components.rkt" "level.rkt")


(define example1
  (make-level (list (make-htrack -2 2 -2 )
                    (make-rot-track (/ pi 2) (* 6/5 pi) 3)
                    (make-driver 2 -2 'hello)
                    (make-vtrack 0 -2 3 )

                    (make-follower 0 -2 'hello)
                    (make-rot-track (* 7/4 pi) (* 9/4 pi) 2)
                    (make-driver -3 0 'hello)
                    (make-linear-track 0 -1 2 0 ))))


(define example2
  (make-level (list (make-htrack -2.5 2.5 0)
                    (make-rot-track 0 (* 2 pi) .5)
                    (make-rot-track 0 (* 2 pi) 1.5)

                    (make-rot-track 0 pi 3.5)
                    (make-htrack -.5 .5 -2.5 )

                    
                    (make-driver -.5 -2.5 'hello)
                    (make-driver -3.5 0 'hello)
                    (make-follower -2.5 0 'hello))))

(define example3
  (make-level (list (make-htrack -2.5 2.5 0)
                    (make-rot-track pi (* 1.25 pi) 2.5)
                    (make-rot-track (* -.25 pi) 0 2.5)

                    (make-rot-track (* pi .375) (* pi .625) 2.5)
                    (make-htrack -2.5 2.5 -2.5)

                    
                    (make-driver -2.5 -2.5 'hello)
                    (make-driver (* 2.5 (cos (* .625 pi))) (* 2.5 (sin (* .625 pi))) 'hello)
                    (make-follower (* 2.5 (cos (* 1.25 pi))) (* 2.5 (sin (* 1.25 pi))) 'hello))))


                    

example1(* 2.5 (cos (* 1.25 pi))) (* 2.5 (sin (* 1.25 pi)))