
;;; Commentary: 環境変数関連の設定

;;; Code:

;; PATH設定
;; Mac OS X の bash の PATH は /usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:
;; 多数の実行環境にて極力汎用的にパスが設定されるようしたい
(dolist (dir (list
               "~/perl5/perlbrew/bin"
               "/sbin"
               "/usr/sbin"
               "/bin"
               "/usr/bin"
               "/sw/bin"
               "/opt/local/bin"
               "/usr/local/bin"
               (expand-file-name "~/bin")
               (expand-file-name "~/local/bin")
               (expand-file-name "~/.emacs.d/bin")
               ))
  (when (and (file-exists-p dir) (not (member dir exec-path)))
    (setenv "PATH" (concat dir ":" (getenv "PATH")))
    (setq exec-path (append (list dir) exec-path))))

(setenv "MANPATH" (concat "/usr/local/man:/usr/share/man:/Developer/usr/share/man:/sw/share/man" (getenv "MANPATH")))

(setenv "JAVA_OPTS" "-Dfile.encoding=UTF-8")

(setenv "CVS_RSH" "ssh")
(setenv "DISPLAY" "localhost")
(setenv "SSH_AUTH_SOCK" (getenv "SSH_AUTH_SOCK"))
(setenv "LC_ALL" "ja_JP.UTF-8")

(provide 'init_setenv)
;;; init_setenv.el ends here
