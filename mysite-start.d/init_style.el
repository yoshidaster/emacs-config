;; フォント設定
(set-face-attribute 'default
                    nil
                    :family "September"
                    :height 140)
(set-frame-font "September-14")
(set-fontset-font nil
                  'unicode
                  (font-spec :family "IPAGothic")
                  nil
                  'append)

;; 一部の文字を September にする
;; 記号         3000-303F http://www.triggertek.com/r/unicode/3000-303F
;; 全角ひらがな 3040-309f http://www.triggertek.com/r/unicode/3040-309F
;; 全角カタカナ 30a0-30ff http://www.triggertek.com/r/unicode/30A0-30FF
(set-fontset-font nil
                  '( #x3000 .  #x30ff)
                  (font-spec :family "September")
                  nil
                  'prepend)
;; 半角カタカナ、全角アルファベット ff00-ffef http://www.triggertek.com/r/unicode/FF00-FFEF
(set-fontset-font nil
                  '( #xff00 .  #xffef)
                  (font-spec :family "September")
                  nil
                  'prepend)


;; フォントロックの設定
(when (fboundp 'global-font-lock-mode)
  (global-font-lock-mode t)
  ;;(setq font-lock-maximum-decoration t)
  (setq font-lock-support-mode 'jit-lock-mode))

;; タブ文字、全角空白、文末の空白の色付け
;; @see http://www.emacswiki.org/emacs/WhiteSpace
;; @see http://xahlee.org/emacs/whitespace-mode.html
(setq whitespace-style '(spaces tabs newline space-mark tab-mark newline-mark))

;; タブ文字、全角空白、文末の空白の色付け
;; font-lockに対応したモードでしか動作しません
(defface my-mark-tabs
  '((t (:foreground "red" :underline t)))
  nil :group 'skt)
(defface my-mark-whitespace
  '((t (:background "gray")))
  nil :group 'skt)
(defface my-mark-lineendspaces
  '((t (:foreground "SteelBlue" :underline t)))
  nil :group 'skt)

(defvar my-mark-tabs 'my-mark-tabs)
(defvar my-mark-whitespace 'my-mark-whitespace)
(defvar my-mark-lineendspaces 'my-mark-lineendspaces)

(defadvice font-lock-mode (before my-font-lock-mode ())
  (font-lock-add-keywords
   major-mode
   '(
     ("\t" 0 my-mark-tabs append)
     ("　" 0 my-mark-whitespace append)
;;     ("[ \t]+$" 0 my-mark-lineendspaces append)
     )))
(ad-enable-advice 'font-lock-mode 'before 'my-font-lock-mode)
(ad-activate 'font-lock-mode)

;; 行末の空白を表示
(setq-default show-trailing-whitespace t)
;; EOB を表示
(setq-default indicate-empty-lines t)
(setq-default indicate-buffer-boundaries 'left)

;; マーク領域を色付け
(setq transient-mark-mode t)

;; 変更点に色付け
;; (global-highlight-changes-mode t)
;; (setq highlight-changes-visibility-initial-state t)
;; (global-set-key (kbd "M-]") 'highlight-changes-next-change)
;; (global-set-key (kbd "M-[")  'highlight-changes-previous-change)

;; 現在行に色を付ける
; (global-hl-line-mode)
; (hl-line-mode 1)

;;色の設定
(setq default-frame-alist
      (append (list
              ; '(foreground-color . "snow")
              ; '(background-color . "black")
              ; '(border-color . "black")
              ; '(cursor-color . "orange")
              ; '(mouse-color . "orange")
               '(width . 120)
               '(height . 45)
               '(top . 20)
               '(left . 20)
               '(vertical-scroll-bars . nil)
               '(alpha . (82 65))
               )
              default-frame-alist)
      )

; ;; モードライン(下にあるやつ)の色設定
; (set-face-foreground 'modeline "snow")
; (set-face-background 'modeline "dark blue")
; (set-face-underline-p 'modeline t) ; モードラインには下線をつける

;; color-theme
(setq color-theme-load-all-themes nil)
(setq color-theme-libraries nil)
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (cond
      (mac-p
       (require 'color-theme-dark)
       (color-theme-dark)
       )
      (windows-p
       (require 'color-theme-ntemacs)
       (color-theme-ntemacs))
      )))

(provide 'init_style)
