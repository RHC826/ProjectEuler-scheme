;;;;; Euler Project Q.11

#|
url:https://projecteuler.net/problem=11
url:https://odz.sakura.ne.jp/projecteuler/?Problem+11

上の 20×20 の格子のうち, 斜めに並んだ4つの数字が赤くマークされている.

08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48
それらの数字の積は 26 × 63 × 78 × 14 = 1788696 となる.

上の 20×20 の格子のうち, 上下左右斜めのいずれかの方向で連続する4つの数字の積のうち最大のものはいくつか?

;; grid 早見表
;;       0  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15 16 17 18 19 
;; 00.  08 02 22 97 38 15 00 40 00 75 04 05 07 78 52 12 50 77 91 08
;; 20.  49 49 99 40 17 81 18 57 60 87 17 40 98 43 69 48 04 56 62 00
;; 40.  81 49 31 73 55 79 14 29 93 71 40 67 53 88 30 03 49 13 36 65
;; 60.  52 70 95 23 04 60 11 42 69 24 68 56 01 32 56 71 37 02 36 91
;; 80.  22 31 16 71 51 67 63 89 41 92 36 54 22 40 40 28 66 33 13 80
;; 100. 24 47 32 60 99 03 45 02 44 75 33 53 78 36 84 20 35 17 12 50
;; 120. 32 98 81 28 64 23 67 10 26 38 40 67 59 54 70 66 18 38 64 70
;; 140. 67 26 20 68 02 62 12 20 95 63 94 39 63 08 40 91 66 49 94 21
;; 160. 24 55 58 05 66 73 99 26 97 17 78 78 96 83 14 88 34 89 63 72
;; 180. 21 36 23 09 75 00 76 44 20 45 35 14 00 61 33 97 34 31 33 95
;; 200. 78 17 53 28 22 75 31 67 15 94 03 80 04 62 16 14 09 53 56 92
;; 220. 16 39 05 42 96 35 31 47 55 58 88 24 00 17 54 24 36 29 85 57
;; 240. 86 56 00 48 35 71 89 07 05 44 44 37 44 60 21 58 51 54 17 58
;; 260. 19 80 81 68 05 94 47 69 28 73 92 13 86 52 17 77 04 89 55 40
;; 280. 04 52 08 83 97 35 99 16 07 97 57 32 16 26 26 79 33 27 98 66
;; 300. 88 36 68 87 57 62 20 72 03 46 33 67 46 55 12 32 63 93 53 69
;; 320. 04 42 16 73 38 25 39 11 24 94 72 18 08 46 29 32 40 62 76 36
;; 340. 20 69 36 41 72 30 23 88 34 62 99 69 82 67 59 85 74 04 36 16
;; 360. 20 73 35 29 78 31 90 01 74 31 49 71 48 86 81 16 23 57 05 54
;; 380. 01 70 54 71 83 51 54 69 16 92 33 48 61 43 52 01 89 19 67 48

time:
real    0m0.018s
user    0m0.018s
sys     0m0.010s

comment:
- list[][] 的な多重配列がほしい問題。 
- mod を使った方が良いかも
- 左右方向の行替えを伴う計算をしないようにコードを改善しないといけないが、(87 97 94 89) を見つけてしまってモチベーションが死んだ。
|#
;;; エントリーポイント
(define (main args)
  ;(print (re-euler11))
  ;(print (euler11))
  (print (search-grid grid))
  0)

