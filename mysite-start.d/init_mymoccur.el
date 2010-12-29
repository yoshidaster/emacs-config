(require 'color-moccur)
(require 'moccur-edit)
(autoload 'moccur-grep "color-moccur" nil t)
(autoload 'moccur-grep-find "color-moccur" nil t)

;; スペース区切りで複数文字を検索条件に指定
(setq moccur-split-word t)

;; migemoがrequireできる環境ならmigemoを使う
; (when (require 'migemo nil t) ;第三引数がnon-nilだとloadできなかった場合にエラーではなくnilを返す
;   (setq moccur-use-migemo t))

;; 別ウィンドウで該当ファイルを開かない。エンターした場合にだけ開く
(setq moccur-grep-following-mode-toggle nil)

(require 'color-grep)

;; grep コマンドを ack に置換
; (setq grep-command "ack-grep -a --nocolor ")
;; grep-find コマンドを ack に置換
; (setq grep-find-command "ack-grep --nocolor --nogroup ")

;; 除外ファイルリスト
(setq dmoccur-exclusion-mask
      (append '("\\~$" "\\.hg\\/\*" "\\.svn\\/\*" "\\.git\\/\*" "\\.pyc$") dmoccur-exclusion-mask))

;; カーソル付近の単語をデフォルトの検索文字列とする
(setq moccur-grep-default-word-near-point t)

(setq dmoccur-use-list t)
(setq dmoccur-list
      '(
        ("dir" default-directory (".*") dir)
        ))

(provide 'init_mymoccur)
;;; init_moccur.el ends here
