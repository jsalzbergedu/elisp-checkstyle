;; -*- lexical-binding: t -*-
;; An emacs wrapper for the csc116 checkstyle program
(require 'output-buffer "~/.emacs.d/output-buffer/output-buffer.el")
(defvar checkstyle-executable nil "The location of the checkstyle script.")

(defun checkstyle-get-ret (path)
  (call-process checkstyle-executable nil nil nil path))

(defun checkstyle-p (path)
  (if (= 0 (checkstyle-get-ret path)) t nil))

(defun checkstyle-curr-p ()
  (checkstyle-p buffer-file-name))

(defvar checkstyle-output-buffer (make-output-buffer "*checkstyle*")
  "The buffer to store the output of checkstyle.")

(defun checkstyle-output-buffer ()
  (get-output-buffer checkstyle-output-buffer))

(defun checkstyle-get-output (path)
  (call-process checkstyle-executable nil (checkstyle-output-buffer) t path))

(defun checkstyle-output-curr ()
  (checkstyle-get-output buffer-file-name))

(defun checkstyle-output-if-bad (path)
  "If checkstyle does not like the file pointed to by PATH, pop up with its errors."
  (unless (checkstyle-curr-p)
    (checkstyle-get-output path)))

(defun checkstyle-output-curr-if-bad ()
  "If checkstyle does not like the current file, pop up with its errors."
  (unless (checkstyle-curr-p)
    (checkstyle-output-curr)))

(provide 'elisp-checkstyle)
