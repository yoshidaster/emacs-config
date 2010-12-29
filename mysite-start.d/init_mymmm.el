;;; mmm-mode
;; @see http://mmm-mode.sourceforge.net/
(require 'mmm-mode)

(setq mmm-global-mode 'maybe)
;; 色設定．これは，好みで．色をつけたくないなら nil にします．
(set-face-background 'mmm-default-submode-face "navy")

(mmm-add-classes
 '(
   (mmm-ml-css-mode
    :submode css-mode
    :face mmm-code-submode-face
    :front "<style[^>]*>"
    :back "\n?[ \t]*</style>"
    :insert ((?c mmm-ml-css-mode nil @ "<style type=\"text/css\">"
                 @ "\n" _ "\n" @ "</style>" @))
    )
   (mmm-ml-javascript-mode
    :submode javascript-mode
    :face mmm-code-submode-face
    :front "<script[^>]*type=\"text/javascript\"[^>]*>[^<]"
    :front-offset -1
    :back "\n?[ \t]*</script>"
    :insert ((?j mmm-ml-javascript-mode nil @ "<script type=\"text/javascript\">"
                 @ "\n" _ "\n" @ "</script>" @))
    )
   ))

(mmm-add-mode-ext-class 'html-helper-mode nil 'mmm-ml-css-mode)
(mmm-add-mode-ext-class 'html-helper-mode nil 'mmm-ml-javascript-mode)

(provide 'init_mymmm)

