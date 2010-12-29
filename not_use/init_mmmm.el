;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_mmmm.el --- mmm-mode setting

;; Copyright (C) 2004  sakito

;; Author: sakito <sakito@sakito.com>

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

;;; Commentary: mmm-mode の設定

;; 

;;; Code:

;;; mmm-mode
;; @see http://mmm-mode.sourceforge.net/
;(require 'mmm-mode)
;(setq mmm-global-mode 'maybe)
;(mmm-add-mode-ext-class nil "\\.jsp\\'" 'jsp)
;(mmm-add-group 'jsp
;               `((jsp-code
;                  :submode jde-mode
;                  :match-face (("<%!" . mmm-declaration-submode-face)
;                               ("<%=" . mmm-output-submode-face)
;                               ("<%"  . mmm-code-submode-face))
;                  :front "<%[!=]?"
;                  :back "%>"
;                  :insert ((?% jsp-code nil @ "<%" @ " " _ " " @ "%>" @)
;                           (?! jsp-declaration nil @ "<%!" @ " " _ " " @ "%>" @)
;                           (?= jsp-expression nil @ "<%=" @ " " _ " " @ "%>" @))
;                  )
;                 (jsp-directive
;                  :submode text-mode
;                  :face mmm-special-submode-face
;                  :front "<%@"
;                  :back "%>"
;                  :insert ((?@ jsp-directive nil @ "<%@" @ " " _ " " @ "%>" @))
;                  )))
;(setq auto-mode-alist
;      (cons (cons "\\.jsp$" 'mmm-mode) auto-mode-alist)
;      )

(provide 'init_mmm)
;;; init_mmmm.el ends here
