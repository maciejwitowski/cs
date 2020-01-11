(define (square x) (* x x))

(define (sum-square-two-larger x y z)
  (-  (+ (square x)
         (square y)
         (square z))
      (min x y z))
)
