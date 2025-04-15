;;;;; Euler Project Q.15

#|
url:https://odz.sakura.ne.jp/projecteuler/?Problem+15
url:https://projecteuler.net/problem=15

2×2 のマス目の左上からスタートした場合, 引き返しなしで右下にいくルートは 6 つある.
では, 20×20 のマス目ではいくつのルートがあるか.

time:

|#

;;; エントリーポイント
(define (main args)
  (display "20×20の格子経路の数: ")
  (display routes)
  (newline)
  0)

;;; 実装
;; 2項係数 binomial(n, k) を計算する関数
;; ※ k > n/2 の場合は対称性から binomial(n, k) = binomial(n, n-k)
(define (binomial n k)
  (if (> k (/ n 2))
      (binomial n (- n k))
      (let loop ((i 1) (acc 1))
        (if (> i k)
            acc
            (loop (+ i 1) ; i
                  (/      ; acc
                    (* acc 
                       (- (+ n 1) i ))
                    i))))))

;; m×n の格子で、左上から右下にいく経路数は
;; binomial(m+n, m) で求められる
(define (grid-routes m n)
  (binomial (+ m n) m))

;; 20×20 の格子経路の場合
(define routes (grid-routes 20 20))

;; n 個のものから r  個を（順番を考慮せず）選ぶ組合せの数
(define (combin n r)
  (/
    (permut n r) ; (apply * (iota  r n -1))
    ;; factorial
    (apply * (iota r 1 1))))

;; nPr
(define (permut n r)
  (apply * (iota  r n -1)))

(define (factorial n)
  (apply + (iota n 1 1)))

