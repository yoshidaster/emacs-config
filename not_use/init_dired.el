;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_dired.el --- dired setting file

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

;; wdired-change-to-wdired-mode等をちゃんと利用してそれから考えるべし

;; dired 上で r を押すと wdired-change-to-wdired-mode を動作させる
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

(eval-after-load "dired"
  '(progn
     ;; dired-x を起動
     (require 'dired-x)
     ;; s で並び変え、C-u s で元に戻る
     ;; @see http://www.meadowy.org/~shirai/elips/sorter.el
     (require 'sorter)
     ;; dired-x では C-x C-j がdired-jump になるので skk-modeに再割り当て
     (global-set-key (kbd "C-x C-j") 'skk-mode)
     ;; システムのlsでなくls-lispを利用して表示
     (require 'ls-lisp)
     (setq ls-lisp-use-insert-directory-program nil)
     ;; ls のオプション
     (setq dired-listing-switches "-lahF")
     ;; ディレクトリをより上に表示
     (setq ls-lisp-dirs-first t)
     ;; dired-find-alternate-fileを有効化
     (put 'dired-find-alternate-file 'disabled nil)
     ;; RETで新規バッファを作成しないでディレクトリを開く(デフォルトは「a」)
     (define-key dired-mode-map (kbd "RET") 'dired-find-alternate-file)
     ;; 「a」を押したときに新規バッファ作成
     (define-key dired-mode-map "a" 'dired-advertised-find-file)
     ;; 再帰コピー
     (setq dired-recursive-copies 'always)
     ;; 再帰削除
;;     (setq dired-recursive-deletes 'always)
     ;; C-x 2 で分割した隣にコピーや移動をする
     (setq dired-dwim-target t)
;;     (define-key dired-mode-map "\C-m" 'dired-find-alternate-file)
     (define-key dired-mode-map (kbd "C-x m") 'dired-w3m-find-file)
     ;; zキーで対応するプログラムでファイルを開く
     ;(define-key dired-mode-map "z" 'dired-open)
     (define-key dired-mode-map "z" 'dired-quickLook)
     ))

;; dired-x の機能を利用して 特定ファイルだけ「!」や「X」でQuick Look 可能にする
;; 以降に定義している dired-quickLook を利用すると何でもQLに渡す
;; QL の終了は C-g
(setq dired-guess-shell-alist-user
      '(("\\.png$" "qlmanage -p")
        ("\\.jpg$" "qlmanage -p")
        ("\\.pdf$" "open")))

;; open コマンドでファイルを開く
(defun dired-open ()
  (interactive)
  (let ((file (dired-get-filename)))
    (unless (file-directory-p file)
      ;; file がディレクトリでない場合
      (start-process "open" "*diredopen" "open" file))))

;; QuickLookでファイルを開く
(defun dired-quickLook ()
  (interactive)
  (let ((file (dired-get-filename)))
    (unless (file-directory-p file)
      ;; file がディレクトリでない場合
      (start-process "QuickLook" "*diredQuickLook" "/usr/bin/qlmanage" "-p" (shell-quote-argument file)))))

;; w3m で表示する
(defun dired-w3m-find-file ()
  (interactive)
  (autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
  ;;(require 'w3m)
  (let ((file (dired-get-filename)))
    (if (y-or-n-p (format "Use emacs-w3m to browse %s? "
                          (file-name-nondirectory file)))
        (w3m-find-file file))))

(put 'dired-find-alternate-file 'disabled nil)

(require 'elscreen-dired)

(provide 'init_dired)
;;; init_dired.el ends here
