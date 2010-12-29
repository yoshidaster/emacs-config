;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_pukiwiki.el --- PukiWiki-mode setting

;; Copyright (C) 2004  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: hypermedia

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

;; PukiWiki-modeの設定
;; http://www.bookshelf.jp/pukiwiki/pukiwiki.php?%A5%A2%A5%A4%A5%C7%A5%A2%BD%B8%2Fpukiwiki-mode

;;; Code:

(load-library "pukiwiki-mode")

(setq pukiwiki-site-list
      '(
        ("MacEmacs" "http://macemacsjp.sourceforge.jp/index.php")
        ("Meadow" "http://www.bookshelf.jp/pukiwiki/pukiwiki.php")
        ("Kawacho" "http://kawacho.don.am/wiki/pukiwiki.php")
        ))

(provide 'init_pukiwiki)
;;; init_pukiwiki.el ends here
