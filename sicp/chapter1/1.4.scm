; The following procedure evaluates the operator (+ or -)
; based on the condition (b > 0) and applies it to operands (a, b)
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))
