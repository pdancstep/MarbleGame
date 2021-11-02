#lang racket
(require "components.rkt" "level.rkt" "principles.rkt"
         "additive.rkt" "opposing-inputs.rkt"
         "rotation.rkt" "scaling.rkt" "zero-point.rkt"
         "ratchet.rkt"
         "sharing.rkt")


;ADDITIVE:

;lv1
;lv2
;lv3
;lv4
;similar1
;similar2
;slideMaze




;ROTATION:

;rot1
;rot2
;rot3
;rot4
;rot5



;SCALING

;scaling1
;scaling2




;OPPOSING INPUTS

;oppo1
;oppo2
;oppo3
;oppo4
;oppo5




;ZERO-POINT

;zp1
;zp2
;zp3
;zp4





;RATCHET

;ratchet1
;ratchet2



;SHARING

;share1

; if secondary driver skips over the origin, followers continue normally,
; but if we stop at exactly 0, followers get stuck at the origin
(define chain1
  (make-level (make-vtrack -2 -2 2 '+)
              (make-vtrack 0 -2 2 '*)
              (make-linear-track 3/2 -2 -3/2 2)
              (make-linear-track 3/2 -1 -3/2 1)
              (make-linear-track 3/2 1 -3/2 -1)
              (make-linear-track 3/2 2 -3/2 -2)
              (make-driver -2 -2 'left)
              (make-marble 0 -2 #:drive 'right #:follow 'left #:color 'darkred #:draggable #t)
              (make-follower 3/2 -2 'right)
              (make-follower 3/2 -1 'right)
              (make-follower 3/2 1 'right)
              (make-follower 3/2 2 'right)))

(define chain2
  (make-level (make-vtrack -2 -2 2 '*)
              (make-vtrack 2 -2 2 '*)
              (make-vtrack 1 -1 1 '+)
              (make-driver -2 -2 'main)
              (make-marble 1 1 #:drive 'add #:follow 'main #:color 'darkred #:draggable #t)
              (make-marble 2 2 #:drive 'mult #:follow 'main #:color 'darkred #:draggable #t)
              (make-follower 3 -3 'mult)
              (make-follower 3 -2 'add)
              (make-follower 3 -1 'mult)
              (make-follower 3 0 'add)
              (make-follower 3 1 'mult)
              (make-follower 3 2 'add)
              (make-follower 3 3 'mult)
              (make-follower 2 3 'add)
              (make-follower 1 3 'mult)
              (make-follower 0 3 'add)
              (make-follower -1 3 'mult)
              (make-follower -2 3 'add)
              (make-follower -3 3 'mult)
              (make-follower -3 2 'add)
              (make-follower -3 1 'mult)
              (make-follower -3 0 'add)
              (make-follower -3 -1 'mult)
              (make-follower -3 -2 'add)
              (make-follower -3 -3 'mult)
              (make-follower -2 -3 'add)
              (make-follower -1 -3 'mult)
              (make-follower 0 -3 'add)
              (make-follower 1 -3 'mult)
              (make-follower 2 -3 'add)))

(define square
  (make-level (make-rot-track (sub1 (* pi 2)) (* pi 3) 1 '*)
              (make-rot-track 0 pi 2 '*)
              (make-rot-track 0 (* pi 2) 3)
              (make-driver 1 0 'base)
              (make-marble 2 0 #:drive 'outer #:follow 'base)
              (make-marble 2 0 #:drive 'outer #:follow 'base)
              (make-follower 3 0 'outer)))


(define stripes1
  (make-level (make-htrack -3 -2 -3 '+)
              (make-htrack -3 -1.8 -2 '+)
              (make-htrack -3 -1.5 -1 '+)
              (make-htrack -3 -1 0 '+)
              (make-htrack -3 0 1 '+)
              (make-htrack -3 3 2 '+)
              (make-htrack -3 3 3)

              (make-goal 3 3)

              (make-driver -3 -3 'first)
              (make-marble -3 -2 #:drive 'second #:follow 'first #:draggable #t)
              (make-marble -3 -1 #:drive 'third #:follow 'second #:draggable #t)
              (make-marble -3 0 #:drive 'fourth #:follow 'third #:draggable #t)
              (make-marble -3 1 #:drive 'fifth #:follow 'fourth #:draggable #t)
              (make-marble -3 2 #:drive 'sixth #:follow 'fifth #:draggable #t)
              (make-follower -3 3 (list 'first 'second 'third 'fourth ' fifth 'sixth))))

(define stripes2
  (make-level (make-htrack -3 -2 -3 '+)
              (make-htrack -3 -1.8 -2 '+)
              (make-htrack -3 -1.5 -1 '+)
              (make-htrack -3 -1 0 '+)
              (make-htrack -3 0 1 '+)
              (make-htrack -3 3 2 '+)
              (make-htrack -3 3 3)

              (make-goal 3 3)

              (make-driver -3 -3 'first)
              (make-marble -3 -2 #:drive 'second #:follow 'first #:draggable #t)
              (make-marble -3 -1 #:drive 'third #:follow (list 'first 'second) #:draggable #t)
              (make-marble -3 0 #:drive 'fourth #:follow (list 'first 'second 'third) #:draggable #t)
              (make-marble -3 1 #:drive 'fifth #:follow (list 'first 'second 'third 'fourth) #:draggable #t)
              (make-marble -3 2 #:drive 'sixth #:follow (list 'first 'second 'third 'fourth 'fifth) #:draggable #t)
              (make-follower -3 3 (list 'first 'second 'third 'fourth ' fifth 'sixth))))


(define tugOfWar1
  (make-level (make-htrack -3 3 -2 '+)
              (make-htrack -3 3 0 '+)
              (make-htrack -3 3 2)

              (make-goal 3 2)
              (make-goal 0 0 #:color 'lightBlue)
              (make-goal 3 -2 #:color 'lightBlue)

              (make-driver -3 -2 'primary #:color 'red)
              (make-marble 0 0 #:drive 'secondary #:follow 'primary #:draggable #t #:color 'orange)
              (make-follower -3 2 (list 'primary 'secondary) #:color 'yellow)))

(define tugOfWar2
  (make-level (make-htrack -3 3 -2 '+)
              (make-htrack -3 3 0 '+)
              (make-htrack -3 3 2)

              (make-goal 0 2)
              (make-goal -3 0 #:color 'lightBlue)
              (make-goal 3 -2 #:color 'lightBlue)

              (make-driver -3 -2 'primary #:color 'red)
              (make-marble 0 0 #:drive 'secondary #:follow 'primary #:draggable #t #:color 'orange)
              (make-follower -3 2 (list 'primary 'secondary) #:color 'yellow)))


(define threeWays
  (make-level (make-goal 1.5 0)
              (make-goal 2 0)

              (make-htrack -2 -1 0 '*)
              (make-htrack -2 -1 -1 '+)
              (make-htrack -2 -1 -2 '+ #:color 'lightGreen)

              (make-htrack 1 3 0)

              (make-driver -2 -2 'both)
              (make-marble -2 -1 #:drive 'add #:follow 'both #:draggable #t #:color 'blue)
              (make-marble -2 0 #:drive 'mult #:follow 'both #:draggable #t #:color 'chocolate)
              (make-follower 2 0 (list 'add 'mult))))

(define algtest
  (make-level (make-vtrack -3 -3 3 '+)
              (make-vtrack -1 -3 3 '+)
              (make-vtrack 1 -3 3 '+)
              (make-vtrack 3 -3 3 '+)
              (make-marble -3 -3 #:drive 'A) ; A
              (make-marble -1 -3 #:drive 'B #:follow 'A) ; B
              (make-marble 1 -3 #:drive 'C #:follow '(A B)) ; C
              (make-marble 3 -3 #:follow '(A B C)))) ; D























 
