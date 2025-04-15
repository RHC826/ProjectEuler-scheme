;;;;; Euler Project
;;;; Q.5
;; 2520 は 1 から 10 の数字の全ての整数で割り切れる数字であり, そのような数字の中では最小の値である.
;; では, 1 から 20 までの整数全てで割り切れる数字の中で最小の正の数はいくらになるか.



;;; エントリーポイント
(define (main args)
  (print (multiset-difference '(1 2 3 3) '()))
  (print (fold * 1 (fn 20)))
  ;(print (euler5 (iota 10 1 1)))
  0)

;;; 実装
;;; alist が (factors n) のスーパーセットか確認。違ったら差集合を append をくりかえす
(define (fn max)
  (let ((n 11)) ; 初期値
    (letrec* ((loop (lambda (n result-list)
                      (let ((diff (multiset-difference (factors n) result-list)))
                        (if (<= n max)
                            (loop (+ n 1) (append result-list diff)) ; 再帰的に result-list を更新
                            result-list))) ;; 終了条件で最終の result-list を返す
              ))
      ;; 初期の result-list を計算して loop を開始
      (loop n (factors 2520))))) ;; 最初の result-list を渡してループを開始

;; (multiset-difference '(1 2 3 3) '(3)) => '(1 2 3)
(define (multiset-difference a b)
  (define (remove-once x lst)
    (cond
      ((null? lst) '())
      ((equal? x (car lst)) (cdr lst))
      (else (cons (car lst) (remove-once x (cdr lst))))))

  (define (diff-helper a b)
    (cond
      ((null? a) '())
      (else
       (let ((head (car a)))
         (if (member head b)
            (diff-helper (cdr a) (remove-once head b))
             (cons head (diff-helper (cdr a) b)))))))

  (diff-helper a b))

(define (factors x)
  (let factors-iter ((n x) (devisor 2) (acc '()))
    (if (= n devisor)
      (cons n acc)
      (if (= 0 (remainder n devisor))
        (factors-iter (/ n devisor) devisor (cons devisor acc))
        (factors-iter n (+ devisor 1) acc)))))

