;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_gauche.el --- gauche setting

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

;;; Commentary: Schemeを便利に利用するための設定

;; 

;;; Code:

;;; scheme-mode
;;
(setq scheme-program-name "/usr/local/bin/gosh -i")
(autoload 'run-scheme "cmuscheme" "Run an inferior Scheme process." t)

(defun my-scm-shell ()
  (interactive)
  (let ((win (selected-window))
        (tmpbuf " * temporary *"))
    (pop-to-buffer tmpbuf)
    (run-scheme scheme-program-name)
    (select-window win)
    ))

;; カッコを薄くする。好みによります。
(defvar paren-face 'paren-face)
(make-face 'paren-face)
(set-face-background 'paren-face "black")
(set-face-foreground 'paren-face "gray50")

(add-hook 'scheme-mode-hook
          (function
            (lambda ()
              (define-key scheme-mode-map "\C-c!" 'my-scm-shell)
              (setq scheme-font-lock-keywords-2
                    (append '(("(\\|)" . paren-face))
                            scheme-font-lock-keywords-2))
              )))

;; 新な関数は以下のようにして呼べばよいです。
;(setq cmuscheme-load-hook
;      '(
;        (lambda ()
;          (define-key inferior-scheme-mode-map "\C-c\C-t" 'favorite-cmd)
;          )))

(provide 'init_gauche)
;;; init_gauche.el ends here
