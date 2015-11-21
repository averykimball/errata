;; One layer birds

(define identity-bird
  (lambda (x) x))

(define mockingbird
  (lambda (x) (x x)))

(define omegabird
  (mockingbird mockingbird)) 

;; Two layer birds having no applicator

(define kestrel
  (lambda (x)
    (lambda (y) x)))

(define kite
  (kestrel identity-bird))

(define kite-explicit
  (lambda (x)
    (lambda (y) y)))

;; Two layer birds having one applicator

(define identity-bird-once-removed
  (lambda (x)
    (lambda (y)
      (x y))))

(define thrush
  (lambda (x)
    (lambda (y)
      (y x))))

(define konstant-mocker
  (lambda (x)
    (mockingbird)))

(define konstant-mocker-explicit
  (lambda (x)
    (lambda (y) (y y))))

(define crossed-konstant-mocker
  (lambda (x)
    (lambda (y) (x x))))

;; Two layer birds having two applicators (16 Total)

(define lark
  (lambda (x)
    (lambda (y)
      (x (y y)))))

(define owl
  (lambda (x)
    (lambda (y)
      (y (x y)))))

(define warbler                               ; warbler is also mockingbird-once-removed
  (lambda (x)
    (lambda (y)
      ((x y) y))))

(define crossed-warbler
  (lambda (x)
    (lambda (y)
      ((y x) x))))
