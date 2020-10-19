(define (make-account balance password)
  (define (withdraw amount)
    (if (>= balance amount)
      (begin (set! balance (- balance amount))
        balance)
      "Insufficient funds"))

  (define (deposit amount)
    (set! balance (+ balance amount))
    balance)

  ;; 在调用方法前 验证密码即可
  (define (dispatch pwd m)
    (if (eq? pwd password)
        (cond ((eq? m 'withdraw) withdraw)
              ((eq? m 'deposit) deposit)
              (else (error "Unknown request --MAKE-ACCOUNT" m)))
        ;; 即使密码错误也应该返回一个函数
        ;; 因为调用处期待返回一个函数 然后应用于某些参数
        ;; 如果直接返回一个函数则会出错
        (lambda args
            "Incorrect password")))
    
  dispatch)