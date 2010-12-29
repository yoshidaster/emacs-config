;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_syscarbon.el --- carbon emacs

;; Copyright (C) 2010  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: 

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

;; Emacs 22 Carbon Emacs

;;; Code:
(message "start init carbon emmacs")

;; 基本的にデバッグ時しか起動しない
(setq debug-on-error t)

(load "~/.emacs.d/lisp/ac/popup.el")
(load "~/.emacs.d/lisp/ac/auto-complete.el")
(load "~/.emacs.d/lisp/ac/auto-complete-config.el")
(load "~/.emacs.d/lisp/ac/company.el")
(load "~/.emacs.d/lisp/ac/company-xcode.el")
(load "~/.emacs.d/lisp/ac/ac-company.el")

;; objc の設定
(require 'init_ac)
(require 'flymake)
(require 'init_objc)

(provide 'init_syscarbon)
;;; init_syscarbon.el ends here
