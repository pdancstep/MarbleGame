#lang racket
(require "components.rkt" "level.rkt")

(define example1
  (make-level (list (make-htrack -2.5 2.5 0)
                    (make-rot-track 0 (* 2 pi) .5)
                    (make-rot-track 0 (* 2 pi) 1.5)
                    (make-goal 2.5 0)

                    (make-rot-track 0 pi 3.5 '*)
                    (make-htrack -.5 .5 -2.5 '+)

                    
                    (make-driver -.5 -2.5)
                    (make-driver -3.5 0)
                    (make-follower -2.5 0))))

(define example2
  (make-level (list (make-vtrack 0 -1 1.5)
                    (make-goal 0 -1)
                    (make-follower 0 1.5)

                    (make-vtrack 0 2 3.5 '*)
                    (make-driver 0 3.5)

                    (make-vtrack 0 -3 -2 '+)
                    (make-driver 0 -2))))

(define example3
  (make-level (list (make-htrack -2.5 2.5 0)
                    (make-rot-track pi (* 1.25 pi) 2.5)
                    (make-rot-track (* -.25 pi) 0 2.5)
                    (make-goal (- (* 2.5 (cos (* 1.25 pi)))) (* 2.5 (sin (* 1.25 pi))))
                    
                    (make-rot-track (* pi .375) (* pi .625) 2.5 '*)
                    (make-htrack -2.5 2.5 -2.5 '+)

                    
                    (make-driver -2.5 -2.5)
                    (make-driver (* 2.5 (cos (* .625 pi))) (* 2.5 (sin (* .625 pi))))
                    (make-follower (* 2.5 (cos (* 1.25 pi))) (* 2.5 (sin (* 1.25 pi)))))))

(define example4
  (make-level (list (make-vtrack -3 -2 2.5 '+)
                    (make-driver -3 -2)
                    (make-htrack -2 2 -3 '+)
                    (make-driver -2 -3)
                    
                    (make-follower -2 -2)
                    ; TODO make grid into an actual maze
                    (for/list ([n '(-2 -1 0 1 2)])
                      (list (make-htrack -2 2 n) (make-vtrack n -2 2)))
                    (make-goal 2 2.5)
                    (make-vtrack 2 2 2.5))))

(define example5
  (make-level (list (make-htrack 1/3 10/3 0)
                    (make-follower 1/3 0)
                    (make-goal 10/3 0)

                    (make-vtrack 0 2/3 4/3 '*)
                    (make-driver 0 2/3)
                    (make-htrack -1/3 1/3 -1 '+)
                    (make-driver -1/3 -1))))


(define example6
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

