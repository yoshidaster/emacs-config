;; tramp
(require 'tramp)
(setq tramp-default-method "ssh")

(add-to-list 'tramp-default-proxies-alist
             '(nil "\\`root\\'" "/ssh:%h:"))
(add-to-list 'tramp-default-proxies-alist
             '("localhost" nil nil))
(add-to-list 'tramp-default-proxies-alist
             '((regexp-quote (system-name)) nil nil))

(add-to-list 'tramp-default-proxies-alist
             '("ldl" "\\`root\\'" "/ssh:ldl:"))
(add-to-list 'tramp-default-proxies-alist
             '("ldg" nil "/sudo:root@ldl:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.blog-new" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.blog-new.xen" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.blog.dev" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.blog.xen" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.clip" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("ldproxy" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("10.0" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("10.130" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.blog.m.xen" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.dev.livedoor.com" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("dev-mobile.livedoor.com" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("dev\\." nil "/ssh:root@ldg:"))

(provide 'init_tramp)
