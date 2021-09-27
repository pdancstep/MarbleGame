#lang racket
(require "components.rkt" "level.rkt")
(provide (all-defined-out))


;two point turnaround
(define zp1
  (make-level (list (make-rot-track 0 (* 1/2 pi) 2)
                    (make-rot-track pi (* 3/2 pi) 2)
                    (make-htrack -2 3 0)
                    (make-vtrack 0 -2 2)

                    (make-goal 1 0)
                    (make-goal 3 0)

                    (make-htrack -3 -2 1 '+)
                    (make-vtrack -3 1 3 '+)
                    (make-htrack -3 -2 3 '+)

                    (make-rot-track (* 5/4 pi) (* 7/4 pi) 3 '*)

                    (make-follower -1 0)
                    (make-follower 1 0)

                    (make-driver (* 3 (cos (* 5/4 pi))) (* 3 (sin (* 5/4 pi))))
                    (make-driver -2 1))))


;two slugs
(define zp2
  (make-level (list (make-vtrack 0 -1 -3 '*)
                    
                    (make-htrack -1 0 2 '+)
                    (make-vtrack -1 2 3 '+)
                    (make-vtrack 0 2 3 '+)

                    (make-htrack 0 3 0)
                    (make-vtrack 0 0 1)
                    (make-vtrack 3 0 1)

                    (make-htrack -3 -1 0)
                    (make-vtrack -3 0 1)
                    (make-vtrack -1 0 1)

                    (make-goal 0 1)
                    (make-goal -3 1)

                    (make-driver 0 -3)
                    (make-driver 0 3)

                    (make-follower -3 1 )
                    (make-follower 3 1 ))))


;fixed point puzzle
(define zp3
  (make-level (list (make-htrack -2.5 2.5 0)
                    (make-rot-track pi (* 1.25 pi) 2.5)
                    (make-rot-track (* -.25 pi) 0 2.5)
                    (make-goal (- (* 2.5 (cos (* 1.25 pi)))) (* 2.5 (sin (* 1.25 pi))))
                    
                    (make-rot-track (* pi .375) (* pi .625) 2.5 '*)
                    (make-htrack -2.5 2.5 -2.5 '+)

                    
                    (make-driver -2.5 -2.5)
                    (make-driver (* 2.5 (cos (* .625 pi))) (* 2.5 (sin (* .625 pi))))
                    (make-follower (* 2.5 (cos (* 1.25 pi))) (* 2.5 (sin (* 1.25 pi)))))))