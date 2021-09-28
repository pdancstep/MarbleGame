#lang racket
(require "components.rkt" "level.rkt")
(provide (all-defined-out))

;Across the origin (solvable in three moves)
(define ratchet1
  (make-level (list (make-vtrack 0 1.2 -.6)
                    (make-goal 0 -.6)
                    (make-follower 0 1.2)

                    (make-vtrack 0 3.6 1.8 '*)
                    (make-driver 0 3.6)

                    (make-vtrack 0 -1.85 -2.75 '+)
                    (make-driver 0 -1.85))))

;inchworm (solvable in 10 moves)
(define ratchet2
  (make-level (list (make-htrack 1/3 10/3 0)
                    (make-follower 1/3 0)
                    (make-goal 10/3 0)

                    (make-vtrack 0 2/3 4/3 '*)
                    (make-driver 0 2/3)
                    (make-htrack -1/3 1/3 -1 '+)
                    (make-driver -1/3 -1))))

