;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_modeinfo.el --- mode-info

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

;; @see http://www.namazu.org/~tsuchiya/elisp/mode-info.html
;(require 'mi-config)
;(define-key global-map "\C-cf" 'mode-info-describe-function)
;(define-key global-map "\C-cv" 'mode-info-describe-variable)
;;(define-key global-map "\M-." 'mode-info-find-tag)
;(require 'mi-fontify)
;(setq mode-info-class-alist
;      '(
;        (elisp  emacs-lisp-mode lisp-interaction-mode)
;        (make   makefile-mode)
;        (octave octave-mode)
;        (gauche scheme-mode scheme-interaction-mode inferior-scheme-mode)
;        ))



(provide 'init_modeinfo)
;;; init_modeinfo.el ends here
