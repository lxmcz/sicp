(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
        balance)
      "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  ;; 调用处总是期待一个函数而且无法判断将会传递的参数个数 所以这里使用不定参数
  (define (call-the-cops . args) "call-the-cops")
  ;; 使用一个闭包来设置密码的输入次数(连续错误的次数)
  (define dispatch
    (let ((password-test-count 0))
      (lambda (pwd m)
        (if (eq? pwd password)
            (begin 
              ;; 密码一旦正确就重置password-test-count
              (set! password-test-count 0)
              (cond ((eq? m 'withdraw) withdraw)
                  ((eq? m 'deposit) deposit)
                  (else (error "Unknown request --MAKE-ACCOUNT" m))))
            (begin 
              (set! password-test-count (+ password-test-count 1))
              (if (>= password-test-count 7)
                  call-the-cops
                  (lambda args
                    "Incorrect password")))))))

  dispatch)