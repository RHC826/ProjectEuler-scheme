;;;;; Euler Project Q.6

#|
url:https://odz.sakura.ne.jp/projecteuler/?Problem+6
最初の10個の自然数について, その二乗の和は,

12 + 22 + ... + 102 = 385
最初の10個の自然数について, その和の二乗は,

(1 + 2 + ... + 10)2 = 3025
これらの数の差は 3025 - 385 = 2640 となる.

同様にして, 最初の100個の自然数について二乗の和と和の二乗の差を求めよ.
|#

;;; エントリーポイント
(define (main args)
  ;; test code
  ;; (print (sum-squares (iota 10 1 1)))
  ;; (print (square-sum (iota 10 1 1)))
  ;; (print (-
  ;;          (square-sum (iota 10 1 1))
  ;;          (sum-squares (iota 10 1 1))))
  (print (-
          (square-sum (iota 100 1 1))
          (sum-squares (iota 100 1 1))))
  0)

;;; 実装
(define (sum-squares lst)
  (fold + 0
    (map (lambda (x) (* x x)) lst)))

(define (square-sum lst)
  (let ((sum (fold + 0 lst)))
    (* sum sum)))
