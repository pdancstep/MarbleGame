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
