(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

; general 

(package-initialize)
(package-refresh-contents)
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(exec-path-from-shell-initialize)
(setq create-lockfiles nil) ; this is because react hot reloading messing up with lockfiles


; rust

 
(require 'rust-mode)

; org

(require 'org-roam-protocol)
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)
(global-display-line-numbers-mode)


(defun figwheel-repl ()
  (interactive)
  (inf-clojure "lein figwheel"))



; evil mode 

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
; neotree

(add-to-list 'load-path "~/.emacs.d/packages/neotree")
  (require 'neotree)
  (global-set-key [f1] 'neotree-toggle)
  (evil-define-key 'normal neotree-mode-map (kbd "TAB") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "SPC") 'neotree-quick-look)
    (evil-define-key 'normal neotree-mode-map (kbd "q") 'neotree-hide)
    (evil-define-key 'normal neotree-mode-map (kbd "RET") 'neotree-enter)
    (evil-define-key 'normal neotree-mode-map (kbd "g") 'neotree-refresh)
    (evil-define-key 'normal neotree-mode-map (kbd "n") 'neotree-next-line)
    (evil-define-key 'normal neotree-mode-map (kbd "p") 'neotree-previous-line)
    (evil-define-key 'normal neotree-mode-map (kbd "A") 'neotree-stretch-toggle)
    (evil-define-key 'normal neotree-mode-map (kbd "H") 'neotree-hidden-file-toggle)


; theme

(load-theme 'dracula t)

; latex

(add-hook 'LaTeX-mode-hook 'turn-on-cdlatex)
(setq org-latex-create-formula-image-program 'imagemagick)
(setq org-format-latex-options (plist-put org-format-latex-options :scale 2.0))


; generated things

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-safe-themes
   (quote
    ("7451f243a18b4b37cabfec57facc01bd1fe28b00e101e488c61e1eed913d9db9" default)))
 '(elfeed-feeds
   (quote
    ("https://feeds.yle.fi/uutiset/v1/majorHeadlines/YLE_UUTISET.rss" "https://www.reddit.com/r/dota2/.rss" "https://feeds.yle.fi/uutiset/v1/recent.rss?pub" "https://www.reddit.com/r/programming/.rss" "https://www.reddit.com/r/javascript/.rss" "https://www.reddit.com/r/clojure/.rss" "https://www.reddit.com/r/Linux/.rss" "https://www.reddit.com/r/webdev/.rss" "https://www.reddit.com/r/news/.rss" "https://www.reddit.com/r/worldnews/.rss")))
 '(org-agenda-files (quote ("~/org-roam/study/math/mathematics.org")))
 '(package-selected-packages
   (quote
    (javaimp vue-mode web-mode elfeed latex-math-preview inf-clojure dracula-theme auto-complete paredit slime cider clojure-mode magit org-roam rust-mode ws-butler winum which-key volatile-highlights vi-tilde-fringe uuidgen use-package toc-org spaceline restart-emacs request rainbow-delimiters popwin persp-mode pcre2el paradox org-plus-contrib org-bullets open-junk-file neotree move-text macrostep lorem-ipsum linum-relative link-hint indent-guide hungry-delete hl-todo highlight-parentheses highlight-numbers highlight-indentation helm-themes helm-swoop helm-projectile helm-mode-manager helm-make helm-flx helm-descbinds helm-ag google-translate golden-ratio flx-ido fill-column-indicator fancy-battery eyebrowse expand-region exec-path-from-shell evil-visualstar evil-visual-mark-mode evil-unimpaired evil-tutor evil-surround evil-search-highlight-persist evil-numbers evil-nerd-commenter evil-mc evil-matchit evil-lisp-state evil-indent-plus evil-iedit-state evil-exchange evil-escape evil-ediff evil-args evil-anzu eval-sexp-fu elisp-slime-nav dumb-jump diminish define-word column-enforce-mode clean-aindent-mode auto-highlight-symbol auto-compile aggressive-indent adaptive-wrap ace-window ace-link ace-jump-helm-line))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
(show-paren-mode 1)
(server-start)
