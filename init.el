(require 'package)
(add-to-list 'package-archives
             '("melpa" . "https://melpa.org/packages/"))
(package-initialize)
(package-refresh-contents)
; Backup files
(setq backup-directory-alist '(("" . "~/.emacs.d/emacs-backup")))

;; Download Evil
(unless (package-installed-p 'evil)
  (package-install 'evil))
; Download treemacs
(unless (package-installed-p 'treemacs)
  (package-install 'treemacs))
(unless (package-installed-p 'treemacs-evil)
  (package-install 'treemacs-evil))
(unless (package-installed-p 'dashboard)
  (package-install 'dashboard))
(unless (package-installed-p 'lua-mode)
  (package-install 'lua-mode))
(unless (package-installed-p 'dumb-jump)
  (package-install 'dumb-jump))
(unless (package-installed-p 'helm)
  (package-install 'helm))
(unless (package-installed-p 'dracula-theme)
  (package-install 'dracula-theme))
(unless (package-installed-p 'minimap)
  (package-install 'minimap))
(unless (package-installed-p 'auto-complete)
  (package-install 'auto-complete))
(unless (package-installed-p 'shell-pop)
  (package-install 'shell-pop))
(unless (package-installed-p 'js2-mode)
  (package-install 'js2-mode))
(unless (package-installed-p 'rjsx-mode)
  (package-install 'rjsx-mode))
(unless (package-installed-p 'flycheck)
  (package-install 'flycheck))
(unless (package-installed-p 'evil-matchit)
  (package-install 'evil-matchit))
(unless (package-installed-p 'cider)
  (package-install 'cider))
(unless (package-installed-p 'go-mode)
  (package-install 'go-mode))
(unless (package-installed-p 'undo-tree)
  (package-install 'undo-tree))
(unless (package-installed-p 'smartparens)
  (package-install 'smartparens))
(unless (package-installed-p 'web-mode)
  (package-install 'web-mode))
(unless (package-installed-p 'prettier)
  (package-install 'prettier))
;(unless (package-installed-p 'lsp-mode)
;  (package-install 'lsp-mode))

; Find
(setq ido-use-filename-at-point nil)

; Undo-tree
;; Prevent undo tree files from polluting your git repo
(setq undo-tree-history-directory-alist '(("." . "~/.emacs.d/undo")))

; Prettier
(setenv "NODE_PATH" "/usr/local/lib/node_modules")

; Smartparens

(smartparens-global-mode t)

; Flycheck
(require 'flycheck)
(global-flycheck-mode 1)

(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))
(setq-default flycheck-temp-prefix ".flycheck")
;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
	  '(json-jsonlist)))
(defun my/use-eslint-from-node-modules ()
  (let ((root (locate-dominating-file
               (or (buffer-file-name) default-directory)
               (lambda (dir)
                 (let ((eslint (expand-file-name "node_modules/eslint/bin/eslint.js" dir)))
                  (and eslint (file-executable-p eslint)))))))
    (when root
      (let ((eslint (expand-file-name "node_modules/eslint/bin/eslint.js" root)))
        (setq-local flycheck-javascript-eslint-executable eslint)))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)


;; use local eslint from node_modules before global
;; http://emacs.stackexchange.com/questions/21205/flycheck-with-file-relative-eslint-executable
;(defun my/use-eslint-from-node-modules ()
;(let* ((root (locate-dominating-file
;                (or (buffer-file-name) default-directory)
;                "node_modules"))
;         (eslint (and root
;                      (expand-file-name "../node_modules/eslint/bin/eslint.js"
;                                        root))))
;    (when (and eslint (file-executable-p eslint))
;      (setq-local flycheck-javascript-eslint-executable eslint))))
;(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)
; Matchit
(require 'evil-matchit)
(global-evil-matchit-mode 1)
;Autosave
(setq auto-save-default nil)

; Javascript
(require 'js2-mode)
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . js2-mode))

; Windmove
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))

; Tabs

(global-tab-line-mode t)
; Autocomplete

(global-auto-complete-mode t)


; Minimap

(setq minimap-window-location 'right)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minimap-active-region-background ((((background dark)) (:background "#2A2A2A222222")) (t (:background "#D3D3D3222222"))) nil :group))

; Theming

(load-theme 'dracula t)
(set-frame-font "Ubuntu Mono 12" nil t)

; Keybindings
(global-set-key (kbd "C-c t") 'treemacs)
(global-set-key (kbd "C-c g") 'dumb-jump-go)
(global-set-key (kbd "C-c l") 'helm-locate)
(global-set-key (kbd "C-c f") 'rgrep)
(global-set-key (kbd "C-c b") 'shell)
(global-set-key (kbd "M-x") 'helm-M-x)
; Dashboard
;; Set the title
(setq dashboard-banner-logo-title "Welcome to Emacs!")
; Set the banner
(setq dashboard-startup-banner "~/repo/configurations/media/icons/mursu_tietokoneella.png")
;; Content is not centered by default. To center, set
(setq dashboard-center-content t)
(setq dashboard-set-footer nil)

;; Enable Evil
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
(require 'undo-tree)
(evil-set-undo-system 'undo-tree)
(global-undo-tree-mode 1)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(evil))
 '(shell-pop-autocd-to-working-dir t)
 '(shell-pop-default-directory "~/repo")
 '(shell-pop-universal-key "C-x s")
 '(shell-pop-window-position "bottom")
 '(warning-suppress-log-types '((comp) (comp)))
 '(warning-suppress-types '(((unlock-file)) (comp) (comp))))

; Undo-tree
(require 'dashboard)
(dashboard-setup-startup-hook)
(add-hook 'xref-backend-functions #'dumb-jump-xref-activate)
