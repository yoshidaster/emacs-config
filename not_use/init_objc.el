;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_objc.el --- objc

;; Copyright (C) 2009-2010  sakito

;; Author: sakito <sakito@sakito.com>
;; Keywords: languages

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
(when (or mac-p ns-p carbon-p)

;; XCode 側設定
;; 環境設定->ファイルタイプ-> text -> sourcecode -> sourcecode.c -> その他 -> Emacs.app
;; 「その他」から選択すること。デフォルトに存在する emacs は Terminal.app が起動してしまう
;; 通常は以下を設定しないとフレームが新規作成される。パッチを当てていると不要
(when ns-p
  (setq ns-pop-up-frames nil))

;; 拡張子が m もしくは mm のファイルは matlab-mode とぶつかる
;; 拡張子が h のファイルをそのまま設定してしまうと C や C++ 開発で困る
;(add-to-list 'auto-mode-alist '("\\.mm?$" . objc-mode))
;(add-to-list 'auto-mode-alist '("\\.h$" . objc-mode))

;; magic-mode-alist を利用してファイル内容を解析してモード設定する
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@implementation" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@interface" . objc-mode))
(add-to-list 'magic-mode-alist '("\\(.\\|\n\\)*\n@protocol" . objc-mode))

;; init_ac がロードされている前提になっている
(ac-company-define-source ac-source-company-xcode company-xcode)

;; ヘッダファイルを開くには ヘッダファイルにカーソル併せて C-x C-f すれば良い
;; 上手く動作しないなら (ffap-bindings) を init.el に記述する

 (defun xcode:buildandrun ()
  (interactive)
  (do-applescript
   (format
    (concat
     "tell application \"Xcode\" to activate \r"
     "tell application \"System Events\" \r"
     "     tell process \"Xcode\" \r"
     "          key code 36 using {command down} \r"
     "    end tell \r"
     "end tell \r"
     ))))

;; 関連ファイルを開く
;; (require 'find-file)
;; (add-to-list 'ff-other-file-alist '("\\.mm?$" (".h")))
;; (add-to-list 'ff-other-file-alist '("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm")))
(setq ff-other-file-alist
      '(("\\.mm?$" (".h"))
        ("\\.cc$"  (".hh" ".h"))
        ("\\.hh$"  (".cc" ".C"))

        ("\\.c$"   (".h"))
        ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

        ("\\.C$"   (".H"  ".hh" ".h"))
        ("\\.H$"   (".C"  ".CC"))

        ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
        ("\\.HH$"  (".CC"))

        ("\\.cxx$" (".hh" ".h"))
        ("\\.cpp$" (".hpp" ".hh" ".h"))

        ("\\.hpp$" (".cpp" ".c"))))

;; flymake
(defvar xcode:gccver "4.0")
(defvar xcode:sdkver "3.1.2")
(defvar xcode:sdkpath "/Developer/Platforms/iPhoneSimulator.platform/Developer")
(defvar xcode:sdk (concat xcode:sdkpath "/SDKs/iPhoneSimulator" xcode:sdkver ".sdk"))
(defvar flymake-objc-compiler (concat xcode:sdkpath "/usr/bin/gcc-" xcode:gccver))
;;(defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-x" "objective-c" "-std=c99"))
(defvar flymake-objc-compile-default-options (list "-Wall" "-Wextra" "-fsyntax-only" "-ObjC" "-std=c99" "-isysroot" xcode:sdk))
(defvar flymake-last-position nil)
(defcustom flymake-objc-compile-options '("-I.")
  "Compile option for objc check."
  :group 'flymake
  :type '(repeat (string)))

(defun flymake-objc-init ()
 (let* ((temp-file (flymake-init-create-temp-buffer-copy
                    'flymake-create-temp-inplace))
        (local-file (file-relative-name
                     temp-file
                     (file-name-directory buffer-file-name))))
   (list flymake-objc-compiler (append flymake-objc-compile-default-options flymake-objc-compile-options (list local-file)))))

;; ドキュメントの参照
(require 'xcode-document-viewer)
(setq xcdoc:document-path "/Developer/Platforms/iPhoneOS.platform/Developer/Documentation/DocSets/com.apple.adc.documentation.AppleiPhone3_1.iPhoneLibrary.docset")
(setq xcdoc:open-w3m-other-buffer t)

;; hook の設定
(require 'xcode)
(add-hook 'objc-mode-hook
          (lambda ()
;;            (define-key objc-mode-map (kbd "\t") 'ac-complete)
            (define-key objc-mode-map (kbd "M-/") 'ac-complete)
            (define-key objc-mode-map (kbd "C-c C-c") 'xcode:build-compile)
            (define-key objc-mode-map (kbd "C-c C-r") 'xcode:buildandrun)
            (define-key objc-mode-map (kbd "C-c w") 'xcdoc:ask-search)
            (define-key c-mode-base-map (kbd "C-c o") 'ff-find-other-file)
            (push '("\\.m$" flymake-objc-init) flymake-allowed-file-name-masks)
            (push '("\\.h$" flymake-objc-init) flymake-allowed-file-name-masks)
            (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                (flymake-mode t))
            ;; (which-function-mode t)
          ))

)

(provide 'init_objc)
;;; init_objc.el ends here
