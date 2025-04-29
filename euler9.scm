;;;;; Euler Project Q.9

#|
url:https://odz.sakura.ne.jp/projecteuler/?Problem+9
real    0m0.047s
user    0m0.067s
sys     0m0.005s
|#

;;; エントリーポイント
(define (main args)
  (display (Euler9 1000))
  0)

;;; 実装
;; ピタゴラス数か確認
(define (Pythagoras? a b c)
  (cond
    ((not (< a b c)) #f)
    ((=
        (* c c)
        (+
          (* a a)
          (* b b)))
      #t)
    (else #f)))

;; List up: a + b + c = 1000 AND (< a b c)
(define (abc-triplets-sum target)
  (let loop-a ((a 1) (results '()))
    (if (>= a (- target 2))
      (reverse results)
      (let loop-b ((b (+ a 1)) (results results))
        (if (>= b (- target a 1))
          (loop-a (+ a 1) results)
          (let* ((c (- target a b)))
            (if (and (> c b))
              (loop-b (+ b 1) (cons (list a b c) results))
              (loop-b (+ b 1) results))))))))

(define (abc-triplets-sum target)
  (let loop-a ((a 1) (results '()))
    (if (>= a (- target 2)) ; ?
      (reverse results)
      (let loop-b ((b (+ a 1)) (results results))
        (if (>= b (- target a 1))
          (loop-a (+ a 1) results)
          (let ((c (- target a b)))
            (if (> c b)
              (loop-b (+ b 1) (cons (list a b c) results))
              (loop-b (+ b 1) results))))))))

;; filter
;; exp. (200 375 425)
(define (seek x)
  (let ((pythagoras (car
                     (filter (lambda (x) (Pythagoras? (list-ref x 0) (list-ref x 1) (list-ref x 2)))
                       (abc-triplets-sum x)))))
    pythagoras))

(define (Euler9 x)
  (apply * (seek x)))
