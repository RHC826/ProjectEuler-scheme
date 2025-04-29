;;;;; Euler Project Q.7
#|
url:https://odz.sakura.ne.jp/projecteuler/?Problem+7
素数を小さい方から6つ並べると 2, 3, 5, 7, 11, 13 であり, 6番目の素数は 13 である.

10 001 番目の素数を求めよ.

comment:
最初試し割を実装した。その後,素数篩を実装した。
十分に大きい N をふるい落とすエラトステネスのふるいが圧倒的に速いが N が勘なので、これで良いのか？という疑問もある。
篩はcons と filter の非効率そうなものと、ベクトルを使ったエラトステネスのふるいの２つを試した。
Lisp のリストは連結リストなので、ベクトルにするだけで速くなりそう。
しかし、Lisp を使った甲斐がない気もする。
|#
;;; score
;; real    0m10.776s
;; user    0m10.769s
;; sys     0m0.009s
;;
;; real    0m1.550s
;; user    0m3.205s
;; sys     0m0.127s
;;
;; real    0m0.019s
;; user    0m0.026s
;; sys     0m0.007s

;;; エントリーポイント
(define (main args)
  (print (Euler7/sieve))
  0)

;;; 実装
;; given primes.
(define primes '(2 3 5 7 11 13))

;; 試し割
;; real    0m1.550s
;; user    0m3.205s
;; sys     0m0.127s
(define (Euler7)
  (let loop ((count 15) ; next 13
             (found primes))
    (if (>= (length found) 10001)
      (car (reverse found))
      (if (next-prime count found)
        (loop (+ count 2) (append found (list count)))
        (loop (+ count 2) found)))))

(define (next-prime n primes)
  (let ((prime? #f))
    (cond
      ((null? n) #f)
      ((< (sqrt n) (car primes)) #t)
      ((null? primes) #t)
      ((= 0 (remainder n (car primes)))
        #f)
      (else (next-prime n (cdr primes))))))

;; エラトステネスのふるいを使う方法
;; N までの自然数に素数がいくつあるのかを調べるにはとても速い方法だが、
;; N が大きくなりがち、N を事前に推定することができれば良さそう。
;; (N = 125000) で計算しているが、これはガチャガチャ調べた結果
(define (Euler7/sieve)
  (let ((primes (sieve-fast 125000)))
    (list-ref primes 10000)))

;; cons と filter による単純な素数判定篩
;; (list-ref (sieve 200000) 10000)
;; real    0m15.872s
;; user    0m19.542s
;; sys     0m0.192s
(define (sieve n)
  ;; 再帰で素数リストを作る
  (define (sieve-helper numbers primes)
    (if (null? numbers)
      (reverse primes) ; 完了時には primes を返す
      (let* ((current (car numbers)) ; 現在注目する数
             (filtered (filter (lambda (x) (not (zero? (remainder x current))))
                        (cdr numbers)))) ; current の倍数を除去
        (sieve-helper filtered (cons current primes))))) ; current を素数として記録

  ;; 2 から n までのリストを作成
  (sieve-helper (iota (- n 1) 2) '()))

;; 高速化版：エラトステネスのふるい（Sieve of Eratosthenes）
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
