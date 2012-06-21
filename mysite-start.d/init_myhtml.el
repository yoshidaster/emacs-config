;;; html-helper-mode
;; @see http://www.gest.unipd.it/~saint/hth.html
;; @see http://www.gest.unipd.it/~saint/hhm-documentation.htm
(autoload 'html-helper-mode "html-helper-mode" "Yay HTML" t)
(setq auto-mode-alist
      (append '(("\\.html$" . html-helper-mode)
                ("\\.inc$" . html-helper-mode)
                ) auto-mode-alist))

(setq html-helper-htmldtd-version "<!DOCTYPE HTML PUBLIC \"-//W3C//DTD HTML 4.01//EN\"
    \"http://www.w3.org/TR/html4/strict.dtd\">\n")

(require 'html-tt)
(add-hook 'html-helper-mode-hook 'html-tt-load-hook)

;; change sequence face
;; (make-face 'my-sequence-face)
;; (set-face-foreground 'my-sequence-face "blue")
;; (set-face-background 'my-sequence-face "bisque")
;; (setq html-tt-sequence-face 'my-sequence-face)
;; or
;; (setq html-tt-sequence-face 'bold)
;; (setq html-tt-sequence-face 'italic)
(setq html-tt-sequence-face 'underline)

;; change sequence for insert
(setq html-tt-sequence-start "[% ")
(setq html-tt-sequence-end " %]")

(defun my-html-helper-mode-hook-func ()
  "Hook function for html-helper-mode"
  (interactive)
  (font-lock-mode 1)
  ;; C-cC-pd inserts "<div></div>"
  (html-helper-add-tag
   '(phys "d" "<div>" "div" ("<div>" 'r "</div>\n") "Div tag"))
  ;; Disable Fontifying... message
  (setq html-helper-verbose nil))

(add-hook 'html-helper-mode-hook 'my-html-helper-mode-hook-func)

(provide 'init_myhtml)
;;; init_html.el ends here
