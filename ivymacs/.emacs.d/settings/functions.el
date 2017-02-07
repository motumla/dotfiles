
(defun open-file-in-new-buffer (filename)
  "Opens a file in a new buffer"
  (interactive)
  (switch-to-buffer (find-file-noselect filename)))

(defun open-config ()
  "Opens the init.el file"
  (interactive)
  (open-file-in-new-buffer "~/.emacs.d/init.el"))

(defun rename-current-buffer-file ()
  "Renames current buffer and file it is visiting."
  (interactive)
  (let ((name (buffer-name))
        (filename (buffer-file-name)))
    (if (not (and filename (file-exists-p filename)))
        (error "Buffer '%s' is not visiting a file!" name)
      (let ((new-name (read-file-name "New name: " filename)))
        (if (get-buffer new-name)
            (error "A buffer named '%s' already exists!" new-name)
          (rename-file filename new-name 1)
          (rename-buffer new-name)
          (set-visited-file-name new-name)
          (set-buffer-modified-p nil)
          (message "File '%s' successfully renamed to '%s'"
                   name (file-name-nondirectory new-name)))))))

(defmacro define-align-by (name char)
  (let ((func (intern (concat "align-by-" name)))
        (doc (format "Align by %s" char)))
    `(defun ,func (beg end) ,doc 
            (interactive "r")
            (align-regexp beg end ,(concat "\\(\\s-*\\) " char) 1 1))))

(defmacro define-aligns (aligns)
  `(progn ,@(mapcar
             (lambda (a) `(define-align-by ,(car a) ,(cdr a)))
             aligns)))

(define-aligns
  (("="      . "=")
   ("single" . "'")
   ("dot"    . "\\.")))

(provide  'functions)
