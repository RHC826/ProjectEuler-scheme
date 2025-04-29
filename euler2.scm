;;;;; Euler Project
;;;; Q.2

;;; エントリーポイント
(define (main args)
  (print (fold + 0 (filter (lambda (x) (= 0 (remainder x 2))) (fib-list 4000000))))
  0)

;;; 実装
(define (fib-list size)
  (fib-iter 0 1 size))

(define (fib-iter a b size)
  (if (<= size a)
    '()
    (cons b
      (fib-iter b (+ a b) size))))
