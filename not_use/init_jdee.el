;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_jdee.el --- JDEE setting

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

;;; Commentary: JDEE の設定

;; 

;;; Code:

;; JDEE を利用するための環境設定
(setenv "JAVA_HOME" "/Library/Java/Home")
(setenv "JAVA_VERSION" "1.4.2")
(setenv "ANT_HOME" "/sw/lib/ant")

;;;; JDEE [2002/06/25]
;; @see http://jdee.sunsite.dk/

;; cedet-1.0beta3bで動作確認中
;; Load CEDET
(load-file "~/.emacs.d/lisp/cedet-1.0pre6/common/cedet.el")
(setq semantic-load-turn-useful-things-on t)
(setq semanticdb-default-save-directory "~/.emacs.d/var/semantic")

;(require 'jde)
(autoload 'jde-mode "jde" "Java Development Environment for Emacs." t)
(setq auto-mode-alist
      (cons '("\\.java$" . jde-mode) auto-mode-alist)
      )
(setq bsh-jar "~/.emacs.d/lisp/jde-2.3.5.1/java/lib/bsh.jar")

;; コンパイルセッセージの縦幅
(setq compilation-window-height 8)

;; Antの設定
;(require 'jde-ant)  ;; これは不要です。書くと変数は初期化されてしまいます。
(setq jde-ant-enable-find t)
(setq jde-ant-home "/sw/lib/ant")
(setq jde-ant-program "/sw/bin/ant")
(setq jde-ant-read-target t)
(setq jde-build-function (quote (jde-ant-build)))

;; Java Server利用するコンパイラの指定

(setq jde-jdk '("1.4.2"))
(setq jde-jdk-registry '(("1.4.2" . "/Library/Java/Home")))

;; JavaDocの位置
;(setq jde-jdk-doc-url "file:///Users/sakito/doc/Java1.3.0/docs/ja/api/overview-summary.html")
(setq jde-jdk-doc-url "file:///Volumes/Text/doc/java/j2sdk-1_4_0-doc-ja/ja/api/overview-summary.html")
(setq jde-help-docsets
            '(("JDK API"
               "file:///Volumes/Text/doc/java/j2sdk-1_4_0-doc-ja/ja/api/"
               w3m-browse-url)))


;;; 以下はデバッグ用

; Symbol's function definition is void: semantic-map-buffers
; が出る場合
; http://sourceforge.net/tracker/index.php?func=detail&aid=619758&group_id=17886&atid=117886
; M-x locate-library semantic-util-modes RET
; M-x locate-library semantic-util RET
;(setq semantic-load-turn-everything-on t)
;(require 'semantic-load)



;; 変数初期化防止処理
;(eval-after-load "jde"
;    '(defun jde-set-variables-init-value (&optional msg)))

;(eval-after-load "jde"
;  '(progn
;    ;'(defun jde-set-variables-init-value (&optional msg))
;     (defvar jde-compilation-enter-directory-regexp-alist
;       '(
;         ;; Matches lines printed by the `-w' option of GNU Make.
;         (".*: Entering directory `\\(.*\\)'$" 1)
;         ;; Matches lines made by Emacs byte compiler.
;         ("^Entering directory `\\(.*\\)'$" 1)
;         )
;       "Alist specifying how to match lines that indicate a new current directory.
;Note that the match is done at the beginning of lines.
;Each elt has the form (REGEXP IDX).
;If REGEXP matches, the IDX'th subexpression gives the directory name.
;
;The default value matches lines printed by the `-w' option of GNU Make.")
;
;     (defvar jde-compilation-leave-directory-regexp-alist
;       '(
;         ;; Matches lines printed by the `-w' option of GNU Make.
;         (".*: Leaving directory `\\(.*\\)'$" 1)
;         ;; Matches lines made by Emacs byte compiler.
;         ("^Leaving directory `\\(.*\\)'$" 1)
;         )
;       "Alist specifying how to match lines that indicate restoring current directory.
;Note that the match is done at the beginning of lines.
;Each elt has the form (REGEXP IDX).
;If REGEXP matches, the IDX'th subexpression gives the name of the directory
;being moved from.  If IDX is nil, the last directory entered \(by a line
;matching `compilation-enter-directory-regexp-alist'\) is assumed.
;
;The default value matches lines printed by the `-w' option of GNU Make.")
;
;     (defvar jde-compilation-file-regexp-alist
;       '(
;         ;; This matches entries with date time year file-name: like
;         ;; Thu May 14 10:46:12 1992  mom3.p:
;         ("\\w\\w\\w \\w\\w\\w +[0-9]+ [0-9][0-9]:[0-9][0-9]:[0-9][0-9] [0-9][0-9][0-9][0-9]  \\(.*\\):$" 1)
;         )
;       "Alist specifying how to match lines that indicate a new current file.
;Note that the match is done at the beginning of lines.
;Each elt has the form (REGEXP IDX).
;If REGEXP matches, the IDX'th subexpression gives the file name.  This is
;used with compilers that don't indicate file name in every error message.")
;
;     ;; There is no generally useful regexp that will match non messages, but
;     ;; in special cases there might be one. The lines that are not matched by
;     ;; a regexp take much longer time than the ones that are recognized so if
;     ;; you have same regexeps here, parsing is faster.
;     (defvar jde-compilation-nomessage-regexp-alist
;       '(
;         )
;       "Alist specifying how to match lines that have no message.
;Note that the match is done at the beginning of lines.
;Each elt has the form (REGEXP).  This alist is by default empty, but if
;you have some good regexps here, the parsing of messages will be faster.")
;
;  ))

;(eval-after-load "jde"
;  '(defun jde-set-variables-init-value ()
;     "Set each JDE variable to the value it has at Emacs startup."
;     (message "No more Setting JDE variables to startup values..."))

;(defmacro jde-setq (symbol value)
;   "`jde-set-variables-init-value' による上書きを防ぐための setq 代替関数."
;   `(eval-after-load "jde"
;      '(defcustom ,symbol ,value "this option is changed by jde-setq.")))

;; 起動時に custom 値を読み直させる
;(add-hook 'jde-mode-hook 'jde-set-variables-init-value)



;; Java Serverを利用しない場合のコンパイラの指定
;(setq jde-compiler (list "javac" ""))

;; クラスパス
(setq jde-global-classpath '(
                             "/sw/share/java/junit/junit.jar"
                             "/sw/share/java/log4j/log4j-core.jar"
                             "/sw/share/java/log4j/log4j.jar"
                             "/sw/lib/xalan-j/xalan.jar"
                             "/sw/lib/xalan-j/xml-apis.jar"
                             "/sw/lib/xerces-j/xercesSamples.jar"
                             "/sw/lib/xerces-j/xerces.jar"
                             "/Users/sakito/lib/lisp/jde-2.3.3/java/lib"
;                             "/Users/sakito/lib/lisp/jde/java/lib"
                             "/Users/sakito/lib/java/servlet.jar"
                             "/Users/sakito/lib/java/struts.jar"
                             "/Users/sakito/lib/java/commons-jxpath-1.1b1.jar"
                             "/Users/sakito/lib/java/itext-0.96.jar"
                             "/Users/sakito/lib/java/iTextAsian.jar"
                             "."
                             ))

;; checkstyleの形式
;; M-x checkstyleの形式がカスタマイズ可能です。
(setq jde-checkstyle-option-rcurly  (list "alone"))

;; hookの設定
(add-hook 'java-mode-hook
          '(lambda()
;             (setenv "LC_ALL" "en")
             (setq indent-tabs-mode nil)
             (setq c-basic-offset 4)
             (setq c-set-style "java")

             ;; Antの設定
             ;(setq jde-ant-enable-find t)
             ;(setq jde-ant-home "/sw/lib/ant")
             ;(setq jde-ant-program "/sw/bin/ant")
             ;(setq jde-ant-read-target t)
             ;(setq jde-build-function (quote (jde-ant-build)))
             ))

;(setq c-default-style "k&r")
;(add-hook 'c-mode-common-hook
;         '(lambda ()
;             (progn
               ;(c-toggle-hungry-state 1)
;               (setq c-basic-offset 4 indent-tabs-mode nil))))

(provide 'init_jdee)
;;; init_jdee.el ends here
