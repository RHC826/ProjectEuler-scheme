;;;;; Euler Project Q.[number]

#|
url:https://odz.sakura.ne.jp/projecteuler/?Problem+[number]



real    0m0.119s
user    0m0.155s
sys     0m0.010s
|#


;;; エントリーポイント
(define (main args)
  (print (cadr (euler12 500)))
  0)

;;; 実装
;; 試し割で約数をリストアップする => 現実的な時間で終わらない
(define (devisors x)
  (let devisors-iter ((n x) (devisor 1) (acc '()))
    (if (> devisor x)
      acc
      (if (zero? (remainder n devisor))
        (devisors-iter n (+ 1 devisor) (cons devisor acc))
        (devisors-iter n (+ 1 devisor) acc)
        ))))

;; 公式を使って約数の個数を出す
;; 1. 素因数分解する
;; 2. 指数のリストを得る
;; 3. 指数のリストの要素を + 1 して積を取る
(define (num-divisors n)
  (let* ((facts (factors n)))
    (define (count-exponents lst)
      (if (null? lst)
          '()
          (let loop ((cur (car lst))
                     (rest (cdr lst))
                     (count 1)
                     (acc '()))
            (cond
              ((null? rest)
               (reverse (cons count acc)))
              ((= cur (car rest))
               (loop cur (cdr rest) (+ count 1) acc))
              (else
               (loop (car rest) (cdr rest) 1 (cons count acc)))))))

    (apply * (map (lambda (x) (+ x 1))
                  (count-exponents facts)))))


(define (_factors x)
  (let factors-iter ((n x) (devisor 2) (acc '()))
    (if (= n devisor)
      (cons n acc)
      (if (= 0 (remainder n devisor))
        (factors-iter (/ n devisor) devisor (cons devisor acc))
        (factors-iter n (+ devisor 1) acc)))))

(define (factors x)
  (define (factors-iter n divisor acc)
    (cond
      ;; nが1になれば終了：全ての因数を収集済み
      ((= n 1) (reverse acc))
      ;; 除数の二乗が残りの数を超えたら、残りの n は素数
      ((> (* divisor divisor) n) (reverse (cons n acc)))
      ;; 割り切れる場合：その除数を記録し、nをその除数で割る
      ((zero? (remainder n divisor))
       (factors-iter (/ n divisor) divisor (cons divisor acc)))
      (else
       (factors-iter n
                     ;; 除数が2なら次は3、以降は2ずつスキップして奇数のみを調べる
                     (if (= divisor 2) 3 (+ divisor 2))
                     acc))))
  (factors-iter x 2 '()))

;;
(define (sum-tri n)
  (/ 
    (* n (+ n 1)) 
    2))

(define (euler12 n)
  (let loop ((i 8))
      (if (or (> (num-divisors (sum-tri i)) n))
        (list i (sum-tri i))
        (loop (+ i 1)))))


