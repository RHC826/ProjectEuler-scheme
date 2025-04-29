;;;;; Euler Project Q.16

#|
url:https://projecteuler.net/problem=16
url:https://odz.sakura.ne.jp/projecteuler/?Problem+16

2^15 = 32768 であり, 各位の数字の和は 3 + 2 + 7 + 6 + 8 = 26 となる.

同様にして, 21000 の各位の数字の和を求めよ.

注: Problem 20 も各位の数字の和に関する問題です。解いていない方は解いてみてください。

time:

comment:
|#

;;; エントリーポイント
(define (main args)
  (cond
    ;; テスト

    (else
      (print (euler16 1000))
      0)))

;;; 実装
(define (euler16 n)
  (define (make-ints n)
    (string->list (number->string (expt 2 n))))
  (let ((digits (make-ints n)))
    (apply + (map digit->integer digits))))
