;; 利用する環境共通の設定

;;; Code:

;;; 初期位置
(cd "~/")

;;; menubar
;(menu-bar-mode nil)
;;; toolbar
(tool-bar-mode 0)

;; 警告を視覚的にする
; (setq visible-bell t)

;; emacsclient を利用するためにサーバ起動
;; サーバが起動していた場合は先に起動していた方を優先
(require 'server)
(unless (server-running-p) (server-start))
(setq server-visit-hook
      '(lambda () 
         ;; Frame を前面にする
         (raise-frame (selected-frame))
         ;; キーボードフォーカスを選択しているFrameにする
         (x-focus-frame (selected-frame))))

;;起動時のmessageを表示しない
;; (setq inhibit-startup-message t)
;; scratch のメッセージを空にする
(setq initial-scratch-message nil)

; 印刷の設定
(setq ps-multibyte-buffer 'non-latin-printer)

; 自動改行関連
(setq-default auto-fill-mode nil)
(setq-default fill-column 300)
(setq text-mode-hook 'turn-off-auto-fill)

;;; help key変更
;; BackSpaceをC-hに変更
(global-set-key "\M-?" 'help-for-help)
(global-set-key "\C-h" 'backward-delete-char)

;; 編集関連

;; モードラインにライン数、カラム数表示
(line-number-mode t)
(column-number-mode t)

;; モードラインにカレントディレクトリを表示
(push '("" default-directory "-") global-mode-string)

;; リージョンを kill-ring に入れないで削除できるようにする
(delete-selection-mode t)

;; TAB はスペース 4 個ぶんを基本
(setq-default tab-width 4)
(setq-default indent-tabs-mode nil)

;; ¥の代わりにバックスラッシュを入力する
(define-key global-map [?¥] [?\\])

;; 対応するカッコを色表示する
;; 特に色をつけなくてもC-M-p、C-M-n を利用すれば対応するカッコ等に移動できる
(show-paren-mode t)
;; カッコ対応表示のスタイル
;; カッコその物に色が付く(デフォルト)
;; (setq show-paren-style 'parenthesis)
;; カッコ内に色が付く
;; (setq show-paren-style 'expression)
;; 画面内に収まる場合はカッコのみ、画面外に存在する場合はカッコ内全体に色が付く
;; (setq show-paren-style 'mixed)

;;動的略語展開で大文字小文字を区別
(setq dabbrev-case-fold-search nil)

;; 前回のカーソル位置を記憶
(require 'saveplace)
(setq-default save-place t)
(setq save-place-file "~/.emacs.d/var/places.txt")

;;新規行を作成しない
;;emacs21ではデフォルトで設定されています。
(setq next-line-add-newlines nil)

;; C-x C-b でバッファリストを開く時に、ウィンドウを分割しない
(global-set-key "\C-x\C-b" 'buffer-menu)

;; スクロールのマージン
;; 一行ずつスクロールする
(setq scroll-conservatively 35)
(setq scroll-margin 0)
(setq scroll-step 1)
(setq comint-scroll-show-maximum-output t)

;; ファイルを編集した場合コピーにてバックアップする
;; inode 番号を変更しない
(setq backup-by-copying t)
;;; バックアップファイルの保存位置指定[2002/03/02]
;; !path!to!file-name~ で保存される
(setq backup-directory-alist
      '(
        ("^/etc/" . "~/.emacs.d/var/etc")
        ("." . "~/.emacs.d/var/emacs")
        ))

;; バックアップファイルを作らない
; (setq make-backup-files nil)
;; .save.. ってなファイルを作らない
; (setq auto-save-list-file-name nil)
; (setq auto-save-list-file-prefix nil)

;; 同一名の buffer があったとき、開いているファイルのパスの一部を表示して区別する
(when (locate-library "uniquify")
  (load-safe "uniquify")
  (setq uniquify-buffer-name-style 'post-forward-angle-brackets))

;; 終了時に聞く
(setq confirm-kill-emacs 'y-or-n-p)

;; comment/uncomment-regeon
;; C-x ; でコメントアウト
;; C-x : でコメントをはずす
(global-set-key "\C-x;" 'comment-region)
(fset 'uncomment-region "\C-u\C-[xcomment-region\C-m")
(global-set-key "\C-x:" 'uncomment-region)

;; ブックマーク情報を保存するファイル名
(setq bookmark-default-file "~/.emacs.d/var/ebookm.txt")

;; shebangが付いているファイルのパーミッションを保存時に +x にする
(add-hook 'after-save-hook
          'executable-make-buffer-file-executable-if-script-p)

;; 画像を表示
(auto-image-file-mode)

;; iswitchb
(iswitchb-mode 1)
;; (cond ((string-match "22." emacs-version)
;;        (iswitchb-mode 1))
;;       ((string-match "21." emacs-version)
;;        (iswitchb-default-keybindings)))
(defadvice iswitchb-exhibit
  (after
   iswitchb-exhibit-with-display-buffer
   activate)
  (when (and
         (eq iswitchb-method iswitchb-default-method)
         iswitchb-matches)
    (select-window
     (get-buffer-window (cadr (buffer-list))))
    (let ((iswitchb-method 'samewindow))
      (iswitchb-visit-buffer
       (get-buffer (car iswitchb-matches))))
    (select-window (minibuffer-window))))

(add-hook 'iswitchb-define-mode-map-hook
          (lambda ()
            (define-key iswitchb-mode-map "\C-n" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-p" 'iswitchb-prev-match)
            (define-key iswitchb-mode-map "\C-f" 'iswitchb-next-match)
            (define-key iswitchb-mode-map "\C-b" 'iswitchb-prev-match)))

;; diredを編集可能にする
(require 'wdired)
(define-key dired-mode-map "r" 'wdired-change-to-wdired-mode)

;; 前回終了時のバッファ(全て)を復元したい
;; http://www.gentei.org/~yuuji/software/
;; http://www.bookshelf.jp/soft/meadow_30.html#SEC395
;; http://www.hasta-pronto.org/archives/2008/01/30-0235.php
;; windows.el
(setq win:switch-prefix "\C-z")
(define-key global-map win:switch-prefix nil)
(define-key global-map "\C-z1" 'win-switch-to-window)
(require 'windows)
(setq win:use-frame nil)
(win:startup-with-window)
(define-key ctl-x-map "C" 'see-you-again)

;; egg
(require 'egg)

;; riece
(setq riece-default-coding-system 'utf-8)

;; revive.el
(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)

(autoload 'save-current-configuration "revive" "Save status" t)
(autoload 'resume "revive" "Resume Emacs" t)
(autoload 'wipe "revive" "Wipe emacs" t)
(define-key ctl-x-map "F" 'resume)
(define-key ctl-x-map "K" 'wipe)
(add-hook 'kill-emacs-hook 'save-current-configuration)

;; emacsclient終了する時にTerminalへ
(add-hook 'server-done-hook
          (lambda ()
            (do-applescript "tell application \"iTerm.app\"
                                activate
                             end")))

(provide 'init_global)
;;; init_global.el ends here
