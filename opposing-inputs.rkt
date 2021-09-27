#lang racket
(require "components.rkt" "level.rkt")
(provide (all-defined-out))

;cartesian maze
(define oppo1
  (make-level (list (make-vtrack -3 -2 2.5 '+)
                    (make-driver -3 -2)
                    (make-htrack -2 2 -3 '+)
                    (make-driver -2 -3)
                    
                    (make-follower -2 -2)

                    (make-htrack -2 1.5 2)
                    (make-htrack -2 1.5 1)
                    (make-htrack -2 -1.5 0)
                    (make-htrack -1 1.5 0)
                    (make-htrack -1.5 0 -1)
                    (make-htrack .5 2 -1)
                    (make-htrack -2 -1.5 -2)
                    (make-htrack -1 2 -2)

                    (make-vtrack -2 2 -2)
                    (make-vtrack -1 2 .5)
                    (make-vtrack -1 0 -.5)
                    (make-vtrack -1 -1 -2)
                    (make-vtrack 0 2 1)
                    (make-vtrack 0 .5 -1)
                    (make-vtrack 0 -1.5 -2)
                    (make-vtrack 1 2 1.5)
                    (make-vtrack 1 1 0)
                    (make-vtrack 1 -.5 -2)
                    (make-vtrack 2 2.5 -2)

                    (make-goal 2 2.5)
                    (make-vtrack 2 2 2.5))))

;confined follower maze
(define oppo2
  (make-level (list (for/list ([n '(-2 -1 0 1 2)])
                      (list (make-htrack -2 2 (- n 1) '+) (make-vtrack n -3 1 '+)))

                    (make-htrack -2 -2.5 -3 '+)
                    (make-goal -2.5 -3 #:color 'lightblue)

                    ;block
                    (make-htrack -.5 .5 3.5)
                    (make-htrack -.5 .5 3.15)
                    (make-htrack -.5 .5 2.85)
                    (make-htrack -.5 .5 2.5)
                    (make-vtrack -.5 2.5 3.5)
                    (make-vtrack .5 2.5 3.5)

                    (make-driver .5 -1)
                    (make-driver -.5 -1)
                    (make-follower 0 2.5))))

;opposing worms
(define oppo3
  (make-level (list (make-htrack -1 1 1)
                    (make-vtrack 1 1 -1)

                    (make-htrack -3 -1 3.5 '+)
                    (make-vtrack -1 3.5 1.5 '+)
                    (make-htrack -1 1 1.5 '+)
                    (make-vtrack 1 1.5 3.5 '+)
                    (make-htrack 1 3 3.5 '+)

                    (make-htrack -3 -1 -3.5 '+)
                    (make-vtrack -1 -3.5 -1.5 '+)
                    (make-htrack -1 1 -1.5 '+)
                    (make-vtrack 1 -1.5 -3.5 '+)
                    (make-htrack 1 3 -3.5 '+)

                    (make-goal -3 3.5 #:color 'lightblue)
                    (make-goal 3 -3.5 #:color 'lightblue)

                    (make-driver 3 3.5)
                    (make-driver -3 -3.5)
                    (make-follower 1 1))))

;smiley face?
(define oppo4
  (make-level (list (make-vtrack 0 2 4)
                    (make-rot-track (* 1/4 pi) (* 1/2 pi) 3)
                    (make-htrack (* 3 (cos (* 1/4 pi))) (+ 1 (* 3 (cos (* 1/4 pi)))) (* 3 (sin (* 1/4 pi))))
                    (make-goal (+ 1 (* 3 (cos (* 1/4 pi)))) (* 3 (sin (* 1/4 pi))))

                    (make-vtrack -1 -1 1 '+)
                    (make-htrack -2 -1 1 '+)

                    (make-vtrack 1 -1 1 '+)
                    (make-htrack 1 2 1 '+)

                    (make-rot-track (* 5/4 pi) (* 3/2 pi) 3 '*)

                    (make-driver 0 -3)
                    (make-driver -1 0)
                    (make-driver 1 0)
                    (make-follower 0 3))))

