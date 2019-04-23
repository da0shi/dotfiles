; -*- coding: utf-8; lexical-binding: t -*-
;==========BASIC SETUP==========
; User Setting
(setq user-full-name "da0shi")
(setq user-mail-address "whit3.develop@gmail.com")

; set config directory. (for 22 <=)
; use default user-emacs-directory (if 23.1 >=)
(unless (boundp 'user-emacs-directory)
  (defvar user-emacs-directory (expand-file-name "~/.emacs.d/")))

; system-type predicates
(setq
	darwin-p  (eq system-type 'darwin)
	ns-p      (eq window-system 'ns)
	carbon-p  (eq window-system 'mac)
	linux-p   (eq system-type 'gnu/linux)
	cygwin-p  (eq system-type 'cygwin)
	nt-p      (eq system-type 'windows-nt)
	meadow-p  (featurep 'meadow)
	windows-p (or cygwin-p nt-p meadow-p)
	)

;#  Encodings
; set default language
(set-language-environment "Japanese")
; always use utf-8 if it's possible
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8-unix)

(setq locale-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)

;# Font
(set-face-attribute 'default nil
					:family "monaco"
					:height 140)
;(create-fontset-from-ascii-font "Ricty-14:weight=normal:slant=normal" nil "ricty")
;(set-fontset-font "fontset-ricty"
;				  'unicode
;				  (font-spec :family "Ricty" :size 14)
;				  nil
;				  'append)
;(add-to-list 'default-frame-alist '(font . "fontset-ricty"))

; ----- Key Bind -----

; simplify add-hook when using lambda
(defmacro add-hook-fn (name &rest body)
	`(add-hook ,name #'(lambda () ,@body)))
; add multiple element into list
(defmacro append-to-list (to lst)
	`(setq ,to (append ,lst ,to)))
; require when library is located
(defmacro req (lib &rest body)
	`(when (locate-library ,(symbol-name lib))
		(require ',lib) ,@body))
; load lazy
(defmacro lazyload (func lib &rest body)
	`(when (locate-library ,lib)
		,@(mapcar (lambda (f) `(autoload ',f ,lib nil t)) func)
		(eval-after-load ,lib
		 '(progn ,@body))))

;-----global-set-key-----
; set-key for indent-region
(global-set-key "\C-c\C-i" 'indent-region)

; set-key for comment-region (M-; might be better)
(global-set-key "\C-c\C-c" 'comment-region)

; set-key for uncomment-region
(global-set-key "\C-c\C-u" 'uncomment-region)

; set \C-h as BackSpace
(global-set-key "\C-h" 'delete-backward-char)
; use bs-show instead of Buffer List
(global-set-key "\C-x\C-b" 'bs-show)

(global-set-key "\C-x\C-r" 'revert-buffer)

; set key for goto-line
; I use us keyboard for mac so.
(if darwin-p
  (global-set-key (kbd "C-:") 'goto-line)
  (global-set-key (kbd "C-;") 'goto-line)
  )

; set key for insert tab
(global-set-key (kbd "<C-tab>") (kbd "C-q TAB"))

; move to paren
(global-set-key "\M-\[" "\C-\M-p")
(global-set-key "\M-\]" "\C-\M-n")

; change frame
(global-set-key (kbd "C-<") '(lambda ()
				"" (interactive) (other-frame -1)))
(global-set-key (kbd "C->") '(lambda ()
				"" (interactive) (other-frame 1)))

; search keybinding
(global-set-key "\C-x\C-d" 'describe-key)

;-----local key bind-----
(define-key minibuffer-local-completion-map "\C-w" 'backward-kill-word)
; set alt key as meta key (M-*)
(setq mac-option-modifier 'meta)

; ----- View -----

;-----frame setting-----
(append-to-list default-frame-alist
	'(
		'(alpha . (90 30))
		'(foreground-color . "white")
		'(background-color . "gray10")
		'(cursor-color . "cyan")))
;(add-to-list 'default-frame-alist '(alpha . (90 30))) ;騾乗�蠎ｦ(active disactive)
;(add-to-list 'default-frame-alist '(foreground-color . "white")) ;譁�ｭ
;(add-to-list 'default-frame-alist '(background-color . "gray10")) ;閭梧勹
;(add-to-list 'default-frame-alist '(cursor-color . "cyan")) ;繧ｫ繝ｼ繧ｽ繝ｫ
(blink-cursor-mode 0)

;-----show info-----
; show filename on title bar
(setq frame-title-format (format "emacs@%s : %%f" (system-name)))

; stop audio bell
(setq ring-bell-function 'ignore)

; line spacing
(setq-default line-spacing 2)

; don't show startup page
(setq inhibit-startup-message t)

; highlight paren
(show-paren-mode t)
; highlight inside of the paren only when paren out of the frame
(setq show-paren-style 'mixied)

; kill line including "\n"
; when cursor is on line top
(setq kill-whole-line t)

; show column mode
(column-number-mode t)

; hide menu bar when you opened with 'emacs -nw'
(if window-system
	(menu-bar-mode 1)
  (menu-bar-mode -1))

; highlight selected region
(transient-mark-mode t)

; highlight selected line
(global-hl-line-mode)
; highlight to underline
(setq hl-line-face 'underline)

;;-----related to edit------
; enable global-font-lock-mode always
(global-font-lock-mode t)

; show end of the file like vi
(setq-default indicate-empty-lines t)

; do not make backup files
(setq backup-inhibited t)

; set color on space which at end of the line
(setq-default show-trailing-whitespace t)
(set-face-background 'trailing-whitespace "lightgreen")

; number of space for one tab
(setq-default tab-width 4)
(setq tab-width 4)
(setq tab-stop-list
	  '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60))

; change scroll step
(setq scroll-step 3)

;;;-----Buffers-----
;buffer complete
(icomplete-mode t)

; do not kill-buffer at *scratch*
(add-hook-fn 'kill-buffer-query-functions
			(if (string="*scratch*" (buffer-name))
				(progn (erase-buffer) nil)
			  t))

; server setting for emacsclient
(req server
(unless (server-running-p)
  (server-start)))

;==========ELISP SETUP==========
; Load from elisp
(append-to-list load-path
	'(
		"~/.emacs.d/elisp"
		"~/.emacs.d/elpa"))

; package system
(req package
(append-to-list package-archives
	'(
		'("melpa" . "http://melpa.milkbox.net/packages/")
		'("marmalade" . "http://marmalade-repo.org/packages/")))
(package-initialize))

;-----standard elisp-----
; setup for uniquify
(req uniquify
	 (setq uniquify-buffer-name-style 'post-forward-angle-brackets)
	 ; enable uniquify always
	 (setq uniquify-min-dir-content 1))

; switch buffer
(req ido
 (ido-mode 'bffers)
 (setq ido-ignore-buffers '(
							"^ "
							"*Completions*"
							"*Shell Command Output*"
							"*Messages*"
							"Async Shell Command")))

; folding source code
; c
(add-hook-fn 'c-mode-hook
			 (hs-minor-mode 1))
; java
(add-hook-fn 'java-mode-hook
			 (hs-minor-mode 1))
; javascript
(add-hook-fn 'javascript-mode-hook
			 (hs-minor-mode 1))
; lisp
(add-hook-fn 'lisp-mode-hook
			 (hs-minor-mode 1))
; elisp
(add-hook-fn 'emacs-lisp-mode-hook
			 (hs-minor-mode 1))
; define-key
(define-key global-map (kbd "C-]") 'hs-toggle-hiding)

;-----added elisp-----
; setup for "install-elisp"----------
(req install-elisp
	 (setq install-elisp-repository-directory "~/.emacs.d/elisp"))
;; directory to install

; setup for "auto-install"----------
(req auto-install
	 ; directory to install
	 (setq auto-install-directory  "~/.emacs.d/elisp")
	 ; enable auto-install same as install-elisp
	 (auto-install-compatibility-setup))

; setup for "auto-complete"----------
(req auto-complete
	 ; enable auto-complete-mode always
	 (global-auto-complete-mode t)
	 ; use C-n/C-p to select
	 (define-key ac-complete-mode-map "\C-n" 'ac-next)
	 (define-key ac-complete-mode-map "\C-p" 'ac-previous)
	 ; start completion when entered 3 characters
	 (setq ac-auto-start 3))

; ddskk
(req info
	 (setq load-path (cons "~/.emacs.d/elisp/skk" load-path))
	 (when (require 'skk-autoloads nil t)
	   (define-key global-map (kbd "C-x C-j") 'skk-mode)
	   (setq skk-byte-compile-init-file t)
	   )
	 (setq skk-use-color-cursor t)
	 (setq skk-large-jisyo "/usr/share/skk/SKK-JISYO.L")
	 ;(setq skk-server-host "localhost"
	 ;	  skk-server-portnum 1178)
	 (setq skk-kakutei-when-unique-candidate t))


;==========MAJOR MODE SETUP==========
; ShellScript----------
(setq auto-mode-alist (cons '("\\.bash_.+" . shell-script-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.csh_.+" . shell-script-mode) auto-mode-alist))
(setq auto-mode-alist (cons '("\\.zsh_.+" . shell-script-mode) auto-mode-alist))

; C----------
; number of space for one tab in c-mode
(add-hook `c-mode-hook '(lambda()(setq c-basic-offset 4)))

; javascript----------
(autoload 'javascript-mode "javascript" nil t)
(setq auto-mode-alist (cons '("\\.js$" . javascript-mode) auto-mode-alist))

; css----------
(autoload 'css-mode "css-mode" nil t)
(setq auto-mode-alist (cons '("\\.css$" . css-mode) auto-mode-alist))
;(setq cssm-indent-level 4)

; ruby----------
(setq auto-mode-alist (cons '("\\.rb$" . ruby-mode) auto-mode-alist))

; html----------
(setq auto-mode-alist (cons '("\\.ctp$" . php-mode) auto-mode-alist))


;==========CUSTOM SETUP==========
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
