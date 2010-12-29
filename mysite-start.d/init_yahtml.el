(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist
      (append '(("\\.html$" . html-helper-mode)
                ("\\.inc$" . html-helper-mode)
                ("\\.tmpl$" . html-helper-mode)) auto-mode-alist))

;; html-tt: Template-Toolkit (html-helper-modeのマイナーモード)
(require 'html-tt)
(add-hook 'html-helper-mode-hook 'html-tt-load-hook)
;; change sequence face
(make-face 'my-sequence-face)
(set-face-foreground 'my-sequence-face "blue")
(set-face-background 'my-sequence-face "bisque")
(setq html-tt-sequence-face 'my-sequence-face)
;; or
(setq html-tt-sequence-face 'bold)
(setq html-tt-sequence-face 'italic)
(setq html-tt-sequence-face 'underline)
;; change sequence for insert
(setq html-tt-sequence-start "[% ")
(setq html-tt-sequence-end " %]")

(provide 'init_yahtml)
