;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_wl.el --- wl

;; Copyright (C) 2008  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: 

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Commentary:

;; 

;;; Code:
;;; Wanderlust
;; @see http://www.gohome.org/wl/index.ja.html
;;
;; SEMI を使うための設定 
;(require 'mime-setup) ;; 通常は不要です
(autoload 'wl "wl" "Wanderlust" t)
(autoload 'wl-draft "wl-draft" "Write draft with Wanderlust." t)
; draft時にskk起動
(add-hook 'wl-mail-setup-hook
          (function
           (lambda ()
             ;(wl-draft-config-exec)
             ;;(skk-latin-mode 1)
             )))
;(autoload 'prom-wl "prom-wl" "Prom for Wanderlust" t)
;(setq proc-log-list (list "~/Maildir/from-log"))
;(setq proc-keep-log "~/Maildir/listlog") ;; ログの保存用ファイル
;(setq proc-lock-file "~/.lockmail")
;(setq prom-wl-get-new-mail-optional-method 'prom-wl-check-list-folders)
;(setq proc-keep-log nil)  ;; procmail ログを消去

;;; BBDB
;; @see http://bbdb.sourceforge.net/
;; @version 2.32
;;
;(require 'bbdb-wl)
;(bbdb-wl-setup)
;(setq bbdb-file "~/.emacs.d/var/bbdb")
;; FLIM では quote された eword encoded word は decode されない。
;; 強制的に decode したい場合には、次の設定を加えてください。
;(setq gnus-bbdb/decode-field-body-function
;      (function
;       (lambda (field-body field-name)
         ;;(require 'eword-decode);; for Pterodactyl Gnus
;         (eword-decode-string field-body)
;         )))
;; ポップアップ表示
;(setq bbdb-use-pop-up t)
;; 自動収集
;(setq bbdb/mail-auto-create-p t)
;(setq signature-use-bbdb t)
;(setq bbdb-north-american-phone-numbers-p nil)
;; サマリに bbdb の名前を表示 :-)。
;(setq wl-summary-from-function 'bbdb-wl-from-func)
;; X-Faceを表示する
;(require 'highlight-headers)
;; 自動的に ML フィールドを加える
;(add-hook 'bbdb-notice-hook 'bbdb-auto-notes-hook)
;; 追加収集ヘッダ
;(setq bbdb-auto-notes-alist
;      '(
;        ("X-ML-Name" (".*$" ML 0))
;        ("X-Mailer" (".*$" User-Agent 0))
;        ("X-Newsreader" (".*$" User-Agent 0))
;        ("User-Agent" (".*$" User-Agent 0))
;        ))

;;; lsdb[2003/11/16]
;; @see http://lsdb.sourceforge.jp/
;(require 'lsdb)
;(lsdb-wl-insinuate)
;(add-hook 'wl-draft-mode-hook
;          (lambda ()
;            (define-key wl-draft-mode-map "\C-ct" 'lsdb-complete-name)))

(provide 'init_wl)
;;; init_wl.el ends here
