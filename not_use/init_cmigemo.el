;;; init_cmigemo.el --- cmigemo

;; Copyright (C) 2010  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: tools

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; cmigemo の設定

;;; Code:
;; 基本設定
(setq migemo-command "cmigemo")
(setq migemo-options '("-q" "--emacs" "-i" "\a"))
;; migemo-dict のパスを指定
(setq migemo-dictionary "~/.emacs.d/etc/migemo/utf-8/migemo-dict")
(setq migemo-user-dictionary nil)
(setq migemo-regex-dictionary nil)

;; キャッシュ機能を利用する
(setq migemo-use-pattern-alist t)
(setq migemo-use-frequent-pattern-alist t)
(setq migemo-pattern-alist-length 1024)
;; 辞書の文字コードを指定．
(setq migemo-coding-system 'utf-8-unix)

;; 初期は無効にしておく M-m で toggle できる
(setq migemo-isearch-enable-p nil)

;; M-m が結構押しずらいので C-t にも設定しておく
(define-key isearch-mode-map (kbd "C-t") 'migemo-isearch-toggle-migemo)

(load-library "migemo")
;; 起動時に初期化
(migemo-init)

(provide 'init_cmigemo)
;;; init_cmigemo.el ends here
