;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_moccur.el --- moccur

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

;; 詳細は http://www.bookshelf.jp/soft/meadow_50.html#SEC751

;;; Code:

(require 'color-moccur)
(require 'moccur-edit)

;; スペース区切りで複数文字を検索条件に指定
(setq moccur-split-word t)

;; migemoがrequireできる環境ならmigemoを使う
(when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
  (setq moccur-use-migemo t))

;; 別ウィンドウで該当ファイルを開かない。エンターした場合にだけ開く
(setq moccur-grep-following-mode-toggle nil)

(require 'color-grep)

;; grep コマンドを ack に置換
(setq grep-command "ack-grep -a --nocolor ")
;; grep-find コマンドを ack に置換
(setq grep-find-command "ack-grep --nocolor --nogroup ")

;; 除外ファイルリスト
(setq dmoccur-exclusion-mask
      (append '("\\~$" "\\.hg\\/\*" "\\.git\\/\*" "\\.pyc$") dmoccur-exclusion-mask))


(provide 'init_moccur)
;;; init_moccur.el ends here
