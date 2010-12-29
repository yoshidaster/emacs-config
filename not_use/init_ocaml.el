;;; init_ocaml.el --- ocaml

;; Copyright (C) 2010  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: tools, languages

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

;; OCaml のための設定
;; @see http://caml.inria.fr/
;; @see http://www-rocq.inria.fr/~acohen/tuareg/mode
;; @see http://aspellfr.free.fr/tuareg-imenu/

;;; Code:
(autoload 'tuareg-mode "tuareg" "Major mode for editing Caml code" t)
(autoload 'camldebug "camldebug" "Run the Caml debugger" t)
(autoload 'tuareg-imenu-set-imenu "tuareg-imenu"
  "Configuration of imenu for tuareg" t)

(defun skt:tuareg-mode-hook ()
  (progn
    'tuareg-imenu-set-imenu
    (setq tuareg-interactive-program "ocaml")
    (setq camldebug-command-name "ocamldebug")

    ;; インデント
    (setq tuareg-in-indent 0)
    (setq tuareg-function-indent 0)
    (setq tuareg-parser-indent 0)
    (setq tuareg-match-indent 0)
    (setq tuareg-lazy-paren t)
    (setq tuareg-electric-indent nil)
    (setq tuareg-leading-star-in-doc t)
    (setq tuareg-with-indent 0)

    ;; キー
    (local-set-key (kbd "C-c C-c") 'tuareg-eval-buffer)
    ))

(add-hook 'tuareg-mode-hook 'skt:tuareg-mode-hook)

(setq auto-mode-alist 
      (append '(("\\.ml[ily]?$" . tuareg-mode)
                ("\\.topml$" . tuareg-mode))
              auto-mode-alist))

(provide 'init_ocaml)
;;; init_ocaml.el ends here
