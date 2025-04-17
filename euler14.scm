;;;;; Euler Project Q.[number]

#|
url:https://projecteuler.net/problem=[number]
url:https://odz.sakura.ne.jp/projecteuler/?Problem+[number]

<p>The following iterative sequence is defined for the set of positive integers:</p>
<ul style="list-style-type:none;">
<li>$n \to n/2$ ($n$ is even)</li>
<li>$n \to 3n + 1$ ($n$ is odd)</li></ul>
<p>Using the rule above and starting with $13$, we generate the following sequence:
$$13 \to 40 \to 20 \to 10 \to 5 \to 16 \to 8 \to 4 \to 2 \to 1.$$</p>
<p>It can be seen that this sequence (starting at $13$ and finishing at $1$) contains $10$ terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at $1$.</p>
<p>Which starting number, under one million, produces the longest chain?</p>
<p class="note"><b>NOTE:</b> Once the chain starts the terms are allowed to go above one million.</p>
time:
real    0m11.832s
user    0m17.871s
sys     0m0.499s

comment:

|#
;;; エントリーポイント
(define (main args)
  (cond 
    ;; テスト
    ((not (= (chain 13) 10)) 
     (print "Error!"))

    (else 
      (print (cadr (euler14-2)))
      0)))

;;; 実装
;; do 構文を使ってみる
(define (euler14)
  (define (chain-length n)
    (define (next-chain x count)
      (cond ((= x 1) count)
            ((even? x) (next-chain (/ x 2) (+ count 1)))
            (else (next-chain (+ (* 3 x) 1) (+ count 1)))))
    (next-chain n 1))
  
  (define max-length 0)
  (define max-start 0)
  
  (do ((i 1 (+ i 1)))
      ((>= i 1000000) (begin
                        (display "最大長: ") (display max-length) (newline)
                        (display "開始数: ") (display max-start) (newline)))
    (let ((len (chain-length i)))
      (when (> len max-length)
        (set! max-length len)
        (set! max-start i)))))

(define (euler14-2)
  (do 
    ((i 1 (+ i 1))
     (acc '(0 0) (
             (lambda (x y) 
               (if (>  (car x)  (car y)) 
                 x 
                 y))
             acc (list (chain i) i))))
    ((> i 1000000) acc)))

;; コラッツ予想の連鎖数を返す
(define (chain x) ; int -> int
  (define (chain-helper x acc)
    (if (= x 1)
      (+ acc 1)
      (if (even? x)
        (chain-helper (/ x 2) (+ acc 1))
        (chain-helper (+ (* x 3) 1) (+ acc 1)))))

  (chain-helper x 0))

