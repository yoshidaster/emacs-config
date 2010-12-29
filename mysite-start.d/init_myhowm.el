;; howm
;; http://howm.sourceforge.jp/index-j.html
(setq howm-menu-lang 'ja)
(global-set-key "\C-c,," 'howm-menu)
;; (autoload 'howm-menu "howm-mode" "Hitori Otegaru Wiki Modoki" t)
;; http://www.bookshelf.jp/soft/meadow_38.html#SEC549
(mapc
 (lambda (f)
   (autoload f
     "howm-mode" "Hitori Otegaru Wiki Modoki" t))
 '(howm-menu howm-list-all howm-list-recent
             howm-list-grep howm-create
             howm-keyword-to-kill-ring))
;; リンクを TAB で辿る
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map [tab] 'action-lock-goto-next-link)
     (define-key howm-mode-map [(meta tab)] 'action-lock-goto-previous-link)))
;; 「最近のメモ」一覧時にタイトル表示
(setq howm-list-recent-title t)
;; 全メモ一覧時にタイトル表示
(setq howm-list-all-title t)
;; メニューを 2 時間キャッシュ
(setq howm-menu-expiry-hours 2)

;; howm の時は auto-fill で
(add-hook 'howm-mode-on-hook 'auto-fill-mode)

;; RET でファイルを開く際, 一覧バッファを消す
;; C-u RET なら残る
(setq howm-view-summary-persistent nil)

;; メニューの予定表の表示範囲
;; 10 日前から
(setq howm-menu-schedule-days-before 10)
;; 3 日後まで
(setq howm-menu-schedule-days 3)

;; howm ¤Î¥Õ¥¡¥¤¥ëÌ¾
;; 1 メモ 1 ファイル (デフォルト)
(setq howm-file-name-format "%Y/%m/%Y-%m-%d-%H%M%S.howm")
;; 1 日 1 ファイルであれば
;; (setq howm-file-name-format "%Y/%m/%Y-%m-%d.howm")

(setq howm-view-grep-parse-line
      "^\\(\\([a-zA-Z]:/\\)?[^:]*\\.howm\\):\\([0-9]*\\):\\(.*\\)$")
;; 検索しないファイルの正規表現
(setq
 howm-excluded-file-regexp
 "/\\.#\\|[~#]$\\|\\.bak$\\|/CVS/\\|\\.doc$\\|\\.pdf$\\|\\.ppt$\\|\\.xls$")

;; いちいち消すのも面倒なので
;; 内容が 0 ならファイルごと削除する
(if (not (memq 'delete-file-if-no-contents after-save-hook))
    (setq after-save-hook
          (cons 'delete-file-if-no-contents after-save-hook)))
(defun delete-file-if-no-contents ()
  (when (and
         (buffer-file-name (current-buffer))
         (string-match "\\.howm" (buffer-file-name (current-buffer)))
         (= (point-min) (point-max)))
    (delete-file
     (buffer-file-name (current-buffer)))))

;; http://howm.sourceforge.jp/cgi-bin/hiki/hiki.cgi?SaveAndKillBuffer
;; C-cC-c で保存してバッファをキルする
(defun my-save-and-kill-buffer ()
  (interactive)
  (when (and
         (buffer-file-name)
         (string-match "\\.howm"
                       (buffer-file-name)))
    (save-buffer)
    (kill-buffer nil)))
(eval-after-load "howm-mode"
  '(progn
     (define-key howm-mode-map
       "\C-c\C-c" 'my-save-and-kill-buffer)))
;; メニューを自動更新しない
(setq howm-menu-refresh-after-save nil)
;; 下線を引き直さない
(setq howm-refresh-after-save nil)
;; 日付の入力
(eval-after-load "calendar"
  '(progn
     (define-key calendar-mode-map
       "\C-m" 'my-insert-day)
     (defun my-insert-day ()
       (interactive)
       (let ((day nil)
             (calendar-date-display-form
              '("[" year "-" (format "%02d" (string-to-int month))
                "-" (format "%02d" (string-to-int day)) "]")))
         (setq day (calendar-date-string
                    (calendar-cursor-to-date t)))
         (exit-calendar)
         (insert day)))))
;; アウトラインとの組み合わせ
;; (autoload 'howm-mode
;;   "howm-mode" "Hitori Otegaru Wiki Modoki" t)
(defadvice howm-mode
  (before outline-minor activate)
  (outline-minor-mode t))
(require 'outline)
(defun my-outline-flip-subtree (&optional dummy)
  (interactive)
  (if (save-excursion
        (forward-line 1)
        (let ((p (overlays-at (line-beginning-position)))
              (ol nil))
          (while (and p (not ol))
            (setq ol (overlay-get (car p) 'invisible))
            (setq p (cdr p)))
          ol))
      (show-subtree)
    (hide-subtree)))
(defun add-my-action-lock-rule ()
  (let ((rule
         (action-lock-general
          'my-outline-flip-subtree
          (if (and
               buffer-file-name
               (string-match "\\.howm$" buffer-file-name))
              "^ *\\(\\*\\**\\)"
            (concat "\\(" outline-regexp "\\)"))
          1 1)))
    (if (not (member rule action-lock-default-rules))
        (progn (setq action-lock-default-rules
                     (cons rule action-lock-default-rules))
               (action-lock-set-rules action-lock-default-rules)))))
(add-hook 'action-lock-mode-on-hook 'add-my-action-lock-rule)

(provide 'init_myhowm)
