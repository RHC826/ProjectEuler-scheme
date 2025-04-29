;; モジュールのインタフェースの定義
(define-module euler-libs
  ;; export
  (export
    leap?))
(select-module euler-libs)

;; うるう年か調べる関数
(define (leap? year)
  (cond
    ((and (zero? (mod year 400))
        (zero? (mod year 100)))
      #f)
    ((zero? (mod year 4)) #t)
    (else #f)))

(provide "euler-libs")
