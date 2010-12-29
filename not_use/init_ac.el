;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_ac.el --- ac

;; Copyright (C) 2009-2010  sakito

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

;; @see http://github.com/m2ym/auto-complete
;; @see http://www.emacswiki.org/emacs/AutoComplete
;; @see http://cx4a.org/software/auto-complete/manual.ja.html
(require 'auto-complete-config)
;; デフォルト設定にしたいなら以下を記述
;; (ac-config-default)

;; デフォルトの補完候補
(set-default 'ac-sources '(ac-source-abbrev ac-source-words-in-same-mode-buffers ac-source-yasnippet))

;; 対象の全てで補完を有効にする
(global-auto-complete-mode t)

;; http://www.emacswiki.org/emacs/anything-show-completion.el
(require 'anything-show-completion)
(setq anything-show-completion-minimum-window-height 4)

;; 自動で起動するのを停止
(setq ac-auto-start nil)
;; 数字を指定すると ac が起動する文字数になる
;(setq ac-auto-start 2)

;; 起動キーの設定
(ac-set-trigger-key "TAB")

;; 待ち時間を長めに取る
(setq ac-delay 0.2)

;; 補完メニューを自動表示しない
;;(setq ac-auto-show-menu nil)
;; 以下のように設定すると待ち時間を設定する 0.8秒後に自動で表示
;;(setq ac-auto-show-menu 0.8)

;; 候補の最大件数 デフォルトは 10件
(setq ac-candidate-limit nil)

;; 補完候補のソート
(setq ac-use-comphist t)

;; クイックヘルプが表示されるとバッファが大きく変更される場合があるので停止
(setq ac-use-quick-help nil)

;; ソートファイルの保存場所を変更
(setq ac-comphist-file
      (expand-file-name (concat user-emacs-directory
                                "/var/ac-comphist.dat")))

;; @see http://nschum.de/src/emacs/company-mode/
;; @see http://github.com/buzztaiki/auto-complete/blob/master/ac-company.el
(require 'ac-company)
;; company
(ac-company-define-source ac-source-company-elisp company-elisp)
(ac-company-define-source ac-source-company-css company-css)
(ac-company-define-source ac-source-company-eclim company-eclim)
(ac-company-define-source ac-source-company-nxml company-nxml)
(ac-company-define-source ac-source-company-etags company-etags)

;; 補完対象のモードを追加
(setq ac-modes (append ac-modes '(rst-mode)))
(setq ac-modes (append ac-modes '(nxml-mode)))
(setq ac-modes (append ac-modes '(objc-mode)))
(setq ac-modes (append ac-modes '(haskell-mode)))

;; etags ファイルの候補を設定
;;(setq tags-table-list '("~/.emacs.d/share/tags/objc.TAGS" "TAGS"))
(require 'etags-table)
;; find /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS3.1.2.sdk/System/Library/Frameworks -name "*.h" | xargs etags -f obcj.TAGS -l objc
(add-to-list  'etags-table-alist
              '("\\.[mh]$" "~/.emacs.d/share/tags/objc.TAGS"))
(add-to-list  'etags-table-alist
              '("\\.c$" "~/.emacs.d/share/tags/c.TAGS"))
(add-to-list  'etags-table-alist
              '("\\.scm$" "~/.emacs.d/share/tags/gauche.TAGS"))
;; find /Library/Frameworks/Python.framework/Versions/2.6/lib/python2.6/ -name "*.py" | xargs etags -f python.TAGS -l python
;;(add-to-list  'etags-table-alist
;;              '("\\.py$" "~/.emacs.d/share/tags/python.TAGS"))
(add-to-list  'etags-table-alist
              '("\\.p[lm]$" "~/.emacs.d/share/tags/perl.TAGS"))
;; Haskell
(add-to-list  'etags-table-alist
              '("\\.hs$" "~/.emacs.d/share/tags/haskell.TAGS"))
;; Ocaml
(add-to-list  'etags-table-alist
              '("\\.ml$" "~/.emacs.d/share/tags/ocaml.TAGS"))
;; etags 補完候補
;; @see http://www.emacswiki.org/emacs/auto-complete-etags.el
;; @see http://d.hatena.ne.jp/whitypig/20100325/1269490524
(defun ac-etags-candidate ()
  (when tags-file-name
    (ignore-errors
      (let ((tags-completion-table nil))
        (all-completions ac-target (tags-completion-table))))))

(defvar ac-source-etags
  '((candidates . (lambda ()
                    (all-completions ac-target (tags-lazy-completion-table))))
                 ;; (all-completions ac-target (tags-completion-table))))
  ;; '((candidates . ac-etags-candidate)
    (candidate-face . ac-candidate-face)
    (selection-face . ac-selection-face)
    (symbol . "e")
    (requires . 3))
  "etags をソースにする")
;; objc hook
(add-hook 'objc-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            ;; 既存に存在するかを無視して先頭に追加
            ;; (push 'ac-source-c++-keywords ac-sources)
            ;; (push 'ac-source-company-xcode ac-sources)
            ;; 末尾に追加
            ;;(push 'ac-source-etags ac-sources)
            (setq ac-sources (append ac-sources '(ac-source-etags)))
            ))
;; python hook
(add-hook 'python-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            ;; 末尾に追加
            ;;(setq ac-sources (append ac-sources '(ac-source-etags)))
            ))
(add-hook 'emacs-lisp-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (push 'ac-source-variables ac-sources)
            (push 'ac-source-functions ac-sources)
            (push 'ac-source-company-elisp ac-sources)
            ))
(add-hook 'css-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (push 'ac-source-css-keywords ac-sources)
            (push 'ac-source-company-css ac-sources)))
(add-hook 'nxml-mode-hook
          (lambda ()
            (make-local-variable 'ac-sources)
            (push 'ac-source-company-nxml ac-sources)))

;; 補完を anything する
;; http://www.emacswiki.org/cgi-bin/wiki/download/ac-anything.el
(require 'ac-anything)
(define-key ac-completing-map (kbd "C-:") 'ac-complete-with-anything)

;; キー設定
;; (define-key ac-completing-map "\t" 'ac-complete)
(define-key ac-completing-map (kbd "C-m") 'ac-complete)
(define-key ac-completing-map (kbd "C-n") 'ac-next)
(define-key ac-completing-map (kbd "C-p") 'ac-previous)
(define-key ac-completing-map (kbd "M-/") 'ac-stop)

(provide 'init_ac)
;;; init_ac.el ends here
