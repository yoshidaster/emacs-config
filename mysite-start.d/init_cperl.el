;; CPerl-mode
;(autoload 'perl-mode "cperl-mode" "alternate mode for editing Perl programs" t)
(defalias 'perl-mode 'cperl-mode)
(setq auto-mode-alist
      (append '(("\\.pl$" . cperl-mode)
                ("\\.cgi$" . cperl-mode)
                ("\\.psgi$" . cperl-mode)
                ("\\.pm$" . cperl-mode)) auto-mode-alist))
(setq cperl-indent-level 4
      cperl-continued-statement-offset 4
      cperl-brace-offset 0
      cperl-label-offset -4
      cperl-hairy t
      cperl-comment-column 40
      cperl-merge-trailing-else t
      cperl-extra-newline-before-brace nil
      )

;; add 20060501
(setq cperl-indent-parens-as-block t
      cperl-close-paren-offset -4
      cperl-continued-brace-offset 0
      cperl-highlight-variables-indiscriminately t
      cperl-auto-newline nil
      cperl-lineup-step nil
      cperl-brace-imaginary-offset 0
      )

;;; add 20080519 : livedoor
(setq fill-column 80
      auto-fill-mode t
      cperl-tab-always-indent t)

(add-hook
 'cperl-mode-hook
 '(lambda ()
    (setq outline-regexp "\\([#\f]+\\|sub\\)")
    (setq outline-level ;this outline-level see last character
          (function
           (lambda ()
             (save-excursion
               (looking-at outline-regexp)
               (let
                   ((ca (char-to-string (char-before (match-end 0)))))
                 (cond
                  ((equal ca "b") 1) ;"sub" to top
                  (t (- (match-end 0) (match-beginning 0)))))))))
    (outline-minor-mode t)))

(setq auto-mode-alist
      (cons (cons "\\.t$" 'cperl-mode) auto-mode-alist))

;(add-hook 'cperl-mode-hook
;          (lambda ()
;            (require 'perlplus)
;            (define-key perl-mode-map "\M-\t" 'perlplus-complete-symbol)
;            (perlplus-setup)))

;; emacs-prove
(defun perl-run-test ()
  (interactive)
  (let ((compile-command "emacs-prove.pl t/"))
    (call-interactively 'compile)))

(add-hook 'cperl-mode-hook
          '(lambda ()
             (local-set-key "\C-x\C-e" 'perl-run-test)))

(setq cperl-compilation-error-regexp-alist
  '(("^[^\n]* \\(file\\|at\\) \\([^ (\t\n]+\\) [^\n]*line \\([0-9]+\\)[\\., \n]"
     2 3)))

(defun perl-eval (beg end)
  "Run selected region as Perl code"
  (interactive "r")
  (shell-command-on-region beg end "perl")
  ; feeds the region to perl on STDIN
  )
(global-set-key "\M-\C-p" 'perl-eval)

;; mode-compile
(autoload 'mode-compile "mode-compile"
   "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
   "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

(defun  perl-find-module ()
  (interactive)
  (let
      (end begin module path-to-module)
    (save-excursion
      (setq begin (save-excursion (skip-chars-backward "a-zA-Z0-9_:") (point)))
      (setq end (save-excursion (skip-chars-forward "a-zA-Z0-9_:") (point)))
      (setq module (buffer-substring begin end))
      )
    (shell-command (concat "perldoc -lm " module) "*perldoc*")
    (save-window-excursion
      (switch-to-buffer "*perldoc*")
      (setq end (point))
      (setq begin (save-excursion (beginning-of-line) (point)))
      (setq path-to-module (buffer-substring begin end))
      )
    (message path-to-module)
    (find-file path-to-module)
    ))

(add-hook 'cperl-mode-hook
          (function (lambda ()
                      (define-key cperl-mode-map "\M-_" 'perl-find-module)
                      )))

;; perltidy
(defun perltidy-region ()
  "Run perltidy on the current region."
  (interactive)
  (save-excursion
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)))

;; perltidy-mode
(autoload 'perltidy "perltidy-mode" nil t)
(autoload 'perltidy-mode "perltidy-mode" nil t)

; Makes perltidy-mode automatic for cperl-mode
;; (eval-after-load "cperl-mode"
;;   '(add-hook 'cperl-mode-hook 'perltidy-mode))

(defmacro mark-active ( )
  "Xemacs/emacs compatibility macro"
  (if (boundp 'mark-active)
      'mark-active
    '(mark)))
(defun perltidy ( )
  "Run perltidy on the current region or buffer."
  (interactive)
  ; Inexplicably, save-excursion doesn't work here.
  (let ((orig-point (point)))
    (unless (mark-active) (mark-defun))
    (shell-command-on-region (point) (mark) "perltidy -q" nil t)
    (goto-char orig-point)))
(global-set-key "\C-ct" 'perltidy)

(provide 'init_cperl)
