;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_rst.el --- rst mode setting file

;; Copyright (C) 2004-2010  sakito

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
(require 'rst)

;; rst-mode
;; @see http://docutils.sourceforge.net/
(autoload 'rst-mode "rst-mode" "mode for editing reStructuredText documents" t)

;; (setq default-major-mode 'rst-mode)
;; (setq initial-major-mode 'rst-mode)

(setq auto-mode-alist
      (append '(
                ("\\.txt$" . rst-mode)
                ("\\.rst$" . rst-mode)
                ("\\.rest$" . rst-mode)
                ) auto-mode-alist))

(defvar rst-html-program "open"
  "Program used to preview HTML files.")

(defun rst-compile-html-preview ()
  "Convert the document to a HTML file and launch a preview program."
  (interactive)
  (let* ((tmp-filename "/tmp/out.html")
         (command (format "rst2html.py --template ~/.emacs.d/etc/rst/blog_template.txt --stylesheet-path ~/.emacs.d/etc/rst/sourcecode.css %s %s && %s %s"
                          buffer-file-name tmp-filename
                          rst-html-program tmp-filename)))
    (start-process-shell-command "rst-html-preview" nil command)
    ))

(defun skt:rst-mode-hook ()
  (progn
    (local-set-key (kbd "C-c C-c") 'rst-compile)
    (local-set-key (kbd "C-c C-p") 'rst-compile-html-preview)
    (local-set-key (kbd "C-c ;") 'comment-dwim)
    (local-set-key (kbd "C-c :") 'comment-dwim)
    (when (fboundp 'anything-project)
      ;; rst-goto-section を上書きしている
      (local-set-key (kbd "C-c C-f") 'anything-project))
    (when (fboundp 'auto-complete)
      (make-local-variable 'ac-sources)
      (setq ac-sources '(ac-source-yasnippet ac-source-abbrev ac-source-words-in-buffer ac-source-gtags ac-source-filename)))
;;    (local-set-key "\C-c\C-l" 'rst-compile-alt-toolset)
    'turn-off-auto-fill
    ;; color-theme が無効になる場合があるので暫定対処 原因は後程調査 TODO
    (set-face-background rst-level-1-face "gray0")
    (set-face-background rst-level-2-face "gray0")
    (set-face-background rst-level-3-face "gray0")
    (set-face-background rst-level-4-face "gray0")
    (set-face-background rst-level-5-face "gray0")
    (set-face-background rst-level-6-face "gray0")
;;    (local-set-key "\C-c\C-f\C-e" 'rst-change-font-emphasis)
;;    (local-set-key "\C-c\C-f\C-n" 'rst-change-font-normal)
;; `rst-change-font-bold'......[C-c C-f C-b] -> change font (bold)
;; `rst-change-font-emphasis'..[C-c C-f C-e] -> change font (emphasis)
;; `rst-change-font-underline'.[C-c C-f C-u] -> change font (underline)
;; `rst-change-font-truetype'..[C-c C-f C-t] -> change font (truetype)
;; `rst-change-font-bolditalic'[C-c C-f C-_] -> change font (bold-italic)
;; `rst-change-font-normal'....[C-c C-f C-n] -> change font (normal)
;    (require 'rst-html)
    )
  )
(add-hook 'rst-mode-hook  'skt:rst-mode-hook)
(setq rst-pdf-program "open")
;(setcdr (assq 'html rst-compile-toolsets)
;        '("rst2html.py" ".html" "-i utf-8 -o utf-8 -l ja"))
(setcdr (assq 'html rst-compile-toolsets)
        '("rst2html.py" ".html" "--config ~/.emacs.d/etc/rst/def.conf"))
;(setq rst-html-command "rst2html.py")
;(setq rst-html-stylesheet "style.css")
;(setq rst-html-options "-iUTF-8 -oUTF-8 -lja")

(provide 'init_rst)
;;; init_rst.el ends here
