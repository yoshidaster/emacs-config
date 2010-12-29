;; tramp
(require 'tramp)
(setq tramp-default-method "ssh")

(add-to-list 'tramp-default-proxies-alist
             '("ldl.data-hotel.net" "\\`root\\'" "/ssh:hiroaki-y@ldl.data-hotel.net:"))
(add-to-list 'tramp-default-proxies-alist
             '("ldg" nil "/sudo:root@ldl.data-hotel.net:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.blog-new" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.blog.dev" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.clip" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("ldproxy" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("10.0.250.\\." nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.blog.m.xen" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("\\.dev.livedoor.com" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("dev-mobile.livedoor.com" nil "/ssh:root@ldg:"))
(add-to-list 'tramp-default-proxies-alist
             '("dev\\." nil "/ssh:root@ldg:"))

(provide 'init_tramp)
