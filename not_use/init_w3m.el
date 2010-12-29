;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_w3m.el --- w3m

;; Copyright (C) 2008  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: tools

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

;;; w3m
;; @see http://w3m.sourceforge.net/index.ja.html
;; @see http://emacs-w3m.namazu.org/

;;; Code:
(autoload 'w3m "w3m" "Interface for w3m on Emacs." t)
(autoload 'w3m-find-file "w3m" "w3m interface function for local file." t)

;; リンク を w3m で開く
(global-set-key (kbd "C-x m") 'browse-url-at-point)
;; (global-set-key (kbd "C-c v") 'browse-url-at-point)

;; 画像を最初から表示
(setq w3m-default-display-inline-images t)

;; (setq browse-url-browser-function 'w3m-browse-url)
;; (autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)

(setq browse-url-browser-function 'browse-url-generic)
(setq browse-url-generic-program "open")
(setq w3m-image-viewer "open")

;; ホームページの設定
(setq w3m-home-page "http://www.google.co.jp/")

;; 検索
(autoload 'w3m-search "w3m-search" "Search QUERY using SEARCH-ENGINE." t)
;; w3m-search-engine-alist の内容を確認してください
(setq w3m-search-default-engine "google")
;;(global-set-key "\C-cs" 'w3m-search)
(setq w3m-mailto-url-function 'wl-draft)

(autoload 'w3m-weather "w3m-weather" "Display weather report." t)
(autoload 'w3m-antenna "w3m-antenna" "Report chenge of WEB sites." t)
(setq w3m-use-form t)

;;(setq w3m-icon-directory "/usr/local/share/emacs/21.3.50/etc/w3m/icons")

(setq mime-setup-enable-inline-html nil)
(eval-after-load "mime-view"
  '(progn
     (autoload 'mime-w3m-preview-text/html "mime-w3m")
     (ctree-set-calist-strictly
      'mime-preview-condition
      '(
        (type . text)
        (subtype . html)
        (body . visible)
        (body-presentation-method . mime-w3m-preview-text/html)
        ))
     (set-alist 'mime-view-type-subtype-score-alist
                '(text . html) 3)
     ))

(provide 'init_w3m)
;;; init_w3m.el ends here
