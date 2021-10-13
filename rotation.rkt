#lang racket
(require "components.rkt" "level.rkt")
(provide (all-defined-out))

;circuitous path
(define rot1
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

;circumferential paths (kinda messy)...
(define rot2
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

;enter in reverse
(define rot3
  (make-level (list (make-rot-track 0 (* 2 pi) 1.5 #:center -2+2i '+)
                    (make-rot-track 0 (* 2 pi) 1.5 #:center -2-2i '+)

                    (make-htrack -3.5 2 2 '+)
                    (make-vtrack .5 2 -2 '+)
                    (make-vtrack 2 2 -2 '+)
                    (make-htrack 2 3 -2 '+)
                    (make-htrack 2 3 -3.5 '+)
                    (make-rot-track pi (* 3/2 pi) 1.5 #:center 2-2i '+)

                    (make-goal 3 -2 #:color 'lightblue)
                    (make-goal 3 -3.5 #:color 'lightblue)

                    (make-driver -2 2)
                    (make-driver -.5 -2)
                    (make-follower -.5 2))))


;Another orientation/parking problem type level...
(define rot4
  (make-level (make-rot-track 0 (* 2 pi) 1.5 '+ #:center -2-2i)

              (make-rot-track (* .5 pi) (* 2 pi) 1.5 '+ #:center 2-2i)
              (make-vtrack .5 -2 2 '+)
              (make-vtrack 2 -3.5 3.5 '+)
              (make-htrack .5 2 2 '+)
              (make-htrack .5 3.5 -2 '+)

              (make-htrack .5 2 3.5 '+)
              (make-rot-track (* .5 pi) pi 1.5 '+ #:center .5+2i)
              (make-vtrack -1 .5 2 '+)

              (make-goal -1 .5 #:color 'lightblue)

              (make-driver -.5 -2)
              (make-driver .5 2)
              (make-follower 2 2)))

                     
;Swarm control experiment                   
(define rot5
  (make-level (make-rot-track 0 (* 2 pi) 1 '*)
              (make-vtrack 3 0 2 '+)
              (make-goal 2 -2)
              (make-vtrack 0 1.5 3.5 '*)

              (make-driver 1 0)
              (make-driver 3 0)
              (make-driver 0 2.5)
              
              (make-follower 2 1)
              (make-follower -2 1)
              (make-follower -2 -1)
              (make-follower 2 -1)
              
              (make-follower 1 2)
              (make-follower 1 -2)
              (make-follower -1 -2)
              (make-follower -1 2)))



















               