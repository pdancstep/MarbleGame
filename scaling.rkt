#lang racket
(require "components.rkt" "level.rkt")
(provide (all-defined-out))

;pokemon ball maze
(define scaling1
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

