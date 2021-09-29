#lang racket
(require "components.rkt" "level.rkt")
(provide (all-defined-out))

(define lv1 ; basic marble->goal
  (make-level (list (make-htrack -2 2 0 '+)
                    (make-goal 2 0 #:color 'lightblue)
                    (make-marble -2 0 #:color 'darkgreen))))

(define lv2 ; basic driver+follower->goal
  (make-level (list (make-htrack -2 2 1 '+)
                    (make-driver -2 1)
                    
                    (make-htrack -2 2 -1)
                    (make-goal 2 -1)
                    (make-follower -2 -1))))

(define lv3 ; basic double-driver
  (make-level (list (make-htrack -2 0 2 '+)
                    (make-goal 0 2 #:color 'lightblue)
                    (make-driver -2 2)

                    (make-htrack 0 2 -2 '+)
                    (make-goal 2 -2 #:color 'lightblue)
                    (make-driver 0 -2)
                    
                    (make-htrack -2 2 0)
                    (make-goal 2 0)
                    (make-follower -2 0))))

(define lv4 ; basic double driver
  (make-level (list (make-htrack -2 0 2)
                    (make-goal 0 2)
                    (make-follower -2 2)

                    (make-htrack 0 2 -2)
                    (make-goal 2 -2)
                    (make-follower 0 -2)
                    
                    (make-htrack -2 2 0 '+)
                    (make-driver -2 0))))

;similar paths, half scale
(define linear1
  (make-level (list (make-htrack -3 -1 .5)
                    (make-vtrack -1 .5 2.5)
                    (make-htrack -1 1 2.5)
                    (make-vtrack 1 2.5 .5)
                    (make-htrack 1 3 .5)
                    (make-goal 3 .5)

                    (make-htrack -3.5 -2.5 -2.5 '+)
                    (make-vtrack -2.5 -1.5 -2.5 '+)
                    (make-htrack -2.5 -1.5 -1.5 '+)
                    (make-vtrack -1.5 -1.5 -2.5 '+)
                    (make-htrack -1.5 -.5 -2.5 '+)

                    (make-htrack 3.5 2.5 -2.5 '+)
                    (make-vtrack 2.5 -1.5 -2.5 '+)
                    (make-htrack 2.5 1.5 -1.5 '+)
                    (make-vtrack 1.5 -1.5 -2.5 '+)
                    (make-htrack 1.5 .5 -2.5 '+)

                    (make-driver -3.5 -2.5)
                    (make-driver .5 -2.5)
                    (make-follower -3 .5))))

;similar paths, quarter scale
(define linear2
  (make-level (list (make-htrack -3 -1 .5)
                    (make-vtrack -1 .5 2.5)
                    (make-htrack -1 1 2.5)
                    (make-vtrack 1 2.5 .5)
                    (make-htrack 1 3 .5)
                    (make-goal 3 .5)

                    (make-htrack -3.75 -3.25 -2.5 '+)
                    (make-vtrack -3.25 -2.5 -2 '+)
                    (make-htrack -3.25 -2.75 -2 '+)
                    (make-vtrack -2.75 -2 -2.5 '+)
                    (make-htrack -2.75 -2.25 -2.5 '+)

                    (make-htrack -1.75 -1.25 -2.5 '+)
                    (make-vtrack -1.25 -2.5 -2 '+)
                    (make-htrack -1.25 -.75 -2 '+)
                    (make-vtrack -.75 -2 -2.5 '+)
                    (make-htrack -.75 -.25 -2.5 '+)

                    (make-htrack 1.75 1.25 -2.5 '+)
                    (make-vtrack 1.25 -2.5 -2 '+)
                    (make-htrack 1.25 .75 -2 '+)
                    (make-vtrack .75 -2 -2.5 '+)
                    (make-htrack .75 .25 -2.5 '+)

                    (make-htrack 3.75 3.25 -2.5 '+)
                    (make-vtrack 3.25 -2.5 -2 '+)
                    (make-htrack 3.25 2.75 -2 '+)
                    (make-vtrack 2.75 -2 -2.5 '+)
                    (make-htrack 2.75 2.25 -2.5 '+)

                    (make-driver -3.75 -2.5)
                    (make-driver -1.75 -2.5)
                    (make-driver .25 -2.5)
                    (make-driver 2.25 -2.5)
                    (make-follower -3 .5))))

;off-center linear track for multiplier
(define linear3
  (make-level (list (make-htrack -3 3 0 '*)

                    (make-driver -3 0)

                    (for/list ([n '(3 2 0 -1 -2 -3)])
                      (list (make-follower -3 n))))))


                    
