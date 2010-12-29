
;; 環境における設定

;;; Code:

;; 環境変数
(require 'init_setenv)
;; フレームサイズ、色、フォントの設定
(require 'init_style)
;; tramp
(require 'init_tramp)
;; search
(require 'init_search)
;; cperl-mode
(require 'init_cperl)
;; moccur
(require 'init_mymoccur)
;;; SKK
(require 'init_myskk)
;; htmlhelperの設定
(require 'init_myhtml)
;; javascript-mode
(require 'init_myjavascript)
;;; mmm-mode
(require 'init_mymmm)

;; sql-mode
;(require 'init_mysql)
;; html-helper-mode
;(require 'init_yahtml)
;; howm-mode
;(require 'init_myhowm)

;; shell、eshell 関連
(require 'init_shell)
;; css-modeの設定
;(require 'init_css)

;; Lisp
(require 'init_lisp)
;; キー設定
(require 'init_key)

;; anything
; (require 'init_anything)
;-- ;; 独自関数
;-- (require 'init_function)
;-- ;; rst-mode
;-- (require 'init_rst)
;-- ;; smartchr
;-- (require 'init_smartchr)
;-- ;;; Elscreen
;-- (require 'init_elscreen)
;-- ;; session
;-- (require 'init_session)
;-- ;; dired
;-- (require 'init_dired)
;-- ;; auto-complete
;-- (require 'init_ac)
;-- ;; eldoc
;-- ; (require 'init_eldoc)
;-- 
;-- ;;; プログラミング関連
;-- (require 'init_flymake)
;-- ;;; Pythonの設定
;-- ;; (require 'init_python)
;-- ;; vsc and scm
;-- (require 'init_scm)
;-- ;; diff
;-- (require 'init_diff)
;-- ;;;; mode-info
;-- (require 'init_modeinfo)
;-- ;;; Gaucheの設定
;-- (require 'init_gauche)
;-- ;;; OCaml
;-- (require 'init_ocaml)
;-- ;;; JDEE
;-- ;(require 'init_jdee)
;-- ;;; smart-compie
;-- (require 'init_smartcompile)
;-- ;; c
;-- (require 'init_c)
;-- ;; objc
;-- (when mac-p
;--   (require 'init_objc))
;-- ;; yasnippet
;-- (require 'init_yasnippet)
;-- ;;; 文書記述関連
;-- ;; auto-insert
;-- ;(require 'init_autoinsert)
;-- ;; htmlize
;-- ;; @see http://fly.srk.fer.hr/~hniksic/emacs/
;-- (require 'htmlize)
;-- ;; howm
;-- ;; (require 'init_howm)
;-- ;; sdicの設定
;-- ;;(require 'init_sdic)
;-- ;; Dictionary.app 呼びだし
;-- ; (require 'init_adic)
;-- ; (define-key global-map "\C-cw" 'ite-dict-func)
;-- ;; AUC TeX
;-- ;; (require 'init_auctex)
;-- ;;; nxml-mode
;-- ;; @http://www.thaiopensource.com/download/
;-- ; (require 'init_nxml)
;-- ;; scala-mode
;-- ; (require 'init_scala)
;-- ;; haskel-mode
;-- ; (require 'init_haskell)
;-- ;; php-mode
;-- ; (require 'init_php)
;-- 
;-- (autoload 'po-mode "po-mode" "Major mode for translators when they edit PO files." t)
;-- (eval-after-load 'po-mode '(load "gb-po-mode"))
;-- 
;-- ;; w3m
;-- ; (require 'init_w3m)
;-- 
;-- (require 'init_speedbar)
;-- 
;-- ;;; private 設定
;-- ; (require 'init_private)

(provide 'init_main)
;;end emacs23.el
