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
(define similar1
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

;similar paths, third scale
(define similar2
  (make-level (make-htrack -3 -1 1/2)
              (make-vtrack -1 0 2)
              (make-htrack -1 1 2)
              (make-vtrack 1 2 0)
              (make-htrack 1 3 1/2)
              (make-goal 3 .5)
              (make-follower -3 1/2 'big)
              (make-htrack -1 1 0)
              (make-vtrack 0 -1 0)
              (make-goal 0 -1)
              (make-follower 0 -1 'small)
              
              (make-htrack -3 -7/3 -5/2 '+)
              (make-vtrack -7/3 -5/2 -2 '+)
              (make-htrack -7/3 -5/3 -2 '+)
              (make-vtrack -5/3 -2 -5/2 '+)
              (make-htrack -5/3 -1 -5/2 '+)
              (make-driver -3 -5/2 'big)
              
              (make-htrack -1 -1/3 -2 '+)
              (make-vtrack -1/3 -2 -5/2 '+)
              (make-htrack -1/3 1/3 -5/2 '+)
              (make-vtrack 1/3 -5/2 -2 '+)
              (make-htrack 1/3 1 -2 '+)
              (make-driver -1 -2 'big)
              
              (make-htrack 1 5/3 -5/2 '+)
              (make-vtrack 5/3 -5/2 -2 '+)
              (make-htrack 5/3 7/3 -2 '+)
              (make-vtrack 7/3 -2 -5/2 '+)
              (make-htrack 7/3 3 -5/2 '+)
              (make-driver 1 -5/2 'big)

              (make-vtrack -8/3 3/2 2 '+)
              (make-htrack -8/3 -2 2 '+)
              (make-vtrack -2 3/2 2 '+)
              (make-driver -2 3/2 '(big small) #:color 'red)

              (make-vtrack 2 3/2 2 '+)
              (make-htrack 2 8/3 2 '+)
              (make-vtrack 8/3 3/2 2 '+)
              (make-driver 2 3/2 '(big small) #:color 'red)))

(define slideMaze
  (make-level (make-htrack -2.5 2.5 3 '+)
              (make-vtrack -2.5 1 3 '+)
              (make-vtrack -.5 3 -1 '+)
              (make-vtrack .5 1 3 '+)
              (make-vtrack 1.5 1 -1 '+)
              (make-vtrack 2.5 3 -1 '+)
              (make-htrack -3.5 1.5 1 '+)
              (make-htrack 2.5 3.5 1 '+)
              (make-vtrack 1.5 1 -1 '+)

              (make-goal -.5 -1 #:color 'lightblue)
              (make-goal 1.5 -1 #:color 'lightblue)
              (make-goal 2.5 -1 #:color 'lightblue)

              (make-htrack -.5 .5 -2.5 '+)

              (make-driver .5 -2.5)
              (make-driver -2.5 1)

              (make-follower -3.5 1)
              (make-follower -.5 1)))
              




                    
