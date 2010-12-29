;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_eldoc.el --- eldoc

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
; http://d.hatena.ne.jp/rubikitch/20090207/1233936430

;;; Code:
;; Use Emacs23's eldoc
(require 'eldoc)
;; (install-elisp-from-emacswiki "eldoc-extension.el")
(require 'eldoc-extension)
(setq eldoc-idle-delay 0)
(setq eldoc-echo-area-use-multiline-p t)
;(add-hook 'emacs-lisp-mode-hook 'turn-on-eldoc-mode)
;(add-hook 'lisp-interaction-mode-hook 'turn-on-eldoc-mode)
;(add-hook 'ielm-mode-hook 'turn-on-eldoc-mode)
;(add-hook 'python-mode-hook 'turn-on-eldoc-mode)

(provide 'init_eldoc)
;;; init_eldoc.el ends here
