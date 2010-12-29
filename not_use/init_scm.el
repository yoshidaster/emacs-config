;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_scm.el --- vcs and scm

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

;; VCS および SCM 関連

;;; Code:

;; vc
;; vc はすばらしいがわたしは利用しないので無効にする
(setq vc-handled-backends nil)
;; シンボリックリンク先がバージョン管理されていても確認しないでリンク先の実ファイルを開く
(setq vc-follow-symlinks t)

;; hg
;; @see http://bitbucket.org/agriggio/ahg/src/tip/ahg.el
(setenv "HGENCODING" "utf-8")
(require 'ahg)

;; svn
;; @see http://svn.apache.org/repos/asf/subversion/trunk/contrib/client-side/emacs/dsvn.el
(autoload 'svn-status "dsvn" "Run `svn status'." t)
(autoload 'svn-update "dsvn" "Run `svn update'." t)

;; git
;; @see http://gitorious.org/magit/
(require 'magit)

;; bzr
;; private で確認中

;; trac
;; private で確認中


(provide 'init_scm)
;;; init_scm.el ends here
