;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_sdic.el --- sdic setting file

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

;;; 辞書引き
;; @see http://namazu.org/~tsuchiya/sdic/index.html
(autoload 'sdic-describe-word "sdic"
    "英単語の意味を調べる" t nil)
(global-set-key "\C-cw" 'sdic-describe-word)
(autoload 'sdic-describe-word-at-point "sdic"
  "カーソルの位置の英単語の意味を調べる" t nil)
(global-set-key "\C-cW" 'sdic-describe-word-at-point)

;; 検索結果ウィンドの幅の設定および動作設定
(setq sdic-window-height 10
      sdic-disable-select-window t)

;; つかってるのはGene95とedictって辞書です
;; make install 意外でインストールした場合のみ設定が必要です。
;(setq sdic-eiwa-dictionary-list '((sdicf-client "~/share/dict/gene.sdic"))
;      sdic-waei-dictionary-list '((sdicf-client "~/share/dict/jedict.sdic"
;                                           (add-keys-to-headword t))))

;; 現在は英辞郎を利用しています
(setq
 sdic-eiwa-dictionary-list '((sdicf-client "~/share/dict/eijiro52.sdic" (strategy array)))
 sdic-waei-dictionary-list '((sdicf-client "~/share/dict/waeiji52.sdic" (strategy array)))
 )

(provide 'init_sdic)
;;; init_sdic.el ends here
