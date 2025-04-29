;;;;; Euler Project
;;;; Q.1

;;; エントリーポイント
(define (main args)
  (print (euler1 (iota 1000 0 1)))
  0)

;;; 実装
(define (euler1 range)
  (fold + 0
    (filter
      (lambda (x)
        (or
          (= 0 (remainder x 3))
          (= 0 (remainder x 5))))
      range)))
