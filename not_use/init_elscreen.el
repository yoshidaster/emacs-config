;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_elscreen.el --- elscreen

;; Copyright (C) 2009-2010 sakito

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
;;  @see http://www.morishima.net/~naoto/j/software/elscreen/
;(load "elscreen" "ElScreen" t)
(require 'elscreen)
(setq dnd-open-file-other-window nil)
;(require 'elscreen-dnd)
;(load "elscreen-wl" "ElScreen WL" t)
(require 'elscreen-server)

(provide 'init_elscreen)
;;; init_elscreen.el ends here
