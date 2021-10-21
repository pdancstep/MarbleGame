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
