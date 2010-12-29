;;; init_smartchr.el --- smartchr

;; Copyright (C) 2010  sakito

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

;; smartchr の設定
;; http://tech.kayac.com/archive/emacs-tips-smartchr.html
;; http://github.com/imakado/emacs-smartchr

;;; Code:
(require 'smartchr)

;; 無名関数だと add-hook や remove-hook がめんどいのでまとめておく
(defun smartchr-custom-keybindings ()
;;  (local-set-key (kbd "=") (smartchr '(" = " " == "  "="))) この設定は結構不便
  ;; !! がカーソルの位置
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[ [`!!'] ]" "[")))
  (local-set-key (kbd "{") (smartchr '("{\n`!!'\n}" "{`!!'}" "{")))
  (local-set-key (kbd "`") (smartchr '("\``!!''" "\`")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
  )

(defun smartchr-custom-keybindings-rst ()
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[ [`!!'] ]" "[")))
  (local-set-key (kbd "{") (smartchr '("{\n`!!'\n}" "{`!!'}" "{")))
  (local-set-key (kbd "`") (smartchr '("\`\``!!'\`\`" "\``!!'\`" "\'")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd ">") (smartchr '(">>>" ">" " => " " => '`!!''" " => \"`!!'\"")))
  )

(defun smartchr-custom-keybindings-objc ()
  (local-set-key (kbd "@") (smartchr '("@\"`!!'\"" "@")))
  )

(defun smartchr-custom-keybindings-scala ()
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[ [`!!'] ]" "[")))
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{")))
  (local-set-key (kbd "`") (smartchr '("\``!!''" "\`")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd ">") (smartchr '(">" " => " " -> " " => '`!!''" " => \"`!!'\"")))
  (local-set-key (kbd "<") (smartchr '("<" " <- ")))
  )

(defun smartchr-custom-keybindings-ocaml ()
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(* `!!' *)" "(")))
  (local-set-key (kbd "{") (smartchr '("{`!!'}" "{")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd ";") (smartchr '(";;" ";")))
  (local-set-key (kbd ">") (smartchr '(">" " -> ")))
  )

(defun skelton-custom-keybindigs ()
;;   (make-variable-buffer-local 'skeleton-pair)
;;  (make-variable-buffer-local 'skeleton-pair-on-word)
;;  (make-variable-buffer-local 'skeleton-pair-alist)
  (setq skeleton-pair t)
  (setq skeleton-pair-on-word t)
  (setq skeleton-end-hook nil)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
  )

;; 適用するモードを限定
(dolist (hook (list
              'c-mode-common-hook
              'css-mode-hook
              'nxml-mode-hook
              'js2-mode-hook
              ))
  (add-hook hook 'smartchr-custom-keybindings))

(dolist (hook (list
              'emacs-lisp-mode-hook
              'python-mode-hook
              'makefile-mode-hook
              ))
  (add-hook hook 'skelton-custom-keybindigs))

;; モードオリジナル追加設定
(add-hook 'objc-mode-hook 'smartchr-custom-keybindings-objc)
(add-hook 'rst-mode-hook 'smartchr-custom-keybindings-rst)
(add-hook 'tuareg-mode-hook 'smartchr-custom-keybindings-ocaml)
(add-hook 'scala-mode-hook 'smartchr-custom-keybindings-scala)

(provide 'init_smartchr)
;;; init_smartchr.el ends here
