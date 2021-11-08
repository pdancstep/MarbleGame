#lang racket
(require "components.rkt" "level.rkt")
(provide (all-defined-out))

;pairwise dependencies...
(define share1
  (make-level (list (make-vtrack -2 3.5 1.5 '+)
                    (make-vtrack 0 3.5 1.5 '+)
                    (make-vtrack 2 3.5 1.5 '+)

                    (make-vtrack -2 .5 -3.5)
                    (make-vtrack 0 .5 -3.5)
                    (make-vtrack 2 .5 -3.5)

                    (make-goal -2 -1.5)
                    (make-goal 0 -1.5)
                    (make-goal 2 -1.5)

                    (make-driver -2 3.5 'left #:color 'green)
                    (make-driver 0 3.5 'middle #:color 'orange)
                    (make-driver 2 3.5 'right #:color 'purple)

                    (make-follower -2 .5 (cons 'middle 'right) #:color 'red)
                    (make-follower 0 .5 (cons 'left 'right) #:color 'blue)
                    (make-follower 2 .5 (cons 'left 'middle) #:color 'yellow))))


;outer drivers control individual marbles, center driver controls both...
(define share2
  (make-level (make-htrack -3.5 -1.5 -1.5 '+)
              (make-htrack -3.5 -1.5 -2.5 '+)
              (make-htrack -3.5 -1.5 -3.5 '+)

              (make-htrack -1 1 -1.5 '+)
              (make-htrack -1 1 -2.5 '+)
              (make-htrack -1 1 -3.5 '+)

              (make-htrack 3.5 1.5 -1.5 '+)
              (make-htrack 3.5 1.5 -2.5 '+)
              (make-htrack 3.5 1.5 -3.5 '+)

              (make-vtrack -3.5 -3.5 -1.5 '+)
              (make-vtrack -2.5 -3.5 -1.5 '+)
              (make-vtrack -1.5 -3.5 -1.5 '+)

              (make-vtrack -1 -3.5 -1.5 '+)
              (make-vtrack -0 -3.5 -1.5 '+)
              (make-vtrack 1 -3.5 -1.5 '+)

              (make-vtrack 3.5 -3.5 -1.5 '+)
              (make-vtrack 2.5 -3.5 -1.5 '+)
              (make-vtrack 1.5 -3.5 -1.5 '+)

              (make-htrack 2 3 1)
              (make-vtrack 3 1 2)
              (make-goal 3 1)

              (make-htrack -3.5 -1.5 1.5)
              (make-vtrack -3.5 1.5 3.5)
              (make-htrack -3.5 .5 3.5)
              (make-vtrack .5 3.5 -.5)
              (make-htrack -3.5 .5 -.5)
              (make-goal -3.5 -.5)

             
              (make-driver -2.5 -2.5 'left)
              (make-driver 0 -2.5 'both)
              (make-driver 2.5 -2.5 'right)

              (make-follower -1.5 1.5 (cons 'left 'both))
              (make-follower 3 1 (cons 'both 'right))))