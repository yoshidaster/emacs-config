;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_key.el --- key settign

;; Copyright (C) 2004  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: tools

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

;;; Commentary:

;; 

;;; Code:

(if (eq window-system 'x)
    (progn
      (global-set-key "\C-w" 'kill-ring-save)
      (global-set-key "\M-w" 'kill-region)
      ))

;; C-x C-l にて選択範囲を小文字に変換する機能
(put 'downcase-region 'disabled nil)
;; C-x C-u にて選択範囲を大文字に変換する機能
(put 'upcase-region 'disabled nil)

;; C-m は 改行とインデントに割り当て(SKK に取られてしまうから)
(global-set-key (kbd "C-m") 'newline-and-indent)

;; cua-mode に移行
;;(require 'sense-region)

;; CUA-mode にて矩形選択のみを有効化
(setq cua-enable-cua-keys nil)
(cua-mode t)

;; window の移動
(defun other-window-or-split ()
  (interactive)
  (when (one-window-p)
    (split-window-horizontally))
  (other-window 1))
(global-set-key (kbd "<C-tab>") 'other-window-or-split)


;; fullscreen を toggle する
(defun toggle-fullscreen ()
  (interactive)
  (if (frame-parameter nil 'fullscreen)
      (set-frame-parameter nil 'fullscreen nil)
    (set-frame-parameter nil 'fullscreen 'fullboth)
    ))
(global-set-key (kbd "C-c m") 'toggle-fullscreen)


(when ns-p
  ;; 
  ;; (setq ns-alternate-modifier (quote alt))
  (setq ns-command-modifier (quote meta))
  ;; dndの動作を Emacs22と同じにする
  (define-key global-map [ns-drag-file] 'ns-find-file))

(when mac-p
  ;; インプッットメソッドの設定
  ;; (setq default-input-method "MacOSX-IM-JP")
  ;; インプットメソッド対応パッチにてctrキーをOS側に渡さない設定
  ;; (mac-add-ignore-shortcut '(control))
  ;; システムに装飾キー渡さない
  (setq mac-pass-control-to-system nil)
  (setq mac-pass-command-to-system nil)
  ;; (setq mac-pass-option-to-system nil)

  ;;コマンドキーをMetaキーとして利用
  ;; (setq mac-command-key-is-meta t)
  ;; (setq mac-command-key-is-meta nil)
  ;; (setq ns-command-modifier (quote meta))

  ;; 起動したら US にする
  ; (add-hook 'after-init-hook 'mac-change-language-to-us)
  ;; minibuffer 内は US にする
  ; (add-hook 'minibuffer-setup-hook 'mac-change-language-to-us)
  ; (mac-translate-from-yen-to-backslash)
  ;; 入力モードを英語に変更
  (setq mac-ts-script-language-on-focus '(0 . 0))
)

(provide 'init_key)
;;; init_key.el ends here
