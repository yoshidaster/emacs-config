;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_lisp.el --- lisp mode setting

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

;;; Emacs Lisp Mode
;(modify-coding-system-alist 'file "\\.el$" '(undecided . iso-2022-jp-unix))
; Emacs Lisp info filesの場所
(setq Info-default-directory-list
      (cons (expand-file-name
             "~/.emacs.d/share/info"
             "/sw/share/info"
             )
            Info-default-directory-list )
      )

(require 'el-mock)
(require 'el-expectations)

(defun skt:emacs-lisp-hook ()
  (setq indent-tabs-mode nil)
  (local-set-key (kbd "C-c C-c") 'emacs-lisp-byte-compile)
  (local-set-key (kbd "C-c C-r") 'emacs-lisp-byte-compile-and-load)
  (local-set-key (kbd "C-c C-e") 'eval-current-buffer)
  ;; (local-set-key (kbd "C-c C") 'compile-defun)
  (local-set-key (kbd "C-c C-d") 'eval-defun)
  (local-set-key (kbd "C-c ;") 'comment-dwim)
  (local-set-key (kbd "C-c :") 'comment-dwim)
  (when (fboundp 'expectations)
    ;; C-M-x compile-defun
    (local-set-key (kbd "C-c C-t") 'expectations-execute))
  )

(add-hook 'lisp-interaction-mode-hook 'skt:emacs-lisp-hook)
(add-hook 'emacs-lisp-mode-hook 'skt:emacs-lisp-hook)

(provide 'init_lisp)
;;; init_lisp.el ends here
