;;;;; Euler Project Q.10

#|
url:https://projecteuler.net/problem=10
url:https://odz.sakura.ne.jp/projecteuler/?Problem+10

10以下の素数の和は 2 + 3 + 5 + 7 = 17 である.
200万以下の全ての素数の和を求めよ.

real    0m0.168s
user    0m0.177s
sys     0m0.020s
|#

;;; エントリーポイント
(define (main args)
  (print (apply + (sieve-fast 2000000)))
  0)

;;; 実装
(define (sieve-fast n)
  ;; 0〜nまでの各インデックスに対し、素数であるかを示す真偽値ベクターを作成
  (let ((is-prime (make-vector (+ n 1) #t)))
    ;; 0 と 1 は素数ではないので、明示的に偽にする
    (vector-set! is-prime 0 #f)
    (vector-set! is-prime 1 #f)
    ;; √n までの数をループ（上限を floor(sqrt n) とする）
    (let ((limit (floor (sqrt n))))
      (do ((i 2 (+ i 1)))
        ((> i limit))
        (if (vector-ref is-prime i)
          ;; i が素数なら、i*i から n までの i の倍数をふるい落とす
          (do ((j (* i i) (+ j i))) ; j = i*i, 次は j+i
            ((> j n))
            (vector-set! is-prime j #f)))))
    ;; ベクターから素数だけを抽出してリストにする
    (let loop ((i 2) (primes '()))
      (if (> i n)
        (reverse primes) ; 昇順に並ぶように reverse をかける
        (if (vector-ref is-prime i)
          (loop (+ i 1) (cons i primes))
          (loop (+ i 1) primes))))))
