;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_php.el --- php-mode

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

;; php-mode

;;; Code:
(autoload 'php-mode "php-mode" "major mode for editing PHP code" t)
(add-to-list 'auto-mode-alist '("\\.php[s34]?\\'" . php-mode))

;; php.ini に error_reporting = E_ERROR|E_COMPILE_ERROR|E_CORE_ERROR|E_PARSE
;; 等を設定すると詳細なエラーが出ます
(defun flymake-php-init ()
  "PHP の文法チェック."
  (let* ((temp-file (flymake-init-create-temp-buffer-copy
                     'flymake-create-temp-inplace))
         (local-file (file-relative-name
                      temp-file
                      (file-name-directory buffer-file-name))))
    (list "php" (list "-f" local-file "-l"))))

(add-to-list 'flymake-err-line-patterns
             '("\\(Parse\\|Fatal\\) error: +\\(.*?\\) in \\(.*?\\) on line \\([0-9]+\\)$" 3 4 nil 2))

(add-hook  'php-mode-hook
           (lambda ()
             ;; インデントの設定
             (setq php-mode-force-pear t)
             ;; flymake
             (push '("\\.php$" flymake-php-init) flymake-allowed-file-name-masks)
             (if (and (not (null buffer-file-name)) (file-writable-p buffer-file-name))
                 (flymake-mode t))
             ;; 実行関連 一部エラーになるがとりあえず
             (require 'php-eval)
             (define-key php-mode-map (kbd "C-x C-e") 'php-eval-delimiter)
             (define-key php-mode-map (kbd "C-c C-i") 'php-eval-insert-delimiter)
             (define-key php-mode-map (kbd "C-c C-x") 'php-eval-tag)
             (define-key php-mode-map (kbd "C-c C-e") 'php-eval-last-tag)
             (define-key php-mode-map (kbd "C-c C-r") 'php-eval-region)
             (define-key php-mode-map (kbd "C-c C-v") 'php-eval-display-buffer)
             ;; php の補完
             (require 'php-completion)
             (php-completion-mode t)
             (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
             (when (require 'auto-complete nil t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list 'ac-sources 'ac-source-php-completion)
               (auto-complete-mode t))))

(provide 'init_php)
;;; init_php.el ends here
