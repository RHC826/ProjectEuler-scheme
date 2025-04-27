
;;;;; Euler Project Q.17

#|
url:https://projecteuler.net/problem=17
url:https://odz.sakura.ne.jp/projecteuler/?Problem+17

time:

comment:
絶対面倒くさいので、AIに書かせた。

|#

;;; エントリーポイント
(define (main args)
  (cond 
    ;; テスト
    ; (if (= euler17 [case1]) (display ".") (begin (display "Error!") 1))

    (else 
      (print (euler17))
      0)))

;;; 実装
;; ------------------------------------------------------------
;; 数字→英単語変換（文字のみを連結した文字列を返す）
;; ------------------------------------------------------------

;; 1～9 の名前（空文字を先頭に詰めてインデックス対応）
(define ones
  (list "" "one" "two" "three" "four" "five"
        "six" "seven" "eight" "nine"))

;; 10～19 の名前（10 を先頭に、インデックス＝ 10…19 → 0…9）
(define teens
  (list "ten" "eleven" "twelve" "thirteen" "fourteen"
        "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"))

;; 20,30,…,90 の名前（インデックス＝ 0,1 はダミー）
(define tens-names
  (list "" "" "twenty" "thirty" "forty" "fifty"
        "sixty" "seventy" "eighty" "ninety"))

;; n を受け取って、スペース・ハイフンを含まない英単語文字列を返す
(define (num->word n)
  (cond
    ;; 1000 の特別ケース
    ((= n 1000) "onethousand")

    ;; 100 以上 999 以下
    ((>= n 100)
     (let ((h (quotient n 100))
           (r (remainder n 100)))
       (if (= r 0)
           ;; ちょうど百の倍数
           (string-append (list-ref ones h) "hundred")
           ;; 百以上で余りあり → “hundredand…”
           (string-append (list-ref ones h)
                          "hundredand"
                          (num->word r)))))

    ;; 20 ～ 99
    ((>= n 20)
     (let ((t (quotient n 10))
           (r (remainder n 10)))
       (if (= r 0)
           ;; ちょうど十の倍数
           (list-ref tens-names t)
           ;; 十の倍数＋1～9
           (string-append (list-ref tens-names t)
                          (list-ref ones r)))))

    ;; 10 ～ 19
    ((>= n 10)
     (list-ref teens (- n 10)))

    ;; 1 ～ 9
    ((> n 0)
     (list-ref ones n))

    ;; それ以外（0 以下）は空
    (else
     "")))

;; ------------------------------------------------------------
;; 1～1000 を走査して文字数を合計する
;; ------------------------------------------------------------
(define (euler17)
  (let loop ((i 1) (sum 0))
    (if (> i 1000)
        sum
        (loop (+ i 1)
              (+ sum (string-length (num->word i)))))))

;; 結果の表示
; (display (euler17))
; (newline)

