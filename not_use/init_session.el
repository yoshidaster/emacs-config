;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_session.el --- session.el

;; Copyright (C) 2009  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; 

;;; Code:

;; 前回のカーソル位置を記憶 session に代替え
;(require 'saveplace)
;(setq-default save-place t)
;(setq save-place-file "~/.emacs.d/var/places.txt")

;; session
(when (require 'session nil t)
  (setq session-initialize '(de-saveplace session keys menus places)
        session-globals-include '((kill-ring 50)
                                  (session-file-alist 500 t)
                                  (file-name-history 10000))
        ;; 保存時でなく閉じた時のカーソル位置を記憶する
        session-undo-check -1)
  ;; 記憶容量を倍に設定しておく
  (setq session-globals-max-string  2048)
  (setq session-registers-max-string 2048)
  ;; ミニバッファ履歴リストの長さ制限を無くす
  (setq history-length t)
  ;; session で無視するファイル設定
  (setq session-set-file-name-exclude-regexp
        "/\\.overview\\|\\.session\\|News/\\||^/var/folders/\\|^/tmp/\\|\\.orig\\|\\.elc\\|\\.pyc\\|\\.recentf\\|\\.howm-kyes")
  (add-hook 'after-init-hook 'session-initialize))

;; minibuffer history から重複を排除する
(defun minibuffer-delete-duplicate ()
  (let (list)
    (dolist (elt (symbol-value minibuffer-history-variable))
      (unless (member elt list)
        (push elt list)))
    (set minibuffer-history-variable (nreverse list))))
(add-hook 'minibuffer-setup-hook 'minibuffer-delete-duplicate)

;; kill-ring 内の重複を排除する
(defadvice kill-new (before ys:no-kill-new-duplicates activate)
  (setq kill-ring (delete (ad-get-arg 0) kill-ring)))

;; バッファでの同名ファイルに識別子を付与する
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)
;; バッファ名が重複しなくてもディレクトリ名を付与する
;; 数字は表示階層の深さ だいたい3階層までに抑えるし、howm で年月が見える等の理由で一階層上まで見えるのが好み
(setq uniquify-min-dir-content 2)
;; uniquify-ignore-buffers-re を設定すると対象外のバッファを指定できるがデフォルトで特殊バッファは基本よける

;; モードラインにファイルのディレクトリを表示 uniquify-min-dir-content による実質不要
;; (add-to-list 'global-mode-string '("" default-directory "-"))
;; (add-to-list 'global-mode-string '(:eval (skt:relative-path default-directory)))

;; kill-summary anything の機能を利用するようにしたので不要
;(autoload 'kill-summary "kill-summary" nil t)
;(global-set-key "\M-y" 'kill-summary)


(provide 'init_session)
;;; init_session.el ends here
