;;; init.el --- Where all the magic begins
;;
;; Part of the Emacs Starter Kit
;;
;; This is the first thing to get loaded.
;;

(defvar my-home (getenv "HOME"))
;; (setenv "ORG_HOME" (expand-file-name ".emacs.d/src/org-mode" my-home))

;; load Org-mode from source when the ORG_HOME environment variable is set
;; (when (getenv "ORG_HOME")
;;   (let ((org-lisp-dir (expand-file-name "lisp" (getenv "ORG_HOME"))))
;;     (when (file-directory-p org-lisp-dir)
;;       (add-to-list 'load-path org-lisp-dir)
;;       (require 'org))))

(when (getenv "ORG_HOME")
  (let* ((org-lisp-dir (expand-file-name "lisp" (getenv "ORG_HOME")))
	 (org-contrib-dir (expand-file-name "lisp"
					    (expand-file-name "contrib"
							      (getenv "ORG_HOME"))))
	 (load-path (append (list org-lisp-dir org-contrib-dir)
			    (or load-path nil)))))
  (require 'org-install)
  (require 'ob-tangle))

;; instead of starter-kit, point at a directory containing any literate org
;; configurations.
(setq litconfig-dir (convert-standard-filename "~/.emacs.d/litconf"))
(mapc #'org-babel-load-file (directory-files litconfig-dir t "\\.org$"))

;; load the starter kit from the `after-init-hook' so all packages are loaded
;; (add-hook 'after-init-hook
;;  `(lambda ()
;;     ;; remember this directory
;;     (setq starter-kit-dir
;;           ,(concat
;; 	    (file-name-directory (or load-file-name (buffer-file-name)))
;; 		    (convert-standard-filename "lisp/starter-kit")))
;;     ;; only load org-mode later if we didn't load it just now
;;     ,(unless (and (getenv "ORG_HOME")
;;                   (file-directory-p (expand-file-name "lisp"
;;                                                       (getenv "ORG_HOME"))))
;;        '(require 'org))
;;     ;; load up the starter kit
;;     (org-babel-load-file (expand-file-name "starter-kit.org" starter-kit-dir))))

;;; init.el ends here
