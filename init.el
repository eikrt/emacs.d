; Theme
;
(load-theme 'dracula t)
; Enable Evil
(require 'evil)
(evil-mode 1)
(define-key evil-insert-state-map "j" #'cofi/maybe-exit)
(evil-define-command cofi/maybe-exit ()
  :repeat change
  (interactive)
  (let ((modified (buffer-modified-p)))
    (insert "j")
    (let ((evt (read-event (format "Insert %c to exit insert state" ?j)
               nil 0.5)))
      (cond
       ((null evt) (message ""))
       ((and (integerp evt) (char-equal evt ?j))
    (delete-char -1)
    (set-buffer-modified-p modified)
    (push 'escape unread-command-events))
       (t (setq unread-command-events (append unread-command-events
                          (list evt))))))))
(evil-set-undo-system 'undo-redo)
; Menu hide
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

(setq gc-cons-threshold 100000000) ; 100 mb
(setq read-process-output-max (* 1024 1024)) ; 1mb


; Misc stuff

;; Auto-refresh buffers when files on disk change.
(global-auto-revert-mode t)

;; Ensure unique names when matching files exist in the buffer.
;; e.g. This helps when you have multiple copies of "main.rs"
;; open in different projects. It will add a "myproj/main.rs"
;; prefix when it detects matching names.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;; Place backups in a separate folder.
(setq backup-directory-alist `(("." . "~/.saves")))
(setq auto-save-file-name-transforms `((".*" "~/.saves/" t)))

;; I store automatic customization options in a gitignored file,
;; but this is definitely a personal preference.
(setq custom-file (locate-user-emacs-file "custom.el"))
(when (file-exists-p custom-file)
  (load custom-file))
;; You'll be installing your packages with the
;; built-in package.el script
(require 'package)

;; Add MELPA to your list of package archives
(add-to-list 'package-archives
	         '("melpa" . "https://melpa.org/packages/"))

(package-initialize)

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :init
  (marginalia-mode))

(use-package treemacs)

(use-package rust-mode)

(use-package lsp-mode)

(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode)
)

; Keybindings  
(global-set-key (kbd "C-c t") 'treemacs)
(global-set-key (kbd "C-c e") 'eval-buffer)
  ; Dashboard
(set-face-attribute 'default nil
                    :family "Ubuntu Mono"
                    :height 130)  ;; Adjust height as needed (110 is 11pt)
;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs!")
; Set the banner
; (setq dashboard-startup-banner "~/")
;; Content is not centered by default. To center, set
(setq dashboard-center-content t)
(setq dashboard-set-footer nil)
;; Go ahead and refresh your package list to
;; make sure everything is up-to-date
(unless package-archive-contents
  (package-refresh-contents))
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(org-modern evil dracula-theme)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
