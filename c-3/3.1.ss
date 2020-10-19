;; make-accumulator返回的是一个函数
;; 题中给出每个累加器都要维护独立的和
;; 既每个函数都一个是一个独立的闭包
;; 所以需要一个额外的函数(_G)来生成不同的闭包
(define (make-accumulator init)
  ;; _G在每次调用make-accumulator时辅助生成闭包 
  ;; 这样就可以保证每个闭包引用的res是不同的
  (define (_G)
    ;; 返回的闭包函数
    (let ((res init))
      (lambda (n)
        (set! res (+ res n))
        res)))

  (_G))
