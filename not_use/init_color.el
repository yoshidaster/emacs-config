;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_color.el --- color setting file


;; Copyright (C) 2004-2010  sakito
;; Author: sakito <sakito@sakito.com>

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary: 色の設定

;; 

;;; Code:

;; デフォルトのフレーム設定
;; ディスプレイサイズによって分離する試み 途中
(cond
 ;; 1920 * 1200 ディスプレイ
 ;; デュアルだったりトリプルだったりするので width の方は条件に入れてない
 ;; 設定は (frame-parameter (selected-frame) 'height) などで値を取得して設定する
 ((= (display-pixel-height) 1200)
  (setq default-frame-alist
        (append (list
                 '(width . 190)
                 '(height . 65)
                 '(top . 90)
                 '(left . 500)
                 )
                default-frame-alist)))
 ;; とりあえずその他 完全に未確認で分岐できる事を確認するためのコード
 (t
  (setq default-frame-alist
        (append (list
                 '(width . 140)
                 '(height . 50)
                 '(top . 90)
                 '(left . 100)
                 )
                default-frame-alist))))

;; 垂直スクロール用のスクロールバーを付けない
(add-to-list 'default-frame-alist '(vertical-scroll-bars . nil))

;; 背景の透過
;; (add-to-list 'default-frame-alist '(alpha . (85 20)))
(add-to-list 'default-frame-alist '(alpha . (92 70)))

;;; フォントの設定
;; システム依存を排除するために一旦デフォルトフォントセットを上書き
;; 漢字は IPAゴジック + かな英数字は September を設定(等幅以外はインストールしてない)
;; jisx0208の範囲の漢字は September にすべきかもしれない
;; face の設定は基本的に全て color-thema に設定する方針
;; japanese-jisx0213.2004-1 = japanese-jisx0213-a + japanese-jisx0213-1
;; japanese-jisx0213-1 = japanese-jisx0208 のほぼ上位互換
;; japanese-jisx0213-2 = code-offset #x150000
;; japanese-jisx0212 = code-offset #x148000 
;; japanese-jisx0208 = code-offset #x140000
(when mac-p
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
;; 古代ギリシア文字、コプト文字を表示したい場合は以下のフォントをインストールする
;; http://apagreekkeys.org/NAUdownload.html
(set-fontset-font nil
                  'greek-iso8859-7
                  (font-spec :family "New Athena Unicode")
                  nil
                  'prepend)
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
)

;; 等幅のフォントセットを幾つか作成予定

(when (find-font (font-spec :family "Menlo"))
  ;; ヒラギノ 角ゴ ProN + Menlo
  (create-fontset-from-ascii-font "Menlo-14" nil "menlokakugo")
  (set-fontset-font "fontset-menlokakugo"
                    'unicode
                    (font-spec :family "Hiragino Kaku Gothic ProN" :size 16))
  ;; 確認用 (set-frame-font "fontset-menlokakugo")
  ;; (add-to-list 'default-frame-alist '(font . "fontset-menlokakugo"))  ;; 実際に設定する場合
  )


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
(global-highlight-changes-mode t)
(setq highlight-changes-visibility-initial-state t)
(global-set-key (kbd "M-]") 'highlight-changes-next-change)
(global-set-key (kbd "M-[")  'highlight-changes-previous-change)

;; 現在行に色を付ける
(global-hl-line-mode)
(hl-line-mode 1)

;; 列に色を付ける
;; @see http://www.emacswiki.org/emacs/CrosshairHighlighting
;; @see http://www.emacswiki.org/emacs/VlineMode
;; @see http://www.emacswiki.org/cgi-bin/wiki/vline.el
;;(require 'crosshairs)

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

;; face を調査するための関数
;; いろいろ知りたい場合は C-u C-x =
(defun describe-face-at-point ()
  "Return face used at point."
  (interactive)
  (message "%s" (get-char-property (point) 'face)))

;; kill-ring 中の属性を削除
;; @see http://www-tsujii.is.s.u-tokyo.ac.jp/~yoshinag/tips/junk_elisp.html
;; (defadvice kill-new (around my-kill-ring-disable-text-property activate)
;;   (let ((new (ad-get-arg 0)))
;;     (set-text-properties 0 (length new) nil new)
;;     ad-do-it))


(provide 'init_color)
;;; init_color.el ends here
