;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_xslt.el --- XSLT setting

;; Copyright (C) 2004  sakito

;; Author: sakito <sakito@sakito.com>

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

;;; Commentary: XSLTを便利に利用するための設定

;; 

;;; Code:

;;; xslide
;; http://sourceforge.net/projects/xslide
;(autoload 'xsl-mode "xslide" "Major mode for XSL stylesheets." t)
(require 'xslide)
(add-hook 'xsl-mode-hook
          'turn-on-font-lock)
(setq auto-mode-alist
      (append
       (list
        '("\\.fo" . xsl-mode)
        '("\\.xsl" . xsl-mode))
       auto-mode-alist))

(setq xsl-process-command
      (append
       '("xsltproc %s %i -o %o")
       '("java org.apache.xalan.xslt.Process -IN %i -XSL %s -OUT %o")
       xsl-process-command))

;;; XSLT-process
;; http://xslt-process.sourceforge.net/
(add-to-list 'load-path (expand-file-name "~/.emacs.d/lisp/xslt-process-2.2/lisp"))
(autoload 'xslt-process-mode "xslt-process" "Emacs XSLT processing" t)
(autoload 'xslt-process-install-docbook "xslt-process"
  "Register the DocBook package with XSLT-process" t)
(add-hook 'sgml-mode-hook 'xslt-process-mode)
(add-hook 'xml-mode-hook 'xslt-process-mode)
(add-hook 'xsl-mode-hook 'xslt-process-mode)

(defadvice xml-mode (after run-xml-mode-hooks act)
  "Invoke `xml-mode-hook' hooks in the XML mode."
  (run-hooks 'xml-mode-hook))

(setq xslt-process-current-processor "Xalan")
;; make xml files writeable, they are not by default, why?
(add-hook 'xml-mode-hook
          (lambda ()
            (toggle-read-only -1)
            ))

(provide 'init_xslt)
;;; init_xslt.el ends here
