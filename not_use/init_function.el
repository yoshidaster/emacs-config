;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_function.el --- original function settings

;; Copyright (C) 2009  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: lisp

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
;;; 時間を挿入する
;; time-stamp.el [2002/02/24]
;; 更新日を挿入する
(defun time-stamp-date ()
  "Retune the current time as a string in Date from."
  ;(format-time-string "[%04Y/%02m/%02d]")
  (format-time-string "%04Y-%02m-%02d: ")
  )

(defun insert-date nil
  "Insert Date."
  (interactive)
  (insert (time-stamp-date))
  )

;; insert-date Key
(define-key global-map "\C-cd" 'insert-date)

;; 絶対パスを相対パスに変換
(defun skt:relative-path (path)
  (when (file-exists-p path)
    (let ((home (expand-file-name (concat "~/" ""))))
      (if (string-match (concat "^" home)  path)
          (replace-match "~/" t t path) path))))

;; 透過の設定を変更
;; see http://emacs-fu.blogspot.com/2009/02/transparent-emacs.html
(defun djcb-opacity-modify (&optional dec)
  "modify the transparency of the emacs frame; if DEC is t,
    decrease the transparency, otherwise increase it in 10%-steps"
  (let* ((alpha-or-nil (frame-parameter nil 'active-alpha)) ; nil before setting
         (oldalpha (if alpha-or-nil alpha-or-nil 100))
         (newalpha (if dec (- oldalpha 10) (+ oldalpha 10))))
    (when (and (>= newalpha frame-alpha-lower-limit) (<= newalpha 100))
      (modify-frame-parameters nil '((active-alpha . newalpha))))))

(defun djcb-modify-frame-alpha (arg)
    (interactive "Nalpha parameter: ")
    (modify-all-frames-parameters (list (cons 'alpha '((string-to-int arg) 20)))))

;; (modify-all-frames-parameters (list (cons 'alpha '(100 75))))
;; (modify-frame-parameters nil (list (cons 'alpha  arg)))

(dont-compile
  (when (fboundp 'expectations)
    (expectations
      (desc "djcb-opacity-modifyのテスト")
      (expect 85
        (string-to-int "85"))
      (expect t
        (modify-all-frames-parameters (list (cons 'alpha '(85 20))))
        ;; expect の条件が書けてない!
        )
      )))

;; C-8 will increase opacity (== decrease transparency)
;; C-9 will decrease opacity (== increase transparency
;; C-0 will returns the state to normal
;; (global-set-key (kbd "C-8") '(lambda()(interactive)(djcb-opacity-modify)))
;; (global-set-key (kbd "C-9") '(lambda()(interactive)(djcb-opacity-modify t)))
;; (global-set-key (kbd "C-0") '(lambda()(interactive)(modify-frame-parameters nil `((alpha . (100 20))))))

(provide 'init_function)
;;; init_function.el ends here
