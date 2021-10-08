#lang racket
(require "components.rkt" "level.rkt")
(provide (all-defined-out))



;;;;;;OFFCENTER LINEAR MULTIPLICATIVE TRACKS...



;Horizontal and vertical tracks with endpoints on the 45° diagonals form
;an especially well-behaved subset. We consider these first.


;The effect of sliding a driver along such a track revolves all other marbles
;90° around the origin, with a slight contraction/expansion along the way.

(define princ1
  (make-level (list (make-vtrack -3 3 -3 '*)

                    (make-driver -3 -3)

                    
                    (for/list ([n '( -2 -1 0 1 2 3)])
                      (for/list ([m '(-3 -2 -1 0 1 2 3)])
                        (list (make-follower n m)))))))




;If we only pay attention to a single row of followers we can see that they maintain
;linear formation and move in straight lines towards their destinations.

(define princ2
  (make-level (list  (make-htrack -3 3 3 '*)

                     (make-driver -3 3)

                     (for/list ([n '(1 2 0 -1 -2 -3)])
                       (list (make-follower -3 n))))))




;In the example below, it's easy to see how the swarm of followers obeys
;the global scale-and-rotate logic of the driver. But try focusing on an individual
;follower and imagine what it's individual logic is as it obeys the driver.

(define princ3
  (make-level (list (make-vtrack -3 3 -3 '*)
                    (make-htrack -3 3 3 '*)
                    (make-vtrack 3 3 -3 '*)
                    (make-htrack -3 3 -3 '*)

                    (make-vtrack -1 1 -1)
                    (make-htrack -1 1 1)
                    (make-vtrack 1 1 -1)
                    (make-htrack -1 1 -1)

                    (make-linear-track -2.5 0 0 2.5)
                    (make-linear-track 2.5 0 0 -2.5)
                    (make-linear-track 0 -2.5 -2.5 0)
                    (make-linear-track 0 2.5 2.5 0)

                    (make-driver -3 3)

                    (make-follower -2.5 0)
                    (make-follower -1 1)
                    (make-follower -1 -1)
                    (make-follower 0 2.5)
                    (make-follower 0 -2.5)
                    (make-follower 1 1)
                    (make-follower 1 -1)
                    (make-follower 2.5 0))))



;The principles illustrated in the following examples will focus on this
;"local" logic that each marble is obeying as it responds to the
;driver's movement.


;Horizontal and vertical tracks that end on 45° diagonals have the same effect
;no matter how far they are from the origin. This means you can have
;followers that go significantly faster or slower than the driver, depending
;on where each one is relative to the origin.

(define princ4
  (make-level (list (make-vtrack -3.5 -3.5 3.5 '*)
                    (make-vtrack -1 -1 1)
                    (make-vtrack 1 -1 1 '*)
                    (make-vtrack 3.5 -3.5 3.5)

                    (make-driver -3.5 -3.5 'long)
                    (make-driver 1 1 'short)

                    (make-follower -1 -1 'long)
                    (make-follower 3.5 3.5 'short))))


;followers and drivers may move together or in oppostion, depending
;on whether they are on the same side or opposite sides of the origin.

(define princ5
  (make-level (list (make-htrack -1 1 1 '*)
                    (make-htrack -3 3 3)
                    (make-htrack -3 3 -3)

                    (make-driver -1 1)

                    (make-follower -3 3)
                    (make-follower 3 -3))))



;If the driver and follower are 90° offset from one another around the origin,
;horizontal motion in one means vertical motion in the other. It's helplful
;to think of them as ROTATING together, cw or ccw, rather than sliding together.

(define princ6
  (make-level (list (make-vtrack -3 3 -3 '*)
                    (make-vtrack 3 3 -3 '*)

                    (make-vtrack 2 2 -2)
                    (make-htrack -2 2 2)

                    (make-driver -3 3)
                    (make-driver 3 -3)
                    (make-follower 2 -2))))




;Driver tracks can be repositioned at any distance from the origin
;without affecting follower behavior

(define princ7
  (make-level (list (make-vtrack -3 3 -3 '*)
                    (make-vtrack 1 1 -1 '*)

                    (make-vtrack 2 2 -2)
                    (make-htrack -2 2 2)

                    (make-driver -3 3)
                    (make-driver 1 -1)
                    (make-follower 2 -2))))




;This can be used to set up driver tracks that look nothing like the
;follower tracks


(define princ8
  (make-level (list (make-vtrack -3.5 -3.5 3.5 '*)
                    (make-vtrack -2.5 -2.5 2.5 '*)
                    (make-vtrack -1.5 -1.5 1.5 '*)

                    (make-htrack -1 1 1)
                    (make-vtrack 1 1 -1)
                    (make-htrack -1 1 -1)

                    (make-driver -3.5 3.5)
                    (make-driver -2.5 2.5)
                    (make-driver -1.5 1.5)

                    (make-follower -1 -1))))




;;;;Now let's also consider diagonal tracks and tracks that start and end
;on the horizontal and vertical axes.

;If the angular offset between the driver and the follower around the origin
;is 45°, 135°, etc., then oneof them  will move diagonally relative to the other...

(define princ9
  (make-level (list (make-vtrack -3 3 -3 '*)
                    (make-htrack -3 3 3 '*)

                    (make-linear-track 0 2 2 0)
                    (make-linear-track 0 -2 2 0)

                    (make-driver -3 3)
                    (make-follower 2 0))))



;If we consider horizontal and vertical tracks that only go from a diagonal
;to an axis, the endpoints are different distances from the origin. This means
;that the follower must get proportionally closer/further from the origin when these
;multipliers are adjusted. Note in this example how the follower spirals in towards
;the center.

(define princ10
  (make-level (list (make-vtrack -3 0 3 '*)
                    (make-htrack -3 0 -3 '*)
                    (make-vtrack 3 -3 0 '*)
                    (make-htrack 0 3 3 '*)

                    (make-linear-track 2 -2 2 0)
                    (make-linear-track 2 0 1 1)
                    (make-linear-track 1 1 0 1)
                    (make-linear-track 0 1 -.5 .5)

                    (make-driver -3 3)
                    (make-driver -3 -3)
                    (make-driver 3 -3)
                    (make-driver 3 3)

                    (make-follower 2 -2))))




;A related puzzle?

(define princ11
  (make-level (list (make-vtrack -3 3 -3 '*)
                    (make-vtrack 3 3 -3 '*)

                    (make-vtrack 2 0 -2)
                    (make-htrack -2 0 2)
                    (make-linear-track 0 2 2 0)

                    (make-goal -2 2)

                    (make-driver -3 3)
                    (make-driver 3 -3)
                    (make-follower 2 -2))))








;Some additional examples with other kinds of tracks....


;Which circle the follower traces depends on the "clocking" of the
;the driver being dragged.

(define circs
  (make-level (list (make-rot-track 0 (* 2 pi) .428 #:center 0+1.07i)
                    (make-rot-track 0 (* 2 pi) 1 #:center 0+2.5i)

                    (make-rot-track 0 (* 2 pi) 1 '* #:center 2.5)
                    (make-rot-track 0 (* 2 pi) 1 '* #:center -2.5)

                    (make-driver -3.5 0)
                    (make-driver 1.5 0)

                    (make-follower 0 1.5))))





;90° offset of driver/follower around the origin means the path shaped of
;the follower is the same as that of the driver, rotated 90°. (note: this one
;is a little squirrily at the juctions.

(define twoPills
  (make-level (list (make-rot-track 0 pi 1  #:center 0+2.5i)
                    (make-rot-track pi (* 2 pi) 1  #:center 0-2.5i)
                    (make-vtrack -1 2.5 -2.5)
                    (make-vtrack 1 2.5 -2.5)



                    (make-rot-track (* .5 pi) (* 1.5 pi) 1 '* #:center -2.5)
                    (make-rot-track (* 1.5 pi) (* 2.5 pi) 1 '* #:center 2.5)
                    (make-htrack -2.5 2.5 1 '*)
                    (make-htrack -2.5 2.5 -1 '*)

                    (make-driver -2.5 1)
                    (make-follower 1 2.5))))





;Early experiment mixing linear/multiplicative tracks. Circulate the driver twice
;to circulate the follower once. (note: also squirrily).



(define staircase
  (make-level (make-vtrack -1 1 -1 '*)
              (make-htrack -1 1 -1 '*)
              (make-vtrack 1 1 -1 '+)
              (make-htrack -1 1 1 '+)

              (make-vtrack -3.5 3.5 -3.5)
              (make-htrack -3.5 3.5 -3.5)
              (make-vtrack 3.5 -1.5 -3.5)
              (make-htrack 1.5 3.5 -1.5)
              (make-vtrack 1.5 -1.5 1.5)
              (make-htrack -1.5 1.5 1.5)
              (make-vtrack -1.5 1.5 3.5)
              (make-htrack -3.5 -1.5 3.5)

              (make-driver -1 1)
              (make-follower -3.5 3.5)))



;Distributive property demonstration?

(define dist
  (make-level (make-rot-track (* .5 pi) (* 1.5 pi) 1 '+ #:center -2)
              (make-rot-track (* .5 pi) (* 1.5 pi) .5 '+ #:center -1)

              (make-vtrack 0 -1 -2 '*)

              (make-goal 3 2)

              (make-follower 1.5 0)

              (make-driver -2 -1)
              (make-driver -1 -.5)
              (make-driver 0 -1)))

