(require 'browse-url)
(require 'thingatpt)
;; w3m-url-encode-string $B$N(B rename $BHG(B (w3m.el $B$rF~$l$F$J$$$+$i(B)
(defun my-url-encode-string (str &optional coding)
  (apply (function concat)
         (mapcar
          (lambda (ch)
            (cond
             ((eq ch ?\n)               ; newline
              "%0D%0A")
             ((string-match "[-a-zA-Z0-9_:/]" (char-to-string ch)) ; xxx?
              (char-to-string ch))      ; printable
             ((char-equal ch ?\x20)     ; space
              "+")
             (t
              (format "%%%02X" ch))))   ; escape
          ;; Coerce a string to a list of chars.
          (append (encode-coding-string (or str "") (or coding 'iso-2022-jp))
                  nil))))

;; google $B$G8!:w!#0z?tL5$7$@$H(B mini-buffer $B$GJT=8$G$-$k!#(B
(defun google (str &optional flag)
  "google $B$G8!:w!#0z?tL5$7$@$H(B mini-buffer $B$GJT=8$G$-$k!#(B"
  (interactive
   (list (cond ((or
                 ;; mouse drag $B$N8e$G8F$S=P$5$l$?>l9g(B
                 (eq last-command 'mouse-drag-region) ; for emacs
                 (and (eq last-command 'mouse-track) ; for xemacs
                      (boundp 'primary-selection-extent)
                      primary-selection-extent)
                 ;; region $B$,3h@-(B
                 (and (boundp 'transient-mark-mode) transient-mark-mode
                      (boundp 'mark-active) mark-active) ; for emacs
                 (and (fboundp 'region-active-p)
                      (region-active-p)) ; for xemacs
                 ;; point $B$H(B mark $B$rF~$lBX$($?8e(B
                 (eq last-command 'exchange-point-and-mark))
                (buffer-substring-no-properties
                 (region-beginning) (region-end)))
               (t (thing-at-point 'word)))
         current-prefix-arg))
  (if flag
      nil
    (setq str (read-from-minibuffer "Search word: " str)))
  (browse-url
   (concat
    "http://www.google.com/search?q="
    (my-url-encode-string str 'shift_jis)
    "&hl=ja&ie=Shift_JIS&lr=lang_ja")))