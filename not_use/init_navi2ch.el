;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_navi2ch.el --- navi2ch

;; Copyright (C) 2008  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: tools

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

;;; 2ちゃんねる廃人への道
;; navi2ch
;; @see http://navi2ch.sourceforge.net/
;; 実は設定がいいがけんです、、
;;
;(setq load-path
;     (cons "/usr/local/share/emacs/21.3.50/site-lisp/navi2ch" load-path))
(autoload 'navi2ch "navi2ch" "Navigator for 2ch for Emacs" t)
(autoload 'navi2ch-localfile "navi2ch-localfile" nil t)
;(setq navi2ch-list-bbstable-url "http://www.2ch.net/bbsmenu.html")
;(setq navi2ch-list-bbstable-url "http://www6.ocn.ne.jp/~mirv/2chmenu.html")
;(setq navi2ch-list-bbstable-url "http://azlucky.s25.xrea.com/2chboard/bbsmenu.html")
(setq navi2ch-list-bbstable-url "http://menu.2ch.net/bbsmenu.html")
(setq navi2ch-list-stay-list-window t)
(setq navi2ch-article-new-message-range '(1000 . 1))
(setq navi2ch-article-exist-message-range '(1 . 1000))
;(require 'navi2ch-mona)
;(add-hook 'navi2ch-article-arrange-message-hook
;         'navi2ch-mona-arrange-message)
;(setq navi2ch-mona-enable t)

(provide 'init_navi2ch)
;;; init_navi2ch.el ends here
