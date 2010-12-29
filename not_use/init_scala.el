;;; init_scala.el --- scala

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

;; scala

;;; Code:

(require 'scala-mode-auto)

(defun skt:scala-mode-hook ()
  (progn
    ;; キー
    (local-set-key (kbd "C-c !") 'scala-run-scala)
    (local-set-key (kbd "C-c C-e") 'scala-eval-definition)
    (local-set-key (kbd "C-c C-c") 'scala-eval-buffer)
    (local-set-key (kbd "<C-tab>") 'other-window-or-split)
;;    (local-set-key (kbd "RET") 'reindent-then-newline-and-indent)
    ))

(add-hook 'scala-mode-hook 'skt:scala-mode-hook)

(provide 'init_scala)
;;; init_scala.el ends here
