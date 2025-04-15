;;;;; Euler Project
;;;; Q.3


;;; エントリーポイント
(define (main args)
  (print (euler3 600851475143))
  0)

;;; 実装
(define (factors x)
  (let factors-iter ((n x) (devisor 2) (acc '()))
    (if (= n devisor)
      (cons n acc)
      (if (= 0 (remainder n devisor))
        (factors-iter (/ n devisor) devisor (cons devisor acc))
        (factors-iter n (+ devisor 1) acc)))))

(define (euler3 integer)
  (car (factors integer)))

