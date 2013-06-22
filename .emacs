(require 'cl)
(global-font-lock-mode 1)

;;; Global settings
;disable auto save
(setq auto-save-default nil)
;turn tabs into spaces
(setq-default indent-tabs-mode nil)
;saving backup files to a specific directory
(setq
 backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist
    '(("." . "~/.emacs.d/backups/"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups
(message "Deleting old backup files...")
(let ((week (* 60 60 24 7))
      (current (float-time (current-time))))
  (dolist (file (directory-files temporary-file-directory t))
    (when (and (backup-file-name-p file)
               (> (- current (float-time (fifth (file-attributes file))))
                  week))
      (message "%s" file)
      (delete-file file))))
;enable line and column numbering
(line-number-mode 1)
(column-number-mode 1)
;load defuns
(add-to-list 'load-path "~/.emacs.d/")
(load "myfun.el")

;;; Modes

;; Go into proper mode according to file extension
(setq auto-mode-alist
      (append '(("\\.C$"    . c++-mode)
		("\\.cc$"   . c++-mode)
		("\\.cpp$"  . c++-mode)
		("\\.cxx$"  . c++-mode)
		("\\.hxx$"  . c++-mode)
		("\\.hpp$"  . c++-mode)
		("\\.h$"    . c++-mode)
		("\\.hh$"   . c++-mode)
		("\\.idl$"  . c++-mode)
		("\\.ipp$"  . c++-mode)
		("\\.c$"    . c-mode)
		("\\.pl$"   . perl-mode)
		("\\.pm$"   . perl-mode)
		("\\.java$" . java-mode)
		("\\.md$"   . markdown-mode)
		("\\.yml$"  . yaml-mode)
		("\\.yaml$" . yaml-mode)
                ("CMakeLists\\.txt" . cmake-mode)
                ("\\.cmake$" . cmake-mode))
              auto-mode-alist))


;; Auto complete configs
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

;; C/C++ mode hooks
; GOOGLE c style
(require 'google-c-style)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)
;homemade help functions
(add-hook 'c-mode-common-hook '(lambda () (define-key c-mode-map (kbd "C-c s") 'cpp-make-region-string)))
(add-hook 'c-mode-common-hook '(lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

;; ediff mode
; split the window depending on the frame width in ediff mode
(setq ediff-split-window-function (if (> (frame-width) 150)
				      'split-window-horizontally
				    'split-window-vertically))
; restore window configuration after quit
(add-hook 'ediff-load-hook
	  (lambda ()
	    (add-hook 'ediff-before-setup-hook
		      (lambda ()
			(setq ediff-saved-window-configuration (current-window-configuration))))

	    (let ((restore-window-configuration
		   (lambda ()
		     (set-window-configuration ediff-saved-window-configuration))))
	      (add-hook 'ediff-quit-hook restore-window-configuration 'append)
	      (add-hook 'ediff-suspend-hook restore-window-configuration 'append))))

; from command line, Usage: emacs -diff file1 file2
(defun command-line-diff (switch)
  (let ((file1 (pop command-line-args-left))
	(file2 (pop command-line-args-left)))
    (ediff file1 file2)))

(add-to-list 'command-switch-alist '("-diff" . command-line-diff))

;; shell mode
(setq ansi-color-names-vector ; better contrast colors
      ["black" "red4" "green4" "yellow4"
       "blue3" "magenta4" "cyan4" "white"])
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-hook 'shell-mode-hook
     '(lambda () (toggle-truncate-lines 1)))
(setq comint-prompt-read-only t)

;; markdown mode
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)

;; yaml mode
(require 'yaml-mode)
; have return key automatically indent cursor on new line
(add-hook 'yaml-mode-hook '(lambda () (define-key yaml-mode-map (kbd "C-m") 'newline-and-indent)))

;; CMAKE mode
(require 'cmake-mode)

;; Magit mode
(add-to-list 'load-path "~/.emacs.d/magit-1.2.0")
(require 'magit)
(global-set-key (kbd "C-c m") 'magit-status)

;; python mode
(add-to-list 'load-path "~/.emacs.d/python-mode.el-6.1.1/")
(autoload 'python-mode "python-mode" "Python Mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-hook 'python-mode-hook '(lambda () (add-to-list 'write-file-functions 'delete-trailing-whitespace)))

;; pymacs
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)
(autoload 'pymacs-autoload "pymacs")
;;(eval-after-load "pymacs"
;;  '(add-to-list 'pymacs-load-path YOUR-PYMACS-DIRECTORY"))

;; emacs-for-python
(add-to-list 'load-path "~/.emacs.d/epy/") ;; tell where to load the various files
(require 'epy-setup)      ;; It will setup other loads, it is required!
(require 'epy-python)     ;; If you want the python facilities [optional]
(require 'epy-completion) ;; If you want the autocompletion settings [optional]
(require 'epy-editing)    ;; For configurations related to editing [optional]
