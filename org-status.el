;;; package --- Summary
;;; Provides a list of all updates in the last week
;;;
;;; Commentary:

;;; Code:

(defvar os/test-filename1 "/home/timmy/code/org-status/tests/test1.org")
(defvar os/test-filename2 "/home/timmy/code/org-status/tests/test2.org")

(defun os/with-file-run (file-name f)
  "Run the supplied function F over FILE-NAME."
  (with-temp-buffer
    (insert-file-contents file-name)
    (goto-char (point-min))
    (funcall f))
  )

(defvar os/element-types '(item))

(defun os/dump (file-name)
  "Dump the org structure for the contents of FILE-NAME."
  (os/with-file-run file-name
                    (lambda ()
                      (print (org-element-parse-buffer))
                      )
                    )
  )

;; Test:
;; (os/dump os/test-filename2)

(defun os/walk-struct-node (nodes accum)
  "Walk an org struct starting at NODE and update ACCUM"
  (progn
    (setq indent (plist-get accum :indent))
    (print (format "%sNumber of nodes: %d" indent (length node)))
    (mapc (lambda (node)
            ;; (TYPE (PROPS) ELEM1 ELEM2 ...)
            (let ((type (car node))
                  (props (nth 1 node))
                  (elements (cdr (cdr node)))
                  (cur-accum nil))
              (setq cur-accum (plist-get accum :headings))
              (print (format "%sTYPE:%s" indent type))
              (print (format "%sELEMS len:%d" indent (length elements)))

              ;; Add to the current headings list, and increment level
              ;; version, then recurse down into any children (in
              ;; ELEMENTS)
              (setq accum (plist-put accum :headings (append (list type) cur-accum)))
              (setq accum (plist-put accum :curlevel (+ 1 (plist-get accum :curlevel))))
              (setq accum (plist-put accum :indent (concat ".." (plist-get accum :indent))))
              (os/walk-struct-node elements accum)
              (print (format "%sPOST children:%d" indent (length elements)))
              )
          
            ) nodes))
  accum
  )


(defvar os/node-types '(section headline))
(defvar os/content-types '(paragraph))

(defun os/walk-node (nodes accum headings level)
  "Walk from NODE updating ACCUM."
  (mapc (lambda (node)
          (let ((type (car node))
                (props (nth 1 node))
                (elements (cdr (cdr node)))
                )
            (print (format "%d TYPE:%S" level type headings))
            (print (format "ELEMENTS:%d" (length elements)))

            ;; Only recurse if we have an appropriate type.  So far,
            ;; section and headline are appropriate.
            (when (member type os/content-types)
              ;; Store the text - which will be in ELEMENTS
              (let ((content (substring-no-properties (car elements))))

                ;; Dump this to our global list, along with current
                ;; headline
                (print (format "CONTENT:%S" content))
                )
              )

            (when (member type  os/node-types)
              ;; Store the text (for types like headline)
              (progn
                (os/walk-node elements accum (os/add-headline headings type props) (+ 1 level))
                )
              
              )
            )
          )
        nodes
        )
        
  )

;; Test
(os/with-file-run os/test-filename2
                  (lambda ()
                    (os/walk-struct (org-element-parse-buffer))
                    )
                  )

(defun os/add-headline (headline type props)
  "Append the new HEADLINE (with separator) if TYPE is headline."
  (cond ((eq type 'headline)
         (let ((new-head (plist-get props :raw-value)))
           (concat headline new-head "|")
          ))
        (t headline))
  )

;; Test
(os/add-headline "" 'headline '(:raw-value "ABC"))

(defun os/walk-struct (node)
  "Start the walk of an org struct NODE"
  (let ((accum '(:headings () :curlevel 0 :indent ""))
        (node-type (car node))
        (node-body (cdr (cdr node))))   ; dumps first two elements of
                                        ; the list
    
    ;; (print (format "HEAD node type:%s" node-type))
    ;; (print (format "node body length :%d" (length node-body)))
    (when (eq node-type 'org-data)
      ;; BODY accum HEADINGS LEVEL
      (os/walk-node node-body accum "" 0))
    )
  )

(defun os/get-all (file-name)
  "Get all headlines and text for FILE-NAME."
  (os/with-file-run file-name
                    (lambda ()
                      (org-element-map (org-element-parse-buffer) os/element-types
                        (lambda (obj)
                          (print obj)
                          )
                        )
                      )
                    )
  )

(setq os/test-filename1 "/home/timmy/code/org-status/tests/test1.org")
(os/get-headlines os/test-filename1)

(setq os/element-types '(section))
(os/get-all os/test-filename1)
/
(defun os/get-headlines (file-name)
  "Get all headlines and text for FILE-NAME."
  ;; (progn
  (let ((headings nil)
        (crumbs nil)
        (last-level 0))
      ;; (print file-name)
      (with-temp-buffer
        (insert-file-contents file-name)
        (goto-char (point-min))
        (org-element-map (org-element-parse-buffer) 'object
          (lambda (element-object)
            (let ((element (car (cdr element-object))))
              (when (equal 'headline 
              )
            (let ((h (car (cdr headline)))
                  (cur-level (plist-get h :level))
                  (heading (plist-get h :raw-value))
              (if (< last-level cur-level)
                  (progn
                    (setq last-level cur-level)
                    (setq crumbs () ;; Moved down a level
                ())
              (add-to-list 'headings h)
              (print h)
              (print (plist-get h :raw-value))
              )
            )
          )
        )
      headings
      )
    ;; )
  )

(defun os/match-date (date entry)
  "Check if the supplied ENTRY has a matching DATE entry.".
  t
  )

(defun os/run ()
  "Run the org-status."
  (interactive)
  (progn
    (defvar file-name "" "File name")
    (setq file-name "/home/timmy/ravelin/tech.org")
    (os-get-headlines file-name)
    ))

;;; Testing
(setq os/test-filename1 "/home/timmy/code/org-status/tests/test1.org")
(os/get-headlines os/test-filename1)

(headline
 (:raw-value "Heading four" :begin 94 :end 109 :pre-blank 0 :contents-begin nil :contents-end nil ...)
 )

;;;


(provide 'org-status)

;;; org-status.el ends here