;; グリッドをリストに格納する
(define grid
  (list
    08
    02
    22
    97
    38
    15
    00
    40
    00
    75
    04
    05
    07
    78
    52
    12
    50
    77
    91
    08
    49
    49
    99
    40
    17
    81
    18
    57
    60
    87
    17
    40
    98
    43
    69
    48
    04
    56
    62
    00
    81
    49
    31
    73
    55
    79
    14
    29
    93
    71
    40
    67
    53
    88
    30
    03
    49
    13
    36
    65
    52
    70
    95
    23
    04
    60
    11
    42
    69
    24
    68
    56
    01
    32
    56
    71
    37
    02
    36
    91
    22
    31
    16
    71
    51
    67
    63
    89
    41
    92
    36
    54
    22
    40
    40
    28
    66
    33
    13
    80
    24
    47
    32
    60
    99
    03
    45
    02
    44
    75
    33
    53
    78
    36
    84
    20
    35
    17
    12
    50
    32
    98
    81
    28
    64
    23
    67
    10
    26
    38
    40
    67
    59
    54
    70
    66
    18
    38
    64
    70
    67
    26
    20
    68
    02
    62
    12
    20
    95
    63
    94
    39
    63
    08
    40
    91
    66
    49
    94
    21
    24
    55
    58
    05
    66
    73
    99
    26
    97
    17
    78
    78
    96
    83
    14
    88
    34
    89
    63
    72
    21
    36
    23
    09
    75
    00
    76
    44
    20
    45
    35
    14
    00
    61
    33
    97
    34
    31
    33
    95
    78
    17
    53
    28
    22
    75
    31
    67
    15
    94
    03
    80
    04
    62
    16
    14
    09
    53
    56
    92
    16
    39
    05
    42
    96
    35
    31
    47
    55
    58
    88
    24
    00
    17
    54
    24
    36
    29
    85
    57
    86
    56
    00
    48
    35
    71
    89
    07
    05
    44
    44
    37
    44
    60
    21
    58
    51
    54
    17
    58
    19
    80
    81
    68
    05
    94
    47
    69
    28
    73
    92
    13
    86
    52
    17
    77
    04
    89
    55
    40
    04
    52
    08
    83
    97
    35
    99
    16
    07
    97
    57
    32
    16
    26
    26
    79
    33
    27
    98
    66
    88
    36
    68
    87
    57
    62
    20
    72
    03
    46
    33
    67
    46
    55
    12
    32
    63
    93
    53
    69
    04
    42
    16
    73
    38
    25
    39
    11
    24
    94
    72
    18
    08
    46
    29
    32
    40
    62
    76
    36
    20
    69
    36
    41
    72
    30
    23
    88
    34
    62
    99
    69
    82
    67
    59
    85
    74
    04
    36
    16
    20
    73
    35
    29
    78
    31
    90
    01
    74
    31
    49
    71
    48
    86
    81
    16
    23
    57
    05
    54
    01
    70
    54
    71
    83
    51
    54
    69
    16
    92
    33
    48
    61
    43
    52
    01
    89
    19
    67
    48))

