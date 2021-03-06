;; This is where your customizations should live

;; env PATH
(defun set-exec-path-from-shell-PATH ()
  (let ((path-from-shell (shell-command-to-string "$SHELL -i -c 'echo $PATH'")))
    (setenv "PATH" path-from-shell)
    (setq exec-path (split-string path-from-shell path-separator))))

;; Uncomment the lines below by removing semicolons and play with the
;; values in order to set the width (in characters wide) and height
;; (in lines high) Emacs will have whenever you start it

;; (setq initial-frame-alist '((top . 0) (left . 0) (width . 20) (height . 20)))

;; Place downloaded elisp files in this directory. You'll then be able
;; to load them.
;;
;; For example, if you download yaml-mode.el to ~/.emacs.d/vendor,
;; then you can add the following code to this file:
;;
;; (require 'yaml-mode)
;; (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
;;
;; Adding this code will make Emacs enter yaml mode whenever you open
;; a .yml file
(add-to-list 'load-path "~/.emacs.d/vendor")

;; shell scripts
(setq-default sh-basic-offset 2)
(setq-default sh-indentation 2)

;; Themes
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(add-to-list 'load-path "~/.emacs.d/themes")
(load-theme 'zenburn t)

;; Flyspell often slows down editing so it's turned off
(remove-hook 'text-mode-hook 'turn-on-flyspell)

(load "~/.emacs.d/vendor/clojure")

;; hippie expand - don't try to complete with file names
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name hippie-expand-try-functions-list))
(setq hippie-expand-try-functions-list (delete 'try-complete-file-name-partially hippie-expand-try-functions-list))

(setq ido-use-filename-at-point nil)

;; Save here instead of littering current directory with emacs backup files
(setq backup-directory-alist `(("." . "~/.saves")))

;; customs
(setq c-hungry-delete-key t)

;; line numbers
(global-linum-mode t)
(setq linum-format "%d ")

;; file extentions -> mode
(add-to-list 'auto-mode-alist '("\\.cft$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.template$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.html.erb$" . rhtml-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))
(add-to-list 'auto-mode-alist '("\\.tf$" . hcl-mode))

;; custom colors
(set-face-background 'show-paren-match-face "#593A58")
(set-face-background 'region "#424951") ; Set region background color

;; recent mode
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

(defun recentf-ido-find-file ()
  "Find a recent file using ido."
  (interactive)
  (let ((file (ido-completing-read "Choose recent file: " recentf-list nil t)))
    (when file
      (find-file file))))
(global-set-key (kbd "C-x f") 'recentf-ido-find-file)

;; don't close dat
(global-unset-key (kbd "C-z"))

;; clean up!
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(require 'yasnippet)
    (yas-global-mode 1)

(setq-default truncate-lines t)
(delete-selection-mode 1) ;; :-(

;; insanity wolf
(require 'no-easy-keys)
(no-easy-keys 1)

;; go-mode tab display
(add-hook 'go-mode-hook
          (lambda ()
            (setq-default)
            (setq tab-width 4)
            (setq standard-indent 4)
            ))

;; css indent
(setq css-indent-offset 2)

;; go-mode paredit
(add-hook 'go-mode-hook 'esk-paredit-nonlisp)
(add-hook 'before-save-hook 'gofmt-before-save)

;; ruby not funky indenting
(setq ruby-deep-indent-paren nil)

;; js2-mode && javascript mode indents
(setq-default js2-basic-offset 2)
(setq js2-deep-indent-paren nil)
(setq-default js-indent-level 2)
(setq-default javascript-basic-offset 2)
(setq javascript-deep-indent-paren nil)

;;
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
  (setq interprogram-paste-function 'copy-from-osx)
