;;; init_speedbar.el --- speedbar

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

;; speedbar の設定

;;; Code:
(require 'sr-speedbar nil t)
(setq sr-speedbar-width-x 40)
(setq sr-speedbar-width-console 24)
(setq sr-speedbar-delete-windows nil)

(global-set-key (kbd "C-^") 'sr-speedbar-toggle)

(setq speedbar-use-images nil)
(setq speedbar-frame-parameters '((minibuffer)
                                  (width . 40)
                                  (border-width . 0)
                                  (menu-bar-lines . 0)
                                  (tool-bar-lines . 0)
                                  (unsplittable . t)
                                  (left-fringe . 0)))
(setq speedbar-default-position 'left-right)
(setq speedbar-hide-button-brackets-flag t)

;; 拡張子
(add-hook 'speedbar-mode-hook
          '(lambda ()
             (speedbar-add-supported-extension '("js" "as" "html" "css" "php" "rst" "howm" "org" "ml" "scala"))))

(provide 'init_speedbar)
;;; init_speedbar.el ends here
