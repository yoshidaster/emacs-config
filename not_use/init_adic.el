;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_adic.el --- Dictionary.app

;; Copyright (C) 2009  sakito

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

;; 

;;; Code:
(defun ite-activate ()
  "translation window"
  (interactive)

  (setq w_edit (selected-window))
  (setq w_dict (split-window w_edit (- (window-height) 15)))
  (setq w_gross (split-window w_dict nil t))
  
  ;
  ;(insert word "\n")
  ;(start-process "dict-process" tmpbuf "dict.py" word)
  ;(beginning-of-buffer)
  (ite-dict)
  (ite-gross)

  (select-window w_edit)
  ;(split-window-horizontally 20)
  ;(split-window-vertically 20)
  )

(defun ite-dict ()
  (interactive)
  (setq tmpbuf " * dict-process *")
  (if (not (window-live-p w_dict))
      (ite-activate))

    (select-window w_dict)
    (switch-to-buffer tmpbuf)
    (erase-buffer))

(defun ite-gross ()
  (if (not (window-live-p w_gross))
      (ite-activate))

  (select-window w_gross)
  (find-file "~/Sites/develop/dictpy/dip.txt"))

(defun ite-dict-func ()
  (interactive)
  (let ((editable (not buffer-read-only))
        (pt (save-excursion (mouse-set-point last-nonmenu-event)))
        beg end)

    (if (and mark-active
             (<= (region-beginning) pt) (<= pt (region-end)) )
        (setq beg (region-beginning)
              end (region-end))
      (save-excursion
        (goto-char pt)
        (setq end (progn (forward-word) (point)))
        (setq beg (progn (backward-word) (point)))
        ))

    (setq f_name (file-name-nondirectory (buffer-file-name)))

    (setq word (buffer-substring-no-properties beg end))
    ;; 改行の除去
    (while (string-match "\n" word)
      (setq word (replace-match " " nil nil word)))

    (ite-dict)
    (insert word "\n")
    (start-process "dict-process" tmpbuf "dict.py" word)
    (goto-char (point-min))
    (ite-gross)
    (goto-char (point-max))
    (insert "\n")
    (insert "#: " f_name "\n")
    (insert "msgid \"" word "\"\n")
    (insert "msgstr \"\"\n")

    (select-window w_edit)

  ))

;; 辞書.app を利用する
(defun my_dictionary ()
  "dictionary.app"
  (interactive)

  (let ((editable (not buffer-read-only))
        (pt (save-excursion (mouse-set-point last-nonmenu-event)))
        beg end)

    (if (and mark-active
             (<= (region-beginning) pt) (<= pt (region-end)) )
        (setq beg (region-beginning)
              end (region-end))
      (save-excursion
        (goto-char pt)
        (setq end (progn (forward-word) (point)))
        (setq beg (progn (backward-word) (point)))
        ))

    (setq word (buffer-substring-no-properties beg end))
    (let ((win (selected-window))
          (tmpbuf " * dict-process *"))
      (pop-to-buffer tmpbuf)
      (enlarge-window (- (- (window-height) 20)))
      (erase-buffer)
      (insert word "\n")
      (start-process "dict-process" tmpbuf "dict.py" word)
      (beginning-of-buffer)
      (select-window win)
      )

    ;(browse-url
    ; (concat "dict:///"
    ;         (url-hexify-string (buffer-substring-no-properties beg end))))
))



(provide 'init_adic)
;;; init_adic.el ends here
