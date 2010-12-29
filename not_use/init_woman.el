;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_woman.el --- woman setting file

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

;; womanの設定ファイル

;;; Code:

;; M-x woman
;; @see http://centaur.maths.qmw.ac.uk/Emacs/WoMan/
;; @see http://homepage1.nifty.com/fin/soft/emacs/woman.html
;;
;; default ("/usr/man")
(setq woman-manpath '("/usr/share/man" "/usr/local/share/man"
                      "/sw/share/man" "/usr/share/man/ja_JP.ujis"))

;; 初回起動が遅いので cache 作成。 際作成はC-u M-x woman
(setq woman-cache-filename (expand-file-name "~/.emacs.d/var/woman_cache"))

;; 新しく frame は作らない。
(setq woman-use-own-frame nil)

(provide 'init_woman)
;;; init_woman.el ends here
