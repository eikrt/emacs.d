(add-to-list 'package-archives
	         '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
; Theme
;
; (load-theme 'dracula t)
(load-theme 'modus-operandi t)
(package-refresh-contents)
; Enable Evil
(use-package evil 
  :ensure t)
(use-package evil-matchit
  :ensure t)
(use-package treemacs 
  :ensure t)
(use-package rust-mode 
  :ensure t)
(use-package rainbow-mode 
  :ensure t)
(use-package helm 
  :ensure t)
(use-package golden-ratio 
  :ensure t)
(use-package google-this
  :ensure t)
(use-package dimmer 
  :ensure t)
(use-package nix-mode
  :ensure t)
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
; (minimap-mode 1)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
(global-set-key "\C-x\C-o" 'dumb-jump-go-prefer-external-other-window);
(global-set-key "\C-x\C-k" 'xref-pop-marker-stack);
(global-set-key "\C-x\C-j" 'dumb-jump-go);
(global-set-key "\C-x\C-k" 'dumb-jump-back);
(global-evil-matchit-mode 1)
(setq gc-cons-threshold 100000000) ; 100 mb
(setq read-process-output-max (* 1024 1024)) ; 1mb
; (set-face-attribute 'default nil :font Droid Sans Mono-10 )
; (set-frame-font Droid Sans Mono-10 nil t)
; Misc stuff

;; Auto-refresh buffers when files on disk change.
(global-auto-revert-mode t)

;; Ensure unique names when matching files exist in the buffer.
;; e.g. This helps when you have multiple copies of "main.rs"
;; open in different projects. It will add a "myproj/main.rs"
;; prefix when it detects matching names.
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)
;(use-package restclient
;  :ensure t
;  :mode (("\\.http\\'" . restclient-mode)))
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

(use-package vertico
  :ensure t
  :init
  (vertico-mode))

(use-package marginalia
  :after vertico
  :ensure t
  :init
  (marginalia-mode))

(use-package rust-mode)

(unless (package-installed-p 'lsp-mode)
  (package-refresh-contents)
  (package-install 'lsp-mode))

;; Optionally, install lsp-ui for enhanced UI features (e.g., hover documentation)
(use-package lsp-ui
  :ensure t
  :after lsp-mode
  :hook (lsp-mode . lsp-ui-mode)
  :config
  ;; Enable the feature to show documentation on hover
  (setq lsp-ui-doc-enable t)
  ;; Enable the feature to show a signature help popup
  (setq lsp-ui-sideline-enable t)
  ;; Show diagnostics inline
  (setq lsp-ui-sideline-show-diagnostics t))
(setq ring-bell-function 'ignore)
(use-package company
  :ensure t
  :config
  (add-hook 'after-init-hook 'global-company-mode))

(use-package smartparens
  :ensure t
  :init
  (smartparens-global-mode)
)

; plugins

(when (eq system-type 'darwin)
(load "/Users/eino.korte/repo/emacs.d/plugins/apidoc-eww.el"))

; Keybindings  
(global-set-key (kbd "C-c a") 'apidoc-eww)
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-c <left>")  'windmove-left)
(global-set-key (kbd "C-c <right>") 'windmove-right)
(global-set-key (kbd "C-c <up>")    'windmove-up)
(global-set-key (kbd "C-c <down>")  'windmove-down)
(global-set-key [M-left] 'tabbar-backward-tab)
(global-set-key [M-right] 'tabbar-forward-tab)
(global-set-key (kbd "C-c d") #'deadgrep)
(global-set-key (kbd "C-c t") 'treemacs)
(global-set-key (kbd "C-c e") 'eval-buffer)
(global-set-key (kbd "C-c g") 'google-this)
(global-set-key (kbd "C-c r") 'golden-ratio)
; (define-key evil-normal-state-map (kbd "€") 'move-end-of-line)
(define-key global-map (kbd "s-4") 'move-end-of-line)
(tab-bar-mode 1)
(rainbow-mode 1)
(helm-mode 1)
(winner-mode 1)
(golden-ratio 1)
(global-set-key (kbd "C-c c") 'comment-region)
; (ac-config-default)
(when (eq system-type 'darwin)
  (global-set-key (kbd "M-(") (lambda () (interactive) (insert "{}")))
  (global-set-key (kbd "M-)") (lambda () (interactive) (insert "}")))
  (global-set-key (kbd "M-8") (lambda () (interactive) (insert "[]")))
  (global-set-key (kbd "M-9") (lambda () (interactive) (insert "]")))
  (global-set-key (kbd "M-<") (lambda () (interactive) (insert "|"))))
(use-package web-mode
  :ensure t
  :mode
  (("\\.phtml\\'" . web-mode)
   ("\\.php\\'" . web-mode)
   ("\\.js\\'" . web-mode)
   ("\\.jsx\\'" . web-mode)
   ("\\.ts\\'" . web-mode)
   ("\\.tsx\\'" . web-mode)
   ("\\.tpl\\'" . web-mode)
   ("\\.[agj]sp\\'" . web-mode)
   ("\\.as[cp]x\\'" . web-mode)
   ("\\.erb\\'" . web-mode)
   ("\\.mustache\\'" . web-mode)
   ("\\.djhtml\\'" . web-mode)))
(setq desktop-restore-forces-onscreen nil)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'lsp-mode)
(add-hook 'web-mode-hook 'company-mode)
(add-hook 'web-mode-hook 'lsp-ui-mode)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
; Dashboard
(require 'dimmer)
 (dimmer-configure-which-key)
 (dimmer-configure-helm)
 (dimmer-mode t)

(when (eq system-type 'darwin)
(set-face-attribute 'default nil
                    :family "Andale Mono"
                    :height 120))  ;; Adjust height as needed (110 is 11pt)
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
  '(minimap-active-region-background
    ((((background dark)) (:background "#40e0d0"))
      (t (:background "#000000")))
    "Face for the active region in the minimap.
By default, this is only a different background color."
    :group 'minimap))
