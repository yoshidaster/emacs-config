;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_irc.el --- irc

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
;; IRCクライアントRiece
;; @see http://www.nongnu.org/riece/index.html.ja
;;
(autoload 'riece "riece" nil t)
(setq riece-username "sakito")
(setq riece-nickname "sakito")
(setq riece-server "freenode"
      riece-server-alist
      `(;;("ircnet" :host "irc.tokyo.wide.ad.jp")
        ("freenode" :host "irc.freenode.net" :coding utf-8)))
(setq riece-startup-server-list '("freenode"))
(setq riece-startup-channel-list
      '("#CodeRepos freenode"))

;(setq liece-intl-catalogue-directory "/usr/local/share/riece/")
(setq 
 riece-window-style-directory   "/usr/local/share/emacs/site-lisp/riece"
 riece-icon-directory           "/usr/local/share/emacs/site-lisp/riece"
 )

;(setq liece-server "irc.tokyo.wide.ad.jp")

(provide 'init_irc)
;;; init_irc.el ends here
