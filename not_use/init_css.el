;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_css.el --- css

;; Copyright (C) 2008  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: 

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
;;; css-mode
(autoload 'css-mode "css-mode")
(setq auto-mode-alist
     (append '(
               ("\\.css\\'" . css-mode)
               )
             auto-mode-alist))

(defun hexcolour-luminance (color)
  "Calculate the luminance of a color string (e.g. \"#ffaa00\", \"blue\").
  This is 0.3 red + 0.59 green + 0.11 blue and always between 0 and 255."
  (let* ((values (x-color-values color))
         (r (car values))
         (g (cadr values))
         (b (caddr values)))
    (floor (+ (* .3 r) (* .59 g) (* .11 b)) 256)))

(defun hexcolour-add-to-font-lock ()
  (interactive)
  (font-lock-add-keywords nil
                          `((,(concat "#[0-9a-fA-F]\\{3\\}[0-9a-fA-F]\\{3\\}?\\|"
                                      (regexp-opt (x-defined-colors) 'words))
                             (0 (let ((colour (match-string-no-properties 0)))
                                  (put-text-property
                                   (match-beginning 0) (match-end 0)
                                   'face `((:foreground ,(if (> 128.0 (hexcolour-luminance colour))
                                                             "white" "black"))
                                           (:background ,colour)))))))))

(add-hook 'css-mode-hook 'hexcolour-add-to-font-lock)

(provide 'init_css)
;;; init_css.el ends here
