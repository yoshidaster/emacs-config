;; ddskk
(setq mac-pass-control-to-system nil)
(require 'skk-setup)
(require 'skk-study)
;; C-j の機能を別のキーに割り当て
(global-set-key (kbd "C-m") 'newline-and-indent)
;; C-\ でも SKK に切り替えられるように設定
(setq default-input-method "japanese-skk")
;; 送り仮名が厳密に正しい候補を優先して表示
(setq skk-henkan-strict-okuri-precedence t)
;;漢字登録時、送り仮名が厳密に正しいかをチェック
(setq skk-check-okurigana-on-touroku t)
;; skk-server
(setq skk-server-host "localhost")
(setq skk-server-portnum 1178)

(provide 'init_myskk)

