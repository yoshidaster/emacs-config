;;; trac-ticket.el --- Trac ticket interface

;; Copyright (C) 2007  Taiki SUGAWARA <buzz.taiki@gmail.com>

;; Author: Taiki SUGAWARA <buzz.taiki@gmail.com>
;; Keywords: trac, xml-rpc

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Features:
;;   * Editing cutom query (M-x trac-ticket-query).
;;   * Show ticket directly (M-x trac-ticket).
;;   * Listing ticket summary.
;;   * Show ticket.
;;   * Highlight ticket description and logs using trac-wiki.

;;; Requirements:
;;   * Works on Emacs 22.
;;   * need trac-wiki.el
;;     (get it from http://www.meadowy.org/~gotoh/projects/trac-wiki/)
;;   * need xml-rpc.el
;;     (get it from http://cvs.savannah.nongnu.org/viewcvs/*checkout*/weblogger/lisp/xml-rpc.el?root=emacsweblogs)

;;; Configuration:
;; Put this, trac-wiki.el and xml-rpc.el in a directory on your `load-path'.
;; Put followings in your .emacs
;;   (require 'trac-ticket)
;;   (setq url-proxy-services '(("http" . "your.proxy.host:portnumber")) ; if needed
;;   (add-to-list 'trac-projects '("project-name" :endpoint "http://www.some.host.org/proj/login/xmlrpc"))

;;; Usage:
;; Case1: editing custom query
;;   1. type M-x trac-ticket-query and enter project name.
;;   2. then query buffer is displayed.
;;   3. edit cutom queries.
;;   4. type C-cC-c.
;;   5. then summary buffer is displayed.
;;   6. move cursor to ticket for wants to see.
;;   7. type RET.
;;   8. then ticket buffer is displayed.

;; Case2: show ticket directly.
;;   1. type M-x trac-ticket and enter project name and ticket-id.
;;   2. then ticket buffer is displayed.

;; Case3: change project.
;;   1. type M-x trac-ticket-query or type M-x trac-ticket with prefix-argument.

;;; Todo:
;;   * save custom query
;;   * write ticket log
;;   * write new ticket
;;   * sort summary
;;   * grouping summary
;;   * browse ticket by external browser
;;   * make checkbox to easy to look
;;   * multiple project support
;;   * docstring
;;   * installation, usage, requirement

;;; Code:

(require 'trac-wiki)
(require 'widget)
(require 'cl)

;;; Variables
(defconst trac-ticket-version "0.0.3")

(defvar trac-ticket-field-extra-label-alist
  '(("id" . "ID")
    ("created" . "Created")
    ("modified" . "Modified"))
  "*A alist of field name to label.
These label has high priority from field label.")

(defvar trac-ticket-field-type-operator-alist
  '(("text" . contains)
    ("radio" . is)
    ("select" . is))
  "*A alist of field type to operator.")

(defvar trac-ticket-summary-format
  '(("id" 6 right)
    ("status" 8 left)
    ("owner" 10 left)
    ("type" 11 left)
    ("priority" 7 left)
    ("milestone" 10 left)
    ("summary" nil left))
  "*A alist of summary format.
This variable is a following form:
\(FORMAT FORMAT ...)

FORMAT is following:
\(NAME WIDTH ALIGN)
When summary is displayed, field value is truncated to WIDTH and aligned from ALIGN.
NAME is a name of field.
WIDTH can be number or nil. If WIDTH is nil, field value is not truncated.
ALIGN can be `left' or `right'.")

(defvar trac-ticket-ticket-header-format
  '("#%s: [%s/%s/%s] %s"
    "id" "status" "type" "priority" "summary")
  "*A ticket header format.
This variable is a following form:
\(FORMAT NAME NAME ...)

FORMAT is a format string of `format'.
NAME is a name of field.
Field value corresponding to NAME is used to format parameter.")

(defvar trac-ticket-summary-separator "|"
  "*A separator of summary.")

(defvar trac-ticket-time-format "%Y-%m-%d %H:%M:%S"
  "*A date-time format of each date-times.
This variable can be format string of `format-time-string'.")

;; hooks
(defvar trac-ticket-query-mode-hook nil)
(defvar trac-ticket-query-after-create-hook nil)
(defvar trac-ticket-summary-mode-hook nil)
(defvar trac-ticket-summary-after-create-hook nil)
(defvar trac-ticket-ticket-mode-hook nil)
(defvar trac-ticket-ticket-after-create-hook nil)


;;; Keymaps
(defvar trac-ticket-query-mode-map
  (let ((map (copy-keymap widget-keymap)))
    (define-key map "\C-c\C-c" 'trac-ticket-query-do-search)
    (define-key map "q" 'bury-buffer)
    (define-key map " " 'scroll-up)
    (define-key map [(shift ?\ )] 'scroll-down)
    (define-key map "\C-?" 'scroll-down)
    map))

(defvar trac-ticket-summary-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "\r" 'trac-ticket-summary-select)
    (define-key map "q" 'bury-buffer)
    (define-key map "n" 'next-line)
    (define-key map "p" 'previous-line)
    (define-key map " " 'scroll-up)
    (define-key map [(shift ?\ )] 'scroll-down)
    (define-key map "\C-?" 'scroll-down)
    (define-key map ">" 'end-of-buffer)
    (define-key map "<" 'beginning-of-buffer)
    map))
    
(defvar trac-ticket-ticket-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map "q" 'trac-ticket-ticket-quit)
    (define-key map "f" 'trac-ticket-ticket-next-ticket)
    (define-key map "b" 'trac-ticket-ticket-previous-ticket)
    (define-key map "\r" 'trac-ticket-ticket-show-ticket-at-point)
    (define-key map " " 'scroll-up)
    (define-key map [(shift ?\ )] 'scroll-down)
    (define-key map "\C-?" 'scroll-down)
    (define-key map ">" 'end-of-buffer)
    (define-key map "<" 'beginning-of-buffer)
    map))


;;; Internal variables
(defvar trac-ticket-project-fields nil)
(defvar trac-ticket-current-project nil)
(defvar trac-ticket-buffer-project nil)

;; filter
(defconst trac-ticket-filter-operator-alist
  '((contains . "~")
    (contains-not . "!~")
    (begins-with . "^")
    (ends-with . "$")
    (is . "")
    (is-not . "!")))

;; query
(defvar trac-ticket-query-buffer-name "*trac-ticket-query*")
(defvar trac-ticket-query-retrieve-buffer-name "*trac-ticket-query-retrieve*")
(defvar trac-ticket-query-buffer-filter-alist nil)

;; summary    
(defvar trac-ticket-summary-buffer-name "*trac-ticket-summary*")
(defvar trac-ticket-summary-compiled-format nil)

;; ticket
(defvar trac-ticket-ticket-buffer-name-format "*trac-ticket %s:%s*")
(defvar trac-ticket-ticket-extra-field-alist
  '(("id" . trac-ticket-ticket-id)
    ("created" . (lambda (ticket)
		   (trac-ticket-format-time (trac-ticket-ticket-created ticket))))
    ("modified" . (lambda (ticket)
		    (trac-ticket-format-time (trac-ticket-ticket-modified ticket))))))
(defvar trac-ticket-ticket-syntax-table
  (let ((tab (make-syntax-table)))
    (modify-syntax-entry ?# "w" tab)
    (modify-syntax-entry ?: "w" tab)
    tab))



;;; Field

(defmacro trac-ticket-define-field-getter (name &optional docstring)
  `(defun ,(intern (concat "trac-ticket-field-" (symbol-name name))) (field)
     ,docstring
     (assoc-default ,(symbol-name name) field)))
     
(trac-ticket-define-field-getter name)
(trac-ticket-define-field-getter label)
(trac-ticket-define-field-getter options)
(trac-ticket-define-field-getter value)
(trac-ticket-define-field-getter optional)
(trac-ticket-define-field-getter order)
(trac-ticket-define-field-getter type)

(defun trac-ticket-field-alist (fields)
  "Convert FIELDS to alist.
A each element spec is a \(NAME . FIELD)."
  (mapcar (lambda (field)
	    (cons (trac-ticket-field-name field) field))
	  fields))

(defun trac-ticket-field-alist-label (field-alist name &optional add-extra-p)
  "Get label by NAME from FIELD-ALIST.
If ADD-EXTRA-P is non-nil, `trac-ticket-field-extra-label-alist' is used prior than field label."
  (or (and add-extra-p
	   (assoc-default name
			  trac-ticket-field-extra-label-alist))
      (trac-ticket-field-label (assoc-default name field-alist))
      name))


;;; Filter
(defun trac-ticket-filter (name value operator)
  (list name value operator))

(defun trac-ticket-filter-name (filter)
  (car filter))

(defun trac-ticket-filter-value (filter)
  (nth 1 filter))

(defun trac-ticket-filter-operator (filter)
  (nth 2 filter))

(defun trac-ticket-filter-to-string (filter)
  "Convert filter to query parameter string."
  (mapconcat 'url-hexify-string
	     (list
	      (trac-ticket-filter-name filter)
	      (concat (assoc-default (trac-ticket-filter-operator filter)
				     trac-ticket-filter-operator-alist)
		      (trac-ticket-filter-value filter)))
	     "="))


;;; Query
(defun trac-ticket-query-mode ()
  "A cutom query editing mode.
\\{trac-ticket-query-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (use-local-map trac-ticket-query-mode-map)
  (setq major-mode 'trac-ticket-query-mode)
  (setq mode-name "Trac-Ticket-Query")
  (run-hooks 'trac-ticket-query-mode-hook))

(defun trac-ticket-query (project)
  "Edit a custom query of PROJECT.
If you are not using trac-ticket yet, this command asks project of using.
If prefix argument is non-nil, this command asks project always."
  (interactive
   (list (trac-ticket-read-project current-prefix-arg)))
  (switch-to-buffer trac-ticket-query-buffer-name)
  (trac-ticket-query-mode)
  (let ((fields (trac-ticket-get-fields project)))
  (set (make-local-variable 'trac-ticket-buffer-project) project)
  (make-local-variable 'trac-ticket-query-buffer-filter-alist)
  (trac-ticket-query-create fields)))

(defun trac-ticket-query-create (fields)
  "Create query buffer from FIELDS."
;; type: text radio select
;; name
;; label
;; options:
;; value
;; optional: t nil
  (let ((inhibit-read-only t))
    (erase-buffer)
    (remove-overlays)
    (dolist (field fields)
      (cond
       ((string= (trac-ticket-field-type field) "text")
	(apply 'widget-create
	       `(string
		 :tag ,(format "%15s" (trac-ticket-field-label field))
		 :ticket-field ,field
		 :create trac-ticket-query-widget-create
		 :notify trac-ticket-query-widget-notify)))
       ((member (trac-ticket-field-type field) '("select" "radio"))
	(apply 'widget-create
	       `(checklist
;; 		 :format "%{%t%}:\n%v\n"
		 :format "%{%t%}:\n%v"
;; 		 :entry-format "%b %v  "
		 :entry-format "%b %v\n"
		 :tag ,(format "%15s" (trac-ticket-field-label field))
;; 		 :indent 2
		 :indent 15
		 :ticket-field ,field
		 :create trac-ticket-query-widget-create
		 :notify trac-ticket-query-widget-notify
		 ,@(mapcar (lambda (option)
			     `(const :format "%v" :value ,option))
			   (trac-ticket-field-options field))))))))
  (widget-setup)
  (set-buffer-modified-p nil)
  (goto-char (point-min))
  (run-hooks 'trac-ticket-query-after-create-hook))

(defun trac-ticket-query-widget-create (widget)
  "Create a widget of query."
  (let ((super (get (widget-type widget) 'widget-type))
	(field (widget-get widget :ticket-field)))
    (funcall (widget-get super :create) widget)
    (setq trac-ticket-query-buffer-filter-alist
	  (acons (trac-ticket-field-name field)
		 (trac-ticket-filter
		  (trac-ticket-field-name field)
		  (widget-value widget)
		  (assoc-default (trac-ticket-field-type field)
				 trac-ticket-field-type-operator-alist))
		 trac-ticket-query-buffer-filter-alist))))

(defun trac-ticket-query-widget-notify (widget child &optional event)
  "Notify function for a widget editing."
  (let* ((name (trac-ticket-field-name (widget-get widget :ticket-field)))
	 (filter (assoc-default name trac-ticket-query-buffer-filter-alist)))
    (trac-ticket-set-alist
     'trac-ticket-query-buffer-filter-alist
     name
     (trac-ticket-filter (trac-ticket-filter-name filter)
			 (widget-value widget)
			 (trac-ticket-filter-operator filter)))))

(defun trac-ticket-query-filter-alist-to-filters (filter-alist)
  "Convert filter alist to filters.
Empty filter is banished.
Multi value filter is a extracted."
  (trac-ticket-flatten
   (mapcar
    (lambda (filter)
      (if (listp (trac-ticket-filter-value filter))
	  (mapcar
	   (lambda (value)
	     (trac-ticket-filter
	      (trac-ticket-filter-name filter)
	      value
	      (trac-ticket-filter-operator filter)))
	   (trac-ticket-filter-value filter))
	(list filter)))
    (remove-if (lambda (filter)
		 (let ((value (trac-ticket-filter-value filter)))
		   (or (null value)
		       (and (stringp value) (string= value "")))))
	       (mapcar 'cdr filter-alist)))))

(defun trac-ticket-query-do-search ()
  "Do query search."
  (interactive)
  (let ((project trac-ticket-buffer-project))
    (trac-ticket-summary
     project
     (trac-ticket-query-search
      project
      (trac-ticket-query-filter-alist-to-filters
       trac-ticket-query-buffer-filter-alist)))))

(defun trac-ticket-query-url (project filters)
  "Create query url from PROJECT and FILTERS.
This url hopes a response is a tab format."
  (let ((url (trac-ticket-project-query-url project)))
    (concat
     url "?"
     (mapconcat 'identity
		(cons
		 "format=tab"
		 (mapcar 'trac-ticket-filter-to-string filters))
		"&"))))

(defun trac-ticket-query-search (project filters)
  "Search a tickets from PROJECT and FILTERS.
Return summary tickets."
  (let* ((url-request-method "GET")
	 (buf (url-retrieve-synchronously
	       (trac-ticket-query-url project filters))))
    (when (get-buffer trac-ticket-query-retrieve-buffer-name)
      (kill-buffer trac-ticket-query-retrieve-buffer-name))
    (with-current-buffer buf
      (rename-buffer trac-ticket-query-retrieve-buffer-name))
    (trac-ticket-query-parse-response buf)))

(defun trac-ticket-query-parse-response (buffer)
  "Parse a custom query response from buffer."
  (declare (special url-http-response-status
		    url-http-end-of-headers
		    url-http-content-type))
  (let (result)
    (with-current-buffer buffer
      (set-buffer-multibyte t)
      (when (not (= url-http-response-status 200))
	(error "Query failed (status %s)" url-http-response-status))
      (goto-char (1+ url-http-end-of-headers))
      (decode-coding-region (point) (point-max) 'utf-8)
      (let (header)
	(when (re-search-forward ".+" nil t)
	  (setq header (split-string (match-string 0) "\t")))
	(while (re-search-forward ".+" nil t)
	  (push 
	   (mapcar* (lambda (k v) (cons k v))
		    header
		    (split-string (match-string 0) "\t"))
	   result))))
    (nreverse result)))


;;; Summary

(defun trac-ticket-summary-mode ()
  "A ticket summary mode.
\\{trac-ticket-summary-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (setq buffer-read-only t)
  (setq truncate-lines t)
  (use-local-map trac-ticket-summary-mode-map)
  (setq major-mode 'trac-ticket-summary-mode)
  (setq mode-name "Trac-Ticket-Summary")
  (run-hooks 'trac-ticket-summary-mode-hook))

;; TODO change argument from tickets to filters
(defun trac-ticket-summary (project tickets)
  "Enter a summary mode from PROJECT and TICKETS."
  (switch-to-buffer trac-ticket-summary-buffer-name)
  (trac-ticket-summary-mode)
  (set (make-local-variable 'trac-ticket-buffer-project) project)
  (trac-ticket-summary-create (trac-ticket-get-fields project) tickets))
      
(defun trac-ticket-summary-create (fields tickets)
  "Create summary mode buffer from FIELDS and TICKETS."
  (let ((inhibit-read-only t)
	(field-alist (trac-ticket-field-alist fields)))
    (erase-buffer)
    (trac-ticket-summary-compile-format)
    (insert
     (trac-ticket-summary-format
      (mapcar
       (lambda (fmt)
	 (let ((name (car fmt)))
	   (cons name
		 (propertize (trac-ticket-field-alist-label field-alist name t)
			     'face 'bold))))
       trac-ticket-summary-format))
     "\n")
    (dolist (ticket (sort tickets
			  (lambda (a b)
			    (< (trac-ticket-summary-ticket-id b)
			       (trac-ticket-summary-ticket-id a)))))
      (let ((line (trac-ticket-summary-format ticket)))
	(insert (propertize line
			    'trac-ticket-summary-ticket-id
			    (trac-ticket-summary-ticket-id ticket))
		"\n"))))
  (set-buffer-modified-p nil)
  (goto-char (point-min))
  (run-hooks 'trac-ticket-summary-after-create-hook))

(defun trac-ticket-summary-ticket-id (ticket)
  (string-to-number (assoc-default "id" ticket)))

(defun trac-ticket-summary-select ()
  "Select a ticket at point."
  (interactive)
  (let ((ticket-id (get-text-property (line-beginning-position)
				      'trac-ticket-summary-ticket-id)))
    (trac-ticket-ticket trac-ticket-buffer-project
			ticket-id)))

(defun trac-ticket-summary-compile-format ()
  "Compile `trac-ticket-summary-format'.
Compiled format is set to `trac-ticket-summary-compiled-format'."
  (let* ((separator (propertize trac-ticket-summary-separator
				'face 'shadow))
	 (form
	  `(lambda (ticket)
	     (format
	      ,(mapconcat (lambda (fmt)
			    (if (eq (nth 2 fmt) 'right)
				(format "%%%ds" (or (nth 1 fmt) 0))
			      (format "%%-%ds" (or (nth 1 fmt) 0))))
			  trac-ticket-summary-format
			  "%s")
	      ,@(subseq
		 (trac-ticket-flatten
		  (mapcar
		   (lambda (fmt)
		     (list
		      (if (nth 1 fmt)
			  `(truncate-string-to-width
			    (or (assoc-default ,(car fmt) ticket) "")
			    ,(nth 1 fmt))
			`(or (assoc-default ,(car fmt) ticket) ""))
		      separator))
		   trac-ticket-summary-format))
		 0 -1)))))
    (setq trac-ticket-summary-compiled-format (byte-compile form))))

(defun trac-ticket-summary-format (tickets)
  "Format TICKETS."
  (funcall trac-ticket-summary-compiled-format tickets))
  

;;; Cahgelog
;; log := {{time, author, field, oldvalue, newvalue, permanent}, ...}
(defun trac-ticket-log-time (log)
  (car log))

(defun trac-ticket-log-author (log)
  (nth 1 log))

(defun trac-ticket-log-field (log)
  (nth 2 log))

(defun trac-ticket-log-old (log)
  (nth 3 log))

(defun trac-ticket-log-new (log)
  (nth 4 log))

(defun trac-ticket-log-permanent-p (log)
  (= (nth 5 log) 1))

(defun trac-ticket-log-comment-p (log)
  (string= (trac-ticket-log-field log) "comment"))

(defun trac-ticket-packedlog-time (log)
  (car (car log)))

(defun trac-ticket-packedlog-author (log)
  (nth 1 (car log)))

(defun trac-ticket-packedlog-logs (log)
  (cdr log))

(defun trac-ticket-log-pack-logs (logs)
  "Pack same logs to packed-log in LOGS.
A 'same logs' means same time and same author."
  (let (packed-logs)
    (dolist (log logs)
      (let* ((key (list (trac-ticket-log-time log)
			(trac-ticket-log-author log)))
	     (children (assoc-default key packed-logs)))
	(trac-ticket-set-alist 'packed-logs key (cons log children))))
    (mapcar (lambda (packed)
	      (cons (car packed) (nreverse (cdr packed))))
	    (nreverse packed-logs))))


;;; Ticket
;; log := {id, created, modified, fields}
(defun trac-ticket-ticket-id (ticket)
  (car ticket))

(defun trac-ticket-ticket-created (ticket)
  (nth 1 ticket))

(defun trac-ticket-ticket-modified (ticket)
  (nth 2 ticket))

(defun trac-ticket-ticket-fields (ticket &optional add-extra-p)
  "Get fields from ticket.
If ADD-EXTRA-P is non-nil, return value contains values of
`trac-ticket-ticket-extra-field-alist'."
  (append (nth 3 ticket)
	  (and add-extra-p
	       (mapcar (lambda (cell)
			 (cons (car cell)
			       (funcall (cdr cell) ticket)))
		       trac-ticket-ticket-extra-field-alist))))

(defun trac-ticket-ticket-mode ()
  "View ticket mode.
\\{trac-ticket-ticket-mode-map}"
  (interactive)
  (kill-all-local-variables)
  (setq buffer-read-only t)
  (use-local-map trac-ticket-ticket-mode-map)
  (set-syntax-table trac-ticket-ticket-syntax-table)
  (setq major-mode 'trac-ticket-ticket-mode)
  (setq mode-name "Trac-Ticket")
  (run-hooks 'trac-ticket-ticket-mode-hook))

(defun trac-ticket-ticket-search (project ticket-id)
  "Search ticket and log from PROJECT and TICKET-ID.
Return value is a plist that contains :ticket and :packedlogs."
  (list :ticket (trac-ticket-rpc-call project 'ticket.get ticket-id)
	:packedlogs (trac-ticket-log-pack-logs
		     (trac-ticket-rpc-call project 'ticket.changeLog ticket-id))))

(defun trac-ticket-ticket (project ticket-id)
  "Show ticket from PROJECT and TICKET-ID.

When interactive call, if you are not using trac-ticket yet, this
command asks project of using.
If prefix argument is non-nil, this command asks project always."
  (interactive
   (list (trac-ticket-read-project current-prefix-arg)
	 (read-number "Ticket ID: ")))
  (switch-to-buffer (format trac-ticket-ticket-buffer-name-format
			    (trac-ticket-project-name project)
			    ticket-id))
  (trac-ticket-ticket-mode)
  (set (make-local-variable 'trac-ticket-buffer-project) project)
  (trac-ticket-ticket-create (trac-ticket-get-fields project)
			     (trac-ticket-ticket-search project ticket-id)))

(defalias 'trac-ticket 'trac-ticket-ticket)

;; 2 column sample
;; (let ((l '(a b c d e f g)))
;;   (do ((x l (cddr x)))
;;       ((null x))
;;     (insert (format "%s-%s\n" (car x) (cadr x)))))
(defun trac-ticket-ticket-create (fields ticket-set)
  "Create a ticket buffer from FIELDS and TICKET-SET."
  (let* ((inhibit-read-only t)
	 (field-alist (trac-ticket-field-alist fields))
	 (ticket (plist-get ticket-set :ticket))
	 (ticket-fields (trac-ticket-ticket-fields ticket t)))
    (erase-buffer)
    (insert (propertize
	     (apply 'format (car trac-ticket-ticket-header-format)
		    (mapcar (lambda (ticket-field)
			      (assoc-default ticket-field ticket-fields))
			    (cdr trac-ticket-ticket-header-format)))
	     'face 'bold)
	    "\n")
    (dolist (ticket-field (remove-if
			   (lambda (ticket-field)
			     (member (car ticket-field)
				     (cons "description" (cdr trac-ticket-ticket-header-format))))
			   ticket-fields))
      (trac-ticket-ticket-field-insert
       (trac-ticket-field-alist-label field-alist (car ticket-field) t)
       (or (cdr ticket-field) "")))
    (let ((pos (point)))
      (insert "\n" (assoc-default "description" ticket-fields)
	      "\n\n\n")
      (trac-ticket-fontify-region pos (point)))
    (dolist (packedlog (plist-get ticket-set :packedlogs))
      (let ((line (format
		   "%s - %s\n"
		   (trac-ticket-format-time (trac-ticket-packedlog-time packedlog))
		   (trac-ticket-packedlog-author packedlog)))
	    (logs (trac-ticket-packedlog-logs packedlog)))
	(insert (propertize line 'face 'font-lock-comment-face))
	(dolist (log (remove-if 'trac-ticket-log-comment-p logs))
	  (let ((old (trac-ticket-log-old log))
		(new (trac-ticket-log-new log)))
	    (trac-ticket-ticket-field-insert
	     (trac-ticket-field-alist-label field-alist (trac-ticket-log-field log) t)
	     (if (or old new)
		 (format "%s -> %s" (or old "") (or new ""))
	       "modified"))))
	(let ((pos (point)))
	  (insert
	   (or (trac-ticket-log-new (find-if 'trac-ticket-log-comment-p logs)) "")
	   "\n\n")
	  (trac-ticket-fontify-region pos (point))))))
  (set-buffer-modified-p nil)
  (goto-char (point-min))
  (run-hooks 'trac-ticket-ticket-after-create-hook))

(defun trac-ticket-ticket-field-insert (label value)
  (insert (propertize (concat label ":") 'face 'font-lock-keyword-face)
	  " "
	  (if (listp value) (mapconcat 'identity value ", ") value)
	  "\n"))

(defun trac-ticket-ticket-show-ticket-at-point (&optional pos)
  "Show ticket at point.
This command understands the following formats:
  ticket:N
  #N"

  (interactive "d")
  (setq pos (or pos (point)))
  (let ((thing (save-excursion
		 (goto-char pos)
		 (thing-at-point 'word))))
    (when (string-match "^\\(#\\|ticket:\\)\\([0-9]+\\)" thing)
      (trac-ticket-ticket
       trac-ticket-buffer-project
       (string-to-number (match-string 2 thing))))))

(defun trac-ticket-ticket-buffer-list ()
  "Return buffer list limited by ticket mode buffer."
  (remove-if (lambda (buf)
	       (with-current-buffer buf
		 (not (eq major-mode 'trac-ticket-ticket-mode))))
	     (buffer-list)))

(defun trac-ticket-ticket-cycle-ticket (&optional previous-p)
  "Switch to next ticket buffer.
If PREVIOUS-P is non-nil, it switchs buffer to previously."
  (let* ((list (funcall (if previous-p 'nreverse 'identity)
			(trac-ticket-ticket-buffer-list)))
	 (next (or (cadr (member (current-buffer) list))
		   (car list))))
    (unless previous-p
      (bury-buffer))
    (switch-to-buffer (or next (car list)))))

(defun trac-ticket-ticket-next-ticket ()
  "Switch to next ticket buffer."
  (interactive)
  (trac-ticket-ticket-cycle-ticket))

(defun trac-ticket-ticket-previous-ticket ()
  "Switch to previous ticket buffer."
  (interactive)
  (trac-ticket-ticket-cycle-ticket t))
  
(defun trac-ticket-ticket-quit ()
  "Quit ticket mode.
This function bury all ticket mode buffer."
  (interactive)
  (dolist (buffer (trac-ticket-ticket-buffer-list))
    (bury-buffer buffer))
  (bury-buffer))


;;; Utilities
(defun trac-ticket-rpc-call (project method &rest args)
  (let ((trac-rpc-endpoint (plist-get project :endpoint)))
    (apply 'trac-rpc-call method args)))

(defun trac-ticket-flatten (list)
  (apply 'append list))

(defun trac-ticket-set-alist (symbol key value)
  (let ((cell (assoc key (symbol-value symbol))))
    (if cell
	(setcdr cell value)
      (set symbol (acons key value (symbol-value symbol))))))

(defun trac-ticket-read-project (&optional force-read)
  (if (and (not force-read) trac-ticket-current-project)
      trac-ticket-current-project
    (let ((project (copy-sequence
		    (assoc-default
		     (completing-read "Project: " trac-projects nil t)
		     trac-projects))))
      (setq trac-ticket-current-project project))))

(defun trac-ticket-project-base-url (project)
  (replace-regexp-in-string
   "\\(/login\\)?/xmlrpc$" "/" (plist-get project :endpoint)))

(defun trac-ticket-project-query-url (project)
  (or (plist-get project :query-url)
      (url-expand-file-name
       "query"
       (trac-ticket-project-base-url project))))

(defun trac-ticket-project-name (project)
  (or (plist-get project :name)
      (file-name-nondirectory
       (directory-file-name (trac-ticket-project-base-url project)))))

(defun trac-ticket-get-fields (project)
  (let* ((endpoint (plist-get project :endpoint))
	 (fields (assoc-default endpoint trac-ticket-project-fields)))
    (if fields
	fields
      (setq fields (trac-ticket-rpc-call project 'ticket.getTicketFields))
      (setq trac-ticket-project-fields
	    (acons endpoint fields trac-ticket-project-fields))
      fields)))

(defun trac-ticket-float-to-time (n)
  (let* ((high (floor (/ n (expt 2 16))))
	 (low (floor (- n (* (float high) (expt 2 16))))))
    (list high low 0)))

(defun trac-ticket-format-time (time)
  (when (floatp time)
    (setq time (trac-ticket-float-to-time time)))
  (format-time-string trac-ticket-time-format time))

(defun trac-ticket-fontify-region (beg end)
  (save-excursion
    (let ((font-lock-set-defaults t)
	  (font-lock-keywords trac-wiki-font-lock-keywords))
      (font-lock-fontify-keywords-region beg end))))

;; trac-ticket.el ends here
