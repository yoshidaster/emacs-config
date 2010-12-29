;;----------------------------------------------------------------
;; i-serch
;;----------------------------------------------------------------
;Searchの時に英大文字/英小文字の区別をする
; (setq case-fold-search ni)

(define-key isearch-mode-map "\C-k" 'isearch-edit-string)

;i-search中、\C-dで1文字ずつ追加
(defun isearch-yank-char ()
  "Pull next character from buffer into search string."
  (interactive)
  (isearch-yank-string
   (save-excursion
     (and (not isearch-forward) isearch-other-end
          (goto-char isearch-other-end))
     (buffer-substring (point) (1+ (point))))))
(define-key isearch-mode-map "\C-d" 'isearch-yank-char)

;i-search中、\C-bで一文字ずつ消す
(defun isearch-real-delete-char ()
  (interactive)
  (setq isearch-string
        (if (= (length isearch-string) 1)
            isearch-string
          (substring isearch-string 0 (- (length isearch-string) 1)))
        isearch-message isearch-string
        isearch-yank-flag t)
  (isearch-search-and-update))
(define-key isearch-mode-map "\C-b" 'isearch-real-delete-char)

(define-key isearch-mode-map "\M-m" 'isearch-exit)

;;RETで検索を終了した時、常にカーソル位置を検索後の後ろに
(add-hook 'isearch-mode-end-hook
          (lambda ()
            (cond
             ((eq last-input-char ?\C-m)
              (goto-char (match-end 0)))
             ((eq last-input-char ?\M-m)
              (goto-char (match-beginning 0))))))

;;\C-oで検索中の単語でoccur
(defun isearch-occur ()
  "Invoke `occur' from within isearch."
  (interactive)
  (let ((case-fold-search isearch-case-fold-search))
    (occur
     (if isearch-regexp
         isearch-string (regexp-quote isearch-string)))))

(define-key isearch-mode-map (kbd "\C-o") 'isearch-occur)

(provide 'init_search)
