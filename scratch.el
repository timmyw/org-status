(setq os/test-filename1 "/home/timmy/code/org-status/tests/test1.org")
(os/get-headlines os/test-filename1)

(os/get-all os/test-filename1)

(defun runit (f)
  (funcall f))

(runit (lambda () (print "ASD")))


(setq x 2)
(if (eq x 2)
    (print "smaller")
  (if (> x 1)
      (print "bigger")
    (print "equal")
    )
  )

(setq s "asd")
(when (equal s "asd")
  (print "asd")
  )

(setq ls '(:one 1 :two "two"))
(plist-get ls :one)
(plist-put ls :one (+ 1 (plist-get ls :one)))

(setq lls (list 1 2 3 4))
(mapc (lambda (x) (print x) ) lls)

;;;

(defun rec1 (x acc)
  "Function rec1: dec X and update ACC."
  (when (> x 0)
    (rec1 (- x 1) acc)
    )
  )

(rec1 0 ())

;;;

(defun start-walk (n acc)
  "Start walking a tree headed by N, passing in ACC."
  (let ((v (car n))
        (ls (cdr n)))
    (print (format "[%S] %d" v acc))
    (mapc (lambda (l)
            (print (format "[[%S]]" l))
            (setq nacc (+ acc 1))
            (start-walk l nacc)) ls)
    )
  )

(defun mk-node (x)
  "Create a single node with value X."
  (list x '())
  )

(mk-node 1)

(let (
      (x1 '(:v 1 :c nil))
      (x2 '(:v 2 :c nil))
      (x3 '(:v 3 :c (list x1 x2)))
      (x4 '(:v 4 :c ()))
      (x5 '(:v 5 :c (list x3 x4)))
      )
 
  (print (format "%S" x2))
  (print (format "%S" x5))
  )

;; 
(let ((leaf4 '(4 nil))
      (leaf5 '(5 nil))
      (leaf3 '(3 nil))
      (leaf2 (list 2 'leaf4 leaf5))
      (leaf1 (list 1 leaf2 leaf3))
      )

  ;;(print (format "%S" leaf1))
  (start-walk leaf1 0)
 )

;;;
section -> ignore
headline
  headline
  section
    paragraph

;;; dump all

    (ORG-DATA nil
              (TYPE _section_ (PROPS) (KEYWORD (PROPS)))
              (TYPE _headline_ (PROPS)
                    (TYPE _section_ (PROPS)
                          (TYPE (paragraph) (PROPS) #(CONTENT))
                          (TYPE (paragraph) (PROPS) #(CONTENT))
                          )
                    (TYPE (headline) (PROPS)
                          (TYPE (section) (PROPS)
                                (TYPE _paragraph_ (PROPS) #(CONTENTS))
                                )
                          )
                    )
              )
    ;;;

(set ls #("  First paragraph of heading one, made up of some text\n" 0 55 (:parent (paragraph (:begin 38 :end 94 :contents-begin 38 :contents-end 93 :post-blank 1 ...) #0))))

;;;
(org-data nil
          (section
           (:begin 1 :end 23 :contents-begin 1 :contents-end 22 :post-blank 1 :post-affiliated 1 :parent #0)
           (keyword (:key "TITLE" :value "Test data 1" :begin 1 :end 22 :post-blank 0 :post-affiliated 1 :parent #1))
           )
          (headline ;; Beginning of heading one
           (:raw-value "Heading one" :begin 23 :end 95 :pre-blank 1 :contents-begin 38 :contents-end 94 :level 1 :priority nil :tags nil :todo-keyword nil :todo-type nil :post-blank 1 :footnote-section-p nil :archivedp nil :commentedp nil :post-affiliated 23 :title (#("Heading one" 0 11 (:parent #1))) :parent #0)
           (section
            (:begin 38 :end 62 :contents-begin 38 :contents-end 61 :post-blank 1 :post-affiliated 38 :parent #1)
            (paragraph (:begin 38 :end 61 :contents-begin 38 :contents-end 61 :post-blank 0 :post-affiliated 38 :parent #2) #("  Topic of heading one\n" 0 23 (:parent #3)))
            )
           (headline
            (:raw-value "Sub one" :begin 62 :end 94 :pre-blank 1 :contents-begin 74 :contents-end 94 :level 2 :priority nil :tags nil :todo-keyword nil :todo-type nil :post-blank 0 :footnote-section-p nil :archivedp nil :commentedp nil :post-affiliated 62 :title (#("Sub one" 0 7 (:parent #2))) :parent #1)
            (section
             (:begin 74 :end 95 :contents-begin 74 :contents-end 94 :post-blank 1 :post-affiliated 74 :parent #2)
             (paragraph (:begin 74 :end 94 :contents-begin 74 :contents-end 94 :post-blank 0 :post-affiliated 74 :parent #3) #("   Topic of sub one\n" 0 20 (:parent #4))))
            )
           ) ;; End of heading one

          
          (headline (:raw-value "Heading two" :begin 95 :end 167 :pre-blank 1 :contents-begin 110 :contents-end 166 :level 1 :priority nil :tags nil :todo-keyword nil :todo-type nil :post-blank 1 :footnote-section-p nil :archivedp nil :commentedp nil :post-affiliated 95 :title (#("Heading two" 0 11 (:parent #1))) :parent #0) (section (:begin 110 :end 134 :contents-begin 110 :contents-end 133 :post-blank 1 :post-affiliated 110 :parent #1) (paragraph (:begin 110 :end 133 :contents-begin 110 :contents-end 133 :post-blank 0 :post-affiliated 110 :parent #2) #("  Topic of heading two\n" 0 23 (:parent #3)))) (headline (:raw-value "Sub two" :begin 134 :end 166 :pre-blank 1 :contents-begin 146 :contents-end 166 :level 2 :priority nil :tags nil :todo-keyword nil :todo-type nil :post-blank 0 :footnote-section-p nil :archivedp nil :commentedp nil :post-affiliated 134 :title (#("Sub two" 0 7 (:parent #2))) :parent #1) (section (:begin 146 :end 167 :contents-begin 146 :contents-end 166 :post-blank 1 :post-affiliated 146 :parent #2) (paragraph (:begin 146 :end 166 :contents-begin 146 :contents-end 166 :post-blank 0 :post-affiliated 146 :parent #3) #("   Text for sub two\n" 0 20 (:parent #4))))))
          (headline (:raw-value "Heading three" :begin 167 :end 210 :pre-blank 1 :contents-begin 184 :contents-end 209 :level 1 :priority nil :tags nil :todo-keyword nil :todo-type nil :post-blank 1 :footnote-section-p nil :archivedp nil :commentedp nil :post-affiliated 167 :title (#("Heading three" 0 13 (:parent #1))) :parent #0) (section (:begin 184 :end 210 :contents-begin 184 :contents-end 209 :post-blank 1 :post-affiliated 184 :parent #1) (paragraph (:begin 184 :end 209 :contents-begin 184 :contents-end 209 :post-blank 0 :post-affiliated 184 :parent #2) #("  Topic of heading three\n" 0 25 (:parent #3)))))
          (headline (:raw-value "Heading four" :begin 210 :end 250 :pre-blank 1 :contents-begin 226 :contents-end 250 :level 1 :priority nil :tags nil :todo-keyword nil :todo-type nil :post-blank 0 :footnote-section-p nil :archivedp nil :commentedp nil :post-affiliated 210 :title (#("Heading four" 0 12 (:parent #1))) :parent #0) (section (:begin 226 :end 250 :contents-begin 226 :contents-end 250 :post-blank 0 :post-affiliated 226 :parent #1) (paragraph (:begin 226 :end 250 :contents-begin 226 :contents-end 250 :post-blank 0 :post-affiliated 226 :parent #2) #("  Topic of heading four\n" 0 24 (:parent #3)))))
          )
