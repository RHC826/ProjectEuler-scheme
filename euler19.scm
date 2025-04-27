;;;;; Euler Project Q.19

#|
url:https://projecteuler.net/problem=19
url:https://odz.sakura.ne.jp/projecteuler/?Problem+19

次の情報が与えられている.

1900年1月1日は月曜日である.
9月, 4月, 6月, 11月は30日まであり, 2月を除く他の月は31日まである.
2月は28日まであるが, うるう年のときは29日である.
うるう年は西暦が4で割り切れる年に起こる. しかし, 西暦が400で割り切れず100で割り切れる年はうるう年でない.
20世紀（1901年1月1日から2000年12月31日）中に月の初めが日曜日になるのは何回あるか?

time:

comment:

- 曜日は最初の日からの累計日数をmod 7 で求まる
- 累計日数は （+ 世紀の初めからその年までの累積日数 正月からその日までの累積日数)
- 候補日は (* 100[year] 12[month])
|#

;;; エントリーポイント
(define (main args)
  (cond 
    ;; テスト
    ; (if (= euler19 [case1]) (display ".") (begin (display "Error!") 1))
    ((not (equal? (day->planet (prog-days 1900 1 1)) "Mo.") )
        (error "day->planet Error!"))
    ((not (eqv? (prog-days 1900 3 1) 60))
        (error "prog-days Error!"))
    ((not (equal? (day->planet (prog-days 1901 1 1)) "Mo.") )
        (error "day->planet Error!"))

    (else 
      (print (format "~a\n~a\n~a" 
                     (iota 10 1 1)
                     (map prog-years (iota 10 1900 1))
                     (map day->planet (map prog-years (iota 10 1900 1)))))
      (print (length (generate-dates)))
      ;; 回答。正解は171のはず...
      (print (euler19))

      0)))
;;; 実装
(define (euler19)
  (length 
    (filter (lambda (x) (equal? x "Su."))
            (map day->planet 
                 (map cumulative-days
                      (generate-dates))))))

;; うるう年判定
(define (leap? year)
  (cond
    ((and (not (zero? (mod year 400)))
          (zero? (mod year 100))) #f)
    ((zero? (mod year 4)) #t)
    (else #f)))

;; その月の日数を求める
;; - 9月, 4月, 6月, 11月は30日まであり, 2月を除く他の月は31日まである.
;; - 2月は28日まであるが, うるう年のときは29日である.
(define (month->day year month)
  (cond
    ((and (= month 2) (leap? year)) 29)
    ((= month 2) 28)
    ((or (= month 4) (= month 6) (= month 9) (= month 11)) 30)
    (else 31)))
  
;; 累積日数
;; date-object: 
;; 0: year
;; 1: month
;; 2: day
(define (cumulative-days date-object)
  ;; 世紀の初めから今年までの日数 + 年の初めから今日までの日数
  (+ (prog-years (list-ref date-object 0)) 
     (prog-days (list-ref date-object 0) (list-ref date-object 1) (list-ref date-object 2))))

;; その世紀の最初の日から year の1/1までの日数を求める
(define (prog-years year)
  (-
    (apply + (map (lambda (year) (if (leap? year) 366 365)) twenty-century))
    (apply + (map (lambda (year) (if (leap? year) 366 365)) (nokori-nensu year)))))

;; その年の最初の日からの日数を求める
;; (define (prog-days year month day)
;;   (unless 
;;     (or
;;       (<= 1 day 31) ; 本当は月も見たほうが良い
;;       (<= 1 month 12) 
;;       (<= 1901 year 2000))
;;     (error "Date Error!"))
;;   (+
;;     ;; 元日から month 月までの総日数
;;     (- 
;;       (apply + (map (lambda (x) (month->day year x)) (iota 12 1 1))) ; うるう年を考慮した year 年の総日数
;;       (apply + (take (reverse (map (lambda (x) (month->day year x)) (iota 12 1 1))) (- 13 month) ; 
;;                      )) ; うるう年を考慮したこの月までの総日数
;;       ) 
;;     ;; month 月の日数
;;     day))

; うるう年を考慮した正月からこの月までの総日数
(define (days-before-month year month)
  (apply + (map (lambda (m) (month->day year m))
                (iota (- month 1) 1))))

(define (prog-days year month day)
  (+ (days-before-month year month) 
     (- day 0)))

;; 曜日を求める
(define (day->planet n)
  (let ((days-of-week (mod n 7)))
    (cond
      ((= days-of-week 1) "Mo.")
      ((= days-of-week 2) "Tu.")
      ((= days-of-week 3) "We.")
      ((= days-of-week 4) "Th.")
      ((= days-of-week 5) "Fr.")
      ((= days-of-week 6) "Sa.")
      ((= days-of-week 0) "Su.")
      (else (error "you reach unreachable section")))))
  
;; データ
(define twenty-century (iota 100 1901 1))

(define leap-years (filter leap? twenty-century))

;; (1901 1 1), (1900 2 1) ... (2000 12 1)
(define (generate-dates)
  (apply append
         (map (lambda (year)
                (map (lambda (month)
                       (list year month 1))
                     (iota 12 1)))  ;; 1〜12月
              (iota 100 1901))))  ;; 1901〜2000年

;;
(define (nokori-nensu year)
  (iota (- 2001 year) 1900 1))

