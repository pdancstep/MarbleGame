#lang racket
(require "components.rkt" "level.rkt"
         "opposing-inputs.rkt" "zero-point.rkt")

; sample change

;circuitous path
(define example1
  (make-level (list (make-htrack -2.5 2.5 0)
                    (make-rot-track 0 (* 2 pi) .5)
                    (make-rot-track 0 (* 2 pi) 1.5)
                    (make-goal 2.5 0)

                    (make-rot-track -.001 0 3.5 '*)
                    (make-rot-track 0 pi 3.5 '*)
                    (make-htrack -.5 .5 -2.5 '+)

                    
                    (make-driver -.5 -2.5)
                    (make-driver -3.5 0)
                    (make-follower -2.5 0))))

;Across the origin (solvable in three moves)
(define example2
  (make-level (list (make-vtrack 0 1.2 -.6)
                    (make-goal 0 -.6)
                    (make-follower 0 1.2)

                    (make-vtrack 0 3.6 1.8 '*)
                    (make-driver 0 3.6)

                    (make-vtrack 0 -1.85 -2.75 '+)
                    (make-driver 0 -1.85))))



;inchworm (solvable in 10 moves)
(define example3
  (make-level (list (make-htrack 1/3 10/3 0)
                    (make-follower 1/3 0)
                    (make-goal 10/3 0)

                    (make-vtrack 0 2/3 4/3 '*)
                    (make-driver 0 2/3)
                    (make-htrack -1/3 1/3 -1 '+)
                    (make-driver -1/3 -1))))



;similar paths, half scale
(define example4
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
(define example5
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







;circumferential paths (kinda messy)...
(define example6
  (make-level (list ;center diamond
                    (make-linear-track 0 1 -1 0 '+)
                    (make-linear-track -1 0 0 -1 '+)
                    (make-linear-track 0 -1 1 0 '+)
                    (make-linear-track 1 0 0 1 '+)

                    ;inner circle
                    (make-rot-track 0 (* 2 pi) 1.5 '*)
                    (make-linear-track -.45 2.5 .55 3.5)

                    ;quadrant 1
                    (make-rot-track (* .05 pi) (* .45 pi) 3.5)
                    (make-rot-track (* .08 pi) (* .42 pi) 2.5)

                    ;quadrant 2
                    (make-rot-track (* 1/2 pi) (* .95 pi) 3.5)
                    (make-rot-track (* .55 pi) (* .92 pi) 2.5)

                    (make-linear-track -3.5 .5 -2.5 -.5)
                    (make-linear-track -3.5 -.5 -2.5 .5)

                    ;quadrant 3/4
                    (make-rot-track (* 1.05 pi) (* 1.95 pi) 3.5)
                    (make-rot-track (* 1.08 pi) (* 1.92 pi) 2.5)

                    (make-linear-track -.5 -2.5 .5 -3.5)
                    (make-linear-track -.5 -3.5 .5 -2.5)

                    (make-linear-track 3.5 .5 2.5 -.5)
                    (make-linear-track 3.5 -.5 2.5 .5)



                    (make-goal (* 2.5 (cos (* .42 pi))) (* 2.5 (sin (* .42 pi))))
                    
                    (make-driver 0 1)
                    (make-driver 0 1.5)
                    (make-follower 0 3.5))))


;pokemon ball maze
(define example7
  (make-level (list ;orange tracks
                    (make-rot-track (* 3/4 pi) (* 5/4 pi) 3.5 '*)
                    (make-rot-track (* 7/4 pi) (* 9/4 pi) 3.5 '*)

                    (make-linear-track (* 4.4 (cos (* 21/16 pi))) (* 4.4 (sin (* 21/16 pi)))
                                       (* 2.2 (cos (* 21/16 pi))) (* 2.2 (sin (* 21/16 pi))) '*)
                    (make-linear-track (* 4.4 (cos (* 27/16 pi))) (* 4.4 (sin (* 27/16 pi)))
                                       (* 2.2 (cos (* 27/16 pi))) (* 2.2 (sin (* 27/16 pi))) '*)

                    ;grey tracks
                    (make-htrack -.75 .75 0)
                    (make-vtrack 0 -1.5 1.5)
                    (make-rot-track 0 (* 2 pi) .75)
                    (make-rot-track pi (* 2.88 pi) 1.5)

                    (make-htrack -3 -1.5 0)
                    (make-htrack 3 1.5 0)
                    (make-rot-track 0 pi 3)

                    (make-goal -1.5 0)
                    
                    (make-driver (* 2.2 (cos (* 21/16 pi))) (* 2.2 (sin (* 21/16 pi))))
                    (make-driver (* 2.2 (cos (* 27/16 pi))) (* 2.2 (sin (* 27/16 pi))))

                    (make-driver (* 3.5 (cos (* 5/4 pi))) (* 3.5 (sin (* 5/4 pi))))
                    (make-driver (* 3.5 (cos (* 9/4 pi))) (* 3.5 (sin (* 9/4 pi))))

                    (make-follower -.75 0 ))))


                    

                    
                                       



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