;;; 実装
;; (x, y) 座標を利用できるようした
(define (re-euler11)
  (let loop ((count 0)
             (lst '(0)))
    (if (= 400 count)
      (find-max lst)
      (loop
        (+ count 1)
        (cons (check-around (floor (/ count 20)) (mod count 20)) lst)))))

(define (check-around x y)
  (find-max (map (lambda (x) (find-max (map (lambda (x) (apply * x)) x)))
             (list
               (seek-horizon grid x y)
               (seek-vertical grid x y)
               (seek-vertical-UR grid x y)
               (seek-vertical-BR grid x y)))))

(define (find-max lst)
  (car (sort lst >)))

;; 何行目何個目のような形で値を得る関数
;; column ↓
;; row →
(define (matrix-ref grid column row)
  (cond
    ((or (< column 0) (< row 0))
      1)
    ((or (> column 20) (> row 20))
      1)
    ((>= (+ (* column 20) row) 400)
      1)
    (else (list-ref grid (+ (* column 20) row)))))

(define (seek-horizon grid x y)
  (list
    (map (lambda (offset) (matrix-ref grid x (+ y offset))) (iota 4 0 1))
    (map (lambda (offset) (matrix-ref grid x (- y offset))) (iota 4 0 1))))
(define (seek-vertical grid x y)
  (list
    (map (lambda (offset) (matrix-ref grid (+ x offset) y)) (iota 4 0 1))
    (map (lambda (offset) (matrix-ref grid (- x offset) y)) (iota 4 0 1))))
(define (seek-vertical-BR grid x y)
  (list
    (map (lambda (offset) (matrix-ref grid (+ x offset) (+ y offset))) (iota 4 0 1))
    (map (lambda (offset) (matrix-ref grid (- x offset) (- y offset))) (iota 4 0 1))))
;;
(define (seek-vertical-UR grid x y) ; ➚
  (list
    (map (lambda (offset) (matrix-ref grid (+ x offset) (- y offset))) (iota 4 0 1))
    (map (lambda (offset) (matrix-ref grid (- x offset) (+ y offset))) (iota 4 0 1))))

;;
(define (euler11)
  (list-ref
    (sort
      (list
        (seek calc)
        (seek calc2)
        (seek calc3)
        (seek calc4)
        (seek calc5)
        (seek calc6)
        (seek calc7)
        (seek calc8))
      >)
    0))

;; 計算する関数
(define (seek calc-proc)
  (let ((goal 400))
    (let loop ((start 0) (max 0))
      (if (>= start goal)
        max
        (let ((result (calc-proc start)))
          (if (> result max)
            (loop (+ start 1) result)
            (loop (+ start 1) max)))))))

;; 八方向・八関数。
;; なんか実装途中で答えを見つけてしまって萎えている
;;
(define (calc start) ;  ↘
  (let ((grid-pos (iota 4 start 21)))
    (apply * (map (lambda (x) (list-ref-sp grid x)) grid-pos))))

(define (calc2 start) ;  ↙
  (let ((grid-pos (iota 4 start -21)))
    (apply * (map (lambda (x) (list-ref-sp grid x)) grid-pos))))

(define (calc3 start) ;  ↖
  (let ((grid-pos (iota 4 start -16)))
    (apply * (map (lambda (x) (list-ref-sp grid x)) grid-pos))))

(define (calc4 start) ;  ↗
  (let ((grid-pos (iota 4 start -19)))
    (apply * (map (lambda (x) (list-ref-sp grid x)) grid-pos))))

(define (calc5 start) ; ←
  (let ((grid-pos (iota 4 start -1)))
    (apply * (map (lambda (x) (list-ref-sp grid x)) grid-pos))))

(define (calc6 start) ; →
  (let ((grid-pos (iota 4 start 1)))
    (apply * (map (lambda (x) (list-ref-sp grid x)) grid-pos))))

(define (calc7 start) ; ↓
  (let ((grid-pos (iota 4 start 20)))
    (apply * (map (lambda (x) (list-ref-sp grid x)) grid-pos))))

(define (calc8 start) ; ↑
  (let ((grid-pos (iota 4 start -20)))
    (apply * (map (lambda (x) (list-ref-sp grid x)) grid-pos))))

;; 治具
;; グリッドの外を参照しようとしたら 0 を返すやつ
;; 4 つ続かない場所は 0 にして max を更新しないようにする
(define (list-ref-sp grid x)
  (if (<= 0 x (- 400 1))
    (list-ref grid x)
    0))

;; 整理したもの
(define (search-grid grid)
  (define directions
    '((0 1) (0 -1) ; →
      (1 0) ; ↓
      (-1 0)
      (1 1) ; ↘
      (-1 -1)
      (1 -1) ; ↗
      (-1 1)))

  (define (max-product-at x y)
    (apply max
      (map (lambda (dir)
            (apply * (seek-direction grid x y (car dir) (cadr dir))))
        directions)))

  (define (iter index max-prod)
    (if (= index 400)
      max-prod
      (let* ((xy (index->xy index))
             (x (car xy))
             (y (cdr xy))
             (prod (max-product-at x y)))
        (iter (+ index 1) (max prod max-prod)))))

  (iter 0 0))

(define (seek-direction grid x y dx dy)
  (map (lambda (offset)
        (matrix-ref grid (+ x (* offset dx)) (+ y (* offset dy))))
    (iota 4)))

(define (seek-all-directions grid x y)
  (list
    ;; →  and ←
    (seek-direction grid x y 0 1)
    (seek-direction grid x y 0 -1)

    ;; ↓  and ↑
    (seek-direction grid x y 1 0)
    (seek-direction grid x y -1 0)

    ;; ↘ and ↖
    (seek-direction grid x y 1 1)
    (seek-direction grid x y -1 -1)

    ;; ↗ and ↙
    (seek-direction grid x y 1 -1)
    (seek-direction grid x y -1 1)))

(define (index->xy index)
  (cons (quotient index 20) (remainder index 20)))

(define (valid-index? x y)
  (and (<= 0 x 19) (<= 0 y 19)))

(define (matrix-ref grid x y)
  (if (valid-index? x y)
    (list-ref grid (+ (* x 20) y))
    0)) ; 範囲外は 0 に
