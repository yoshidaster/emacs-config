;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_python.el --- Python Setting

;; Copyright (C) 2004-2010  sakito

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

;;; Commentary: Python-mode および Pythonコーディングに便利な設定

;; 

;;; Code:

;;; Python-mode
;; @see http://www.python.org/emacs/python-mode/
;;
(setenv "PYTHONSTARTUP" (expand-file-name "~/.emacs.d/rc.d/pythonrc.py"))
(setenv "PYTHONPATH" (expand-file-name "~/local/lib/python2.7/site-packages"))

(autoload 'python-mode "python-mode" "Python editing mode." t)
(add-to-list 'auto-mode-alist '("\\.py\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.cgi\\'" . python-mode))
(add-to-list 'auto-mode-alist '("\\.wsgi\\'" . python-mode))
(add-to-list 'interpreter-mode-alist '("python" . python-mode))

;; python
(cond
 (mac-p
  (setq py-python-command (expand-file-name "~/local/bin/python")))
 (windows-p
  (setq py-python-command "C:/Python26/bin/python"))
 )

;; pdb
(cond
 (mac-p
  (setq pdb-path '/Library/Frameworks/Python.framework/Versions/2.6/lib/python2.6/pdb.py
        gud-pdb-command-name (symbol-name pdb-path)))
 )

(defadvice pdb (before gud-query-cmdline activate)
  "Provide a better default command line when called interactively."
  (interactive
   (list (gud-query-cmdline pdb-path
                            (file-name-nondirectory buffer-file-name)))))

;; doctest
(add-to-list 'auto-mode-alist '("\\.doctest$" . doctest-mode))
(autoload 'doctest-mode
  "doctest-mode" "Editing mode for Python Doctest examples." t)

;; Pymacs
(require 'pymacs)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;; ipython
(require 'ipython)
(setq ipython-command "/usr/local/bin/ipython")
;; ipython の起動オプションを設定
;; デフォルトは (-i -colors LightBG)
;;(setq py-python-command-args '("-cl" "-i" "-colors" "Linux"))
(setq py-python-command-args '("-i" "-colors" "Linux"))

;; http://www.emacswiki.org/emacs/anything-ipython.el
(require 'anything-ipython)
(add-to-list 'anything-sources 'anything-source-ipython)
(when (require 'anything-show-completion nil t)
  (use-anything-show-completion 'anything-ipython-complete
                                '(length initial-pattern)))

(defun skt:python-mode-hook ()
  (progn
    ;; キー
    (local-set-key (kbd "C-c C-l") 'anything-ipython-complete) ;; py-shift-region-left を上書きしている
    (local-set-key (kbd "C-c e") 'anything-ipython-complete)
    (local-set-key (kbd "C-c C-r") 'py-execute-region)  ;; py-shift-region-right を上書きしている
    (local-set-key (kbd "C-c ;") 'comment-dwim)
    (local-set-key (kbd "C-c :") 'comment-dwim)
    ))
(add-hook 'python-mode-hook 'skt:python-mode-hook)

(defun skt:ipython-shell-hook ()
  (progn
    ;; キー
    (local-set-key (kbd "C-c C-l") 'anything-ipython-complete)
    ))
(add-hook 'ipython-shell-hook 'skt:ipython-shell-hook)

;; anything で info 参照
;; もっと効率的に記述できることはわかっているが、都合により現在はこの記述にしておく

;; Info Python Module
(defvar anything-c-info-python-module nil)
(defvar anything-c-source-info-python-module
  `((name . "Info Python Module")
    (init . (lambda ()
              (save-window-excursion
                (unless anything-c-info-python-module
                  (with-temp-buffer
                    (Info-find-node "python-lib-jp" "Module Index")
                    (setq anything-c-info-python-module (split-string (buffer-string) "\n"))
                    (Info-exit))))))
    (candidates . (lambda ()
                    (loop for i in anything-c-info-python-module
                          if (string-match "^* [^ \n]+[^: ]" i)
                          collect (match-string 0 i))))
    (action . (lambda (candidate)
                (Info-find-node "python-lib-jp" "Module Index")
                (Info-index (replace-regexp-in-string "* " "" candidate))))
    (requires-pattern . 2)))
;; (anything 'anything-c-source-info-python-module)

;; Info Python Class-Exception-Object
(defvar anything-c-info-python-class nil)
(defvar anything-c-source-info-python-class
  `((name . "Info Python Class-Exception-Object")
    (init . (lambda ()
              (save-window-excursion
                (unless anything-c-info-python-class
                  (with-temp-buffer
                    (Info-find-node "python-lib-jp" "Class-Exception-Object Index")
                    (setq anything-c-info-python-class (split-string (buffer-string) "\n"))
                    (Info-exit))))))
    (candidates . (lambda ()
                    (loop for i in anything-c-info-python-class
                          if (string-match "^* [^ \n]+[^: ]" i)
                          collect (match-string 0 i))))
    (action . (lambda (candidate)
                (Info-find-node "python-lib-jp" "Class-Exception-Object Index")
                (Info-index (replace-regexp-in-string "* " "" candidate))))
    (requires-pattern . 2)))
;; (anything 'anything-c-source-info-python-class)

;; Info Python Function-Method-Variable
(defvar anything-c-info-python-function nil)
(defvar anything-c-source-info-python-function
  `((name . "Info Python Function-Method-Variable")
    (init . (lambda ()
              (save-window-excursion
                (unless anything-c-info-python-function
                  (with-temp-buffer
                    (Info-find-node "python-lib-jp" "Function-Method-Variable Index")
                    (setq anything-c-info-python-function (split-string (buffer-string) "\n"))
                    (Info-exit))))))
    (candidates . (lambda ()
                    (loop for i in anything-c-info-python-function
                          if (string-match "^* [^ \n]+[^: ]" i)
                          collect (match-string 0 i))))
    (action . (lambda (candidate)
                (Info-find-node "python-lib-jp" "Function-Method-Variable Index")
                (Info-index (replace-regexp-in-string "* " "" candidate))))
    (requires-pattern . 2)))
;; (anything 'anything-c-source-info-python-function)

;; Info Python Miscellaneous
(defvar anything-c-info-python-misc nil)
(defvar anything-c-source-info-python-misc
  `((name . "Info Python Miscellaneous")
    (init . (lambda ()
              (save-window-excursion
                (unless anything-c-info-python-misc
                  (with-temp-buffer
                    (Info-find-node "python-lib-jp" "Miscellaneous Index")
                    (setq anything-c-info-python-misc (split-string (buffer-string) "\n"))
                    (Info-exit))))))
    (candidates . (lambda ()
                    (loop for i in anything-c-info-python-misc
                          if (string-match "^* [^ \n]+[^: ]" i)
                          collect (match-string 0 i))))
    (action . (lambda (candidate)
                (Info-find-node "python-lib-jp" "Miscellaneous Index")
                (Info-index (replace-regexp-in-string "* " "" candidate))))
    (requires-pattern . 2)))
;; (anything 'anything-c-source-info-python-misc)



(provide 'init_python)
;;; init_python.el ends here
