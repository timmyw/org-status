;;; package --- Summary
;;; Provides a list of all updates in the last week
;;;
;;; Commentary:

;;; Code:

(defvar os/test-filename1 "/home/timmy/code/org-status/tests/test1.org")

(defun os/get-headlines (file-name)
  "Get all headlines and text for FILE-NAME."
  ;; (progn
    (let ((headings nil))
      ;; (print file-name)
      (with-temp-buffer
        (insert-file-contents file-name)
        (goto-char (point-min))
        (org-element-map (org-element-parse-buffer) 'headline
          (lambda (headline)
            (let ((h (car (cdr headline))))
              (add-to-list 'headings h)
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
