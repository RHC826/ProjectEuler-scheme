;;;;; Euler Project Q.4
;;; 方針
;; - 上から順番に y をデクリメントして最小になったら、x をデクリメントする
;; - 上から順番に走査することで、次のような方法で枝刈りができる
;;   - y をデクリメントして回文数を発見したら、x をデクリメントする。もっと大きい回文数が出てくることは無い
;;   - x * max が仮値より小さければループを終了する。もっと大きい回文数が出てくることは無い

;;; エントリーポイント
(define (main args)
  (display (format "~a~%" (car (max-palindrome-product 999))))
  0)

;;; 実装
;; return : (list product x y)
(define (max-palindrome-product max)
  (let loop ((x max) (y max) (possibly 0) (max-x max) (max-y max))
    (let ((product (* x y)))
      (cond
        ;; 終了条件: x と y が最小値に到達した場合
        ((= x 1) (list possibly max-x max-y))
        ;; 終了条件: x と max の積が仮値より小さい場合
        ((< (* x max) possibly) (list possibly max-x max-y))

        ;; 枝刈り
        ((and (< x max-x) (< y max-y)) ; x,y ともに現在の仮値よりも小さければ、これ以上 y をデクリメントする必要はない
          (loop (- x 1) max possibly max-x max-y))

        ;; 回文数かつ、現在の仮値より大きい場合は更新
        ((and (palindrome? product) (> product possibly))
          (loop (- x 1) max product x y)) ; x をデクリメントして次に進む

        ;; y が最小に達した場合、x をデクリメントし y をリセット
        ((= y 1)
          (loop (- x 1) max possibly max-x max-y))

        ;; それ以外の場合は y をデクリメントして繰り返し
        (else (loop x (- y 1) possibly max-x max-y))))))

;; 回文数判定関数
(define (palindrome? x)
  (cond
    ((number? x) (equal? (string->list (number->string x)) (reverse (string->list (number->string x)))))
    (else #f)))
