;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_smartcompile.el --- smart-compile mode setting

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

;;; Commentary: smart-compile の設定

;; 

;;; Code:

(add-to-list 'load-path (expand-file-name "~/Sites/develop/smart-compile/"))

;;; smart-compile
;; http://home.att.ne.jp/alpha/z123/elisp-j.html#smart-compile
;(require 'smart-compile)
(autoload 'smart-compile "smart-compile" "smart-compile Mode." t)
;; (defvar smart-compile-alist '(
;;   ("\\.c$"          . "gcc -O2 %f -lm -o %n")
;;   ("\\.d$"          . "gdc -O2 %f -lm -o %n")
;;   ("\\.[Cc]+[Pp]*$" . "g++ -O2 %f -lm -o %n")
;;   ("\\.java$"       . "javac %f")
;;   ("\\.[Ff]$"       . "f77 %f -o %n")
;;   ("\\.tex$"        . (tex-file))
;;   ("\\.pl$"         . "perl -cw %f")
;;   ("\\.sh$"         . "sh %f")
;;   ("\\.scm$"        . "gosh %f")
;;   ("\\.awk$"        . "sh %f")
;;   (emacs-lisp-mode  . (emacs-lisp-byte-compile))
;; ))

;; (defvar smart-compile-run-alist '(
;;   ("\\.c\\'"          . "./%n")
;;   ("\\.d\\'"          . "./%n")
;;   ("\\.[Cc]+[Pp]*\\'" . "./%n")
;;   ("\\.java\\'"       . "java -cp . %n")
;;   ("\\.f90\\'"        . "./%n")
;;   ("\\.[Ff]\\'"       . "./%n")
;;   ("\\.tex\\'"        . (tex-file))
;;   ("\\.pl\\'"         . "perl -cw %f")
;;   ("\\.m\\'"          . "./%n")
;;   ("\\.sh$"         . "sh %f")
;;   ("\\.scm$"        . "gosh %f")
;;   ("\\.awk$"        . "sh %f")
;;   (emacs-lisp-mode    . (emacs-lisp-byte-compile))
;;   ))

(add-hook 'c-mode-common-hook
          '(lambda ()
             (local-set-key "\C-c\C-c" 'smart-compile)
             (local-set-key "\C-c\C-r" 'smart-compile-run)
             (local-set-key "\C-c\C-b" 'smart-compile-buildfile)
             ))
(add-hook 'd-mode-hook
          '(lambda ()
             (local-set-key "\C-c\C-c" 'smart-compile)
;             (local-set-key "\C-c\C-r" 'smart-compile-run)
             ))
(add-hook 'sh-mode-hook
          '(lambda ()
             (local-set-key "\C-c\C-c" 'smart-compile)
             ))
(add-hook 'emacs-lisp-mode-hook
          '(lambda ()
             (local-set-key "\C-c\C-c" 'smart-compile)
             ))
(add-hook 'scheme-mode-hook
          '(lambda ()
             (local-set-key "\C-c\C-c" 'smart-compile)
             ))


(provide 'init_smartcompile)
;;; init_smartcompile.el ends here
