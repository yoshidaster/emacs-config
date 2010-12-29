;;; -*- mode: emacs-lisp; coding: utf-8-emacs-unix; indent-tabs-mode: nil -*-

;;; init_psgml.el --- psgml Setting

;; Copyright (C) 2004  sakito

;; Author: sakito <sakito@sakito.com>

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
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary: psgml-modeの設定

;; 

;;; Code:

;; psgml
;; @see ftp://ftp.lysator.liu.se/pub/sgml/
;;--------------------------------------------------------------------
;(autoload 'sgml-mode "psgml" "Major mode to edit SGML files." t)
;(autoload 'xml-mode "psgml" "Major mode to edit XML files." t)
;(setq auto-mode-alist
;      (append (list (cons "\\.xml\\'" 'xml-mode))
;              auto-mode-alist))
;(setq auto-mode-alist
;      (append (list (cons "\\.html\\'" 'xml-mode))
;              auto-mode-alist))
;(setq auto-mode-alist
;      (append (list (cons "\\.sdoc\\'" 'xml-mode))
;              auto-mode-alist))
;(setq auto-mode-alist
;      (append (list (cons "\\.rng\\'" 'xml-mode))
;              auto-mode-alist))

;(setq sgml-catalog-files '("CATALOG" "~/.emacs.d/share/psgml/CATALOG.txt"))
;(setq sgml-ecat-files '("ECAT" "~/.emacs.d/share/psgml/ECAT.txt"))

(setq sgml-custom-dtd
 '(
   ("XHTML 1.0 Strict"
    "<!DOCTYPE html
  PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\"
    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">\n")
   ("XHTML 1.0 Transitonal"
   "<!DOCTYPE html
  PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\"
    \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\n")
   ("Ant 1.5 DTD"
   "<!DOCTYPE project
  PUBLIC \"-//ANT//DTD project//EN\"
    \"file:///Users/sakito/etc/psgml/ant.dtd\">\n")
   ("application_1_2"
    "<!DOCTYPE application PUBLIC
    \"-//Sun Microsystems, Inc.//DTD J2EE Application 1.2//EN\"
    \"http://java.sun.com/dtd/application_1_2.dtd\">\n")
   ("application_1_3"
    "<!DOCTYPE application PUBLIC
    \"-//Sun Microsystems, Inc.//DTD J2EE Application 1.3//EN\"
    \"http://java.sun.com/dtd/application_1_3.dtd\">\n")
   ("Connector 1.0"
    "<!DOCTYPE connector PUBLIC
    \"-//Sun Microsystems, Inc.//DTD Connector 1.0//EN\"
    \"http://java.sun.com/dtd/connector_1_0.dtd\">\n")
   ("JavaBeans 1.1"
    "<!DOCTYPE ejb-jar PUBLIC
    \"-//Sun Microsystems, Inc.//DTD Enterprise JavaBeans 1.1//EN\"
    \"http://java.sun.com/j2ee/dtds/ejb-jar_1_1.dtd\">\n")
   ("JavaBeans 2.0"
    "<!DOCTYPE ejb-jar PUBLIC
    \"-//Sun Microsystems, Inc.//DTD Enterprise JavaBeans 2.0//EN\"
    \"http://java.sun.com/dtd/ejb-jar_2_0.dtd\">\n")
   ("jaws_2_4"
    "<!DOCTYPE jaws PUBLIC
    \"-//JBoss//DTD JAWS 2.4//EN\"
    \"http://www.jboss.org/j2ee/dtd/jaws_2_4.dtd\">\n")
   ("jaws_3_0"
    "<!DOCTYPE jaws PUBLIC
    \"-//JBoss//DTD JAWS 3.0//EN\"
    \"http://www.jboss.org/j2ee/dtd/jaws_3_0.dtd\">\n")
   ("jboss-web"
    "<!DOCTYPE jboss-web
    PUBLIC \"-//JBoss//DTD Web Application 2.2//EN\"
    \"http://www.jboss.org/j2ee/dtd/jboss-web.dtd\">\n")
   ("jboss-web_3_0"
    "<!DOCTYPE jboss-web
    PUBLIC \"-//JBoss//DTD Web Application 2.3//EN\"
    \"http://www.jboss.org/j2ee/dtd/jboss-web_3_0.dtd\">\n")
   ("jboss"
    "<!DOCTYPE jboss PUBLIC
    \"-//JBoss//DTD JBOSS//EN\"
    \"http://www.jboss.org/j2ee/dtd/jboss.dtd\">\n")
   ("jboss_2_4"
    "<!DOCTYPE jboss PUBLIC
    \"-//JBoss//DTD JBOSS 2.4//EN\"
    \"http://www.jboss.org/j2ee/dtd/jboss_2_4.dtd\">\n")
   ("jboss_3_0"
    "<!DOCTYPE jboss PUBLIC
    \"-//JBoss//DTD JBOSS 3.0//EN\"
    \"http://www.jboss.org/j2ee/dtd/jboss_3_0.dtd\">\n")
   ("jboss_xmbean_1_0"
    "<!DOCTYPE mbean PUBLIC
    \"-//JBoss//DTD JBOSS XMBEAN 1.0//EN\"
    \"http://www.jboss.org/j2ee/dtd/jboss_xmbean_1_0.dtd\">\n")
   ("jbosscmp-jdbc_3_0"
    "<!DOCTYPE jbosscmp-jdbc PUBLIC
    \"-//JBoss//DTD JBOSSCMP-JDBC 3.0//EN\"
    \"http://www.jboss.org/j2ee/dtd/jbosscmp-jdbc_3_0.dtd\">\n")
   ("security_config"
    "<!DOCTYPE policy PUBLIC
    \"-//JBoss//DTD JBOSS Security Config 3.0//EN\"
    \"http://www.jboss.org/j2ee/dtd/security_config.dtd\">\n")
   ("web-app_2_2"
    "<!DOCTYPE web-app PUBLIC
    \"-//Sun Microsystems, Inc.//DTD Web Application 2.2//EN\"
    \"http://java.sun.com/dtd/web-app_2_2.dtd\">\n")
   ("web-app_2_3"
    "<!DOCTYPE web-app PUBLIC
    \"-//Sun Microsystems, Inc.//DTD Web Application 2.3//EN\"
    \"http://java.sun.com/dtd/web-app_2_3.dtd\">\n")
   ("struts-config_1_0"
    "<!DOCTYPE struts-config PUBLIC
    \"-//Apache Software Foundation//DTD Struts Configuration 1.0//EN\"
    \"http://jakarta.apache.org/struts/dtds/struts-config_1_0.dtd\">\n")
   ("struts-config_1_1"
    "<!DOCTYPE struts-config PUBLIC
    \"-//Apache Software Foundation//DTD Struts Configuration 1.1//EN\"
    \"http://jakarta.apache.org/struts/dtds/struts-config_1_1.dtd\">\n")
   ("tiles-config"
    "<!DOCTYPE tiles-definitions PUBLIC
    \"-//Apache Software Foundation//DTD Tiles Configuration//EN\"
    \"http://jakarta.apache.org/struts/dtds/tiles-config.dtd\">\n")
   ("validation_1_1"
    "<!DOCTYPE form-validation PUBLIC
    \"-//Apache Software Foundation//DTD Struts Validation Configuration 1.1//EN\"
    \"http://jakarta.apache.org/struts/dtds/validation_1_1.dtd\">\n")
   ("validator-rules_1_1"
    "<!DOCTYPE form-validation PUBLIC
    \"-//Apache Software Foundation//DTD Struts Validator Rules Configuration 1.1//EN\"
    \"http://jakarta.apache.org/struts/dtds/validator-rules_1_1.dtd\">\n")
   ("MavenProjectDTD"
    "<!DOCTYPE project PUBLIC
    \"-//Apache Software Foundation//DTD Maven project Configuration//EN\"
    \"file:///Users/sakito/etc/psgml/project.dtd\">\n")
   ("SmartDoc"
    "<!DOCTYPE doc PUBLIC
    \"-//Tomoharu Asami//DTD PureSmartDoc XML V1.0.0//EN\"
    \"file:////Users/sakito/etc/psgml/PureSmartDoc.dtd\">\n")
   ("RelaxNG"
    "<!DOCTYPE rng PUBLIC
    \"-//RelaxNG//DTD RelaxNG 1.0//EN\"
    \"file:////Users/sakito/etc/psgml/relaxng.dtd\">\n")
   ;; Forrest
   ("Forrest_document-v11"
    "<!DOCTYPE document PUBLIC \"-//APACHE//DTD Documentation V1.1//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/document-v11.dtd\"/>\n")
   ("Forrest_specification-v11"
    "<!DOCTYPE document PUBLIC \"-//APACHE//DTD Specification V1.1//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/specification-v11.dtd\"/>\n")
   ("Forrest_faq-v11"
    "<!DOCTYPE document PUBLIC \"-//APACHE//DTD FAQ V1.1//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/faq-v11.dtd\"/>\n")
   ("Forrest_changes-v11"
    "<!DOCTYPE document PUBLIC \"-//APACHE//DTD Changes V1.1//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/changes-v11.dtd\"/>\n")
   ("Forrest_todo-v11"
    "<!DOCTYPE document PUBLIC \"-//APACHE//DTD Todo V1.1//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/todo-v11.dtd\"/>\n")
   ("Forrest_book-cocoon-v10"
    "<!DOCTYPE document PUBLIC \"-//APACHE//DTD Cocoon Documentation Book V1.0//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/book-cocoon-v10.dtd\"/>\n")
   ("Forrest_tab-cocoon-v10"
    "<!DOCTYPE document PUBLIC \"-//APACHE//DTD Cocoon Documentation Tab V1.0//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/tab-cocoon-v10.dtd\"/>\n")
   ("Forrest_howto-v10"
    "<!DOCTYPE document PUBLIC \"-//APACHE//DTD How-to V1.0//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/howto-v10.dtd\"/>\n")
   ("Forrest_xgump-draft"
    "<!DOCTYPE document PUBLIC \"-//APACHE//DTD Gump Descriptor V1.0//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/xgump-draft.dtd\"/>\n")
   ("Forrest_javadoc-v04draft"
    "<!DOCTYPE document PUBLIC \"-//APACHE//DTD JavaDoc V1.0//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/javadoc-v04draft.dtd\"/>\n")
   ("Forrest_contributors-v10"
   "<!DOCTYPE document PUBLIC \"-//APACHE//DTD Contributors V1.0//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/contributors-v10.dtd\"/>\n")
   ("Forrest_libre-v01.dtd"
    "<!DOCTYPE document PUBLIC \"-//Outerthought//DTD Libre Configuration V0.1//EN\"
        \"file:////Users/sakito/etc/psgml/forrest/libre-v01.dtd\"/>\n")
   ))

(add-hook 'xml-mode-hook
          (function (lambda()
                      ;; キーの設定
                      (define-key xml-mode-map "\C-c\C-zv" 'browse-url-of-file)

                      ;; 色の設定
                      (make-face 'sgml-comment-face)
                      (make-face 'sgml-start-tag-face)
                      (make-face 'sgml-end-tag-face)
                      (make-face 'sgml-doctype-face)

                      (set-face-foreground 'sgml-comment-face "dark slate grey")
                      (set-face-foreground 'sgml-start-tag-face "SkyBlue1")
                      (set-face-foreground 'sgml-end-tag-face "SkyBlue1")
                      (set-face-foreground 'sgml-doctype-face "DodgerBlue3")

                      (setq sgml-set-face t)
                      (setq sgml-markup-faces
                            '(
                              (comment   . sgml-comment-face)
                              (start-tag . sgml-start-tag-face)
                              (end-tag   . sgml-end-tag-face)
                              (doctype   . sgml-doctype-face)
                              ))

                      
                      )))
(provide 'init_psgml)
;;; init_psgml.el ends here
