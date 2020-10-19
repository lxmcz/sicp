(define (make-monitored f)
  (let ((call-count 0))
    (lambda args
      (if (= 0 (length args))
          (begin
            (set! call-count (+ 1 call-count))
            (f))
          (let ((first-arg (car args)))
            (cond ((eq? first-arg 'how-many-calls?) call-count)
                  ((eq? first-arg 'reset-count) (set! call-count 0) 0)
                  (else (set! call-count (+ 1 call-count))
                        (apply f args))))))))

;; 测试套件
(define my-car (make-monitored car))
(define test-list '(1 2 3))
(define (dothis) (my-car test-list))
(define $$ 'how-many-calls?)
(define $_ 'reset-count)