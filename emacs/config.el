(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(setq package-enable-at-startup nil)

(package-initialize)
(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(require 'use-package)

(setq use-package-always-ensure t)

(use-package auto-package-update
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (setq auto-package-update-prompt-before-update t)
  (auto-package-update-maybe))

(use-package benchmark-init
  :config
  ;; To disable collection of benchmark data after init is done.
  (add-hook 'after-init-hook 'benchmark-init/deactivate))

(add-hook 'after-init-hook
          (lambda () (message "loaded in %s" (emacs-init-time))))

(setq gc-cons-threshold 10000000)

;; Restore after startup
(add-hook 'after-init-hook
          (lambda ()
            (setq gc-cons-threshold 1000000)
            (message "gc-cons-threshold restored to %S"
                     gc-cons-threshold)))

(defun find-config ()
  "Edit config.org"
  (interactive)
  (find-file "~/dotfiles/emacs/config.org"))

(global-set-key (kbd "C-c I") 'find-config)

(setq custom-file (make-temp-file "emacs-custom"))

(add-to-list 'load-path "~/.emacs.d/lisp/")

(setq inhibit-startup-screen t)

(setq-default fill-column 80)
(setq-default word-wrap t)
(auto-fill-mode 1)

(tool-bar-mode -1)
(scroll-bar-mode -1)
(menu-bar-mode -1)

(setq ring-bell-function 'ignore)

(defalias 'yes-or-no-p 'y-or-n-p)

(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )

(setq-default indent-tabs-mode nil)

(setq explicit-shell-file-name "/usr/bin/fish")

(setq dired-listing-switches "-lthG --group-directories-first")

(use-package crux
  :bind (("C-a" . crux-move-beginning-of-line)))

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(use-package smex)

(use-package ivy
    :diminish ivy-mode
    :config
    (ivy-mode t)
    (setq ivy-display-style 'fancy))

(setq ivy-initial-inputs-alist nil)

(use-package counsel
  :bind (("M-x" . counsel-M-x)))

(use-package swiper)
(global-set-key (kbd "C-s") 'counsel-grep-or-swiper)

(use-package ivy-hydra)

(use-package which-key
  :diminish which-key-mode
  :config
  (add-hook 'after-init-hook 'which-key-mode))

(use-package undo-tree
  :defer 5
  :diminish global-undo-tree-mode
  :config
  (global-undo-tree-mode 1))

(use-package avy)

(use-package ace-window
   :config
   (global-set-key (kbd "C-x o") 'ace-window)
   (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l)))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package doom-themes
  :config
  (load-theme 'doom-nord-light t))
(use-package all-the-icons)

(set-frame-font "Source Code Pro 12" nil t)

(use-package feebleline
  :custom
  (feebleline-show-git-branch t)
  (feebleline-show-dir t)
  (feebleline-show-time t)
  (feebleline-show-previous-buffer t)
  :config
  (feebleline-mode 1))

(use-package emojify)

(use-package focus)

(global-hl-line-mode 1)

(use-package smartparens
  :diminish smartparens-mode
  :hook
  (prog-mode . smartparens-mode))

(use-package rainbow-delimiters
  :hook
  (prog-mode . rainbow-delimiters-mode))

(use-package rainbow-mode
  :config
  (setq rainbow-x-colors nil)
  :hook
  (prog-mode . rainbow-mode))

(use-package aggressive-indent)

(add-hook 'prog-mode-hook 'electric-pair-mode)

(use-package smart-dash
  :config
  :hook
  (c-mode . smart-dash-mode)
  (c++-mode . smart-dash-mode))

(add-hook 'prog-mode-hook 'flyspell-prog-mode)

(use-package projectile
  :config
  (projectile-mode))

(setq projectile-completion-system 'ivy)

(use-package counsel-projectile
  :config
  (add-hook 'after-init-hook 'counsel-projectile-mode))

(use-package fzf)

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package dumb-jump
  :diminish dumb-jump-mode
  :bind (("C-M-g" . dumb-jump-go)
         ("C-M-p" . dumb-jump-back)
         ("C-M-q" . dumb-jump-quick-look)))

(use-package magit
  :bind ("C-x g" . magit-status))

(use-package git-gutter
  :config
  (global-git-gutter-mode 't)
  :diminish git-gutter-mode)

(use-package git-timemachine)

(use-package flycheck
  :config
  (add-hook 'after-init-hook 'global-flycheck-mode)
  (add-to-list 'flycheck-checkers 'proselint)
  (setq-default flycheck-highlighting-mode 'lines)
  ;; Define fringe indicator / warning levels
  (define-fringe-bitmap 'flycheck-fringe-bitmap-ball
    (vector #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00011100
            #b00111110
            #b00111110
            #b00111110
            #b00011100
            #b00000000
            #b00000000
            #b00000000
            #b00000000
            #b00000000))
  (flycheck-define-error-level 'error
    :severity 2
    :overlay-category 'flycheck-error-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-ball
    :fringe-face 'flycheck-fringe-error)
  (flycheck-define-error-level 'warning
    :severity 1
    :overlay-category 'flycheck-warning-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-ball
    :fringe-face 'flycheck-fringe-warning)
  (flycheck-define-error-level 'info
    :severity 0
    :overlay-category 'flycheck-info-overlay
    :fringe-bitmap 'flycheck-fringe-bitmap-ball
    :fringe-face 'flycheck-fringe-info))

(flycheck-define-checker proselint
  "A linter for prose."
  :command ("proselint" source-inplace)
  :error-patterns
  ((warning line-start (file-name) ":" line ":" column ": "
            (id (one-or-more (not (any " "))))
            (message (one-or-more not-newline)
                     (zero-or-more "\n" (any " ") (one-or-more not-newline)))
            line-end))
  :modes (text-mode markdown-mode gfm-mode org-mode))

(use-package company
  :diminish
  :config
  (add-hook 'after-init-hook 'global-company-mode)

  (setq company-idle-delay t)

  (use-package company-anaconda
    :config
    (add-to-list 'company-backends 'company-anaconda)))

(setq company-dabbrev-downcase nil)

(use-package yasnippet
    :diminish yas-minor-mode
    :config
    (add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippet-snippets")
    (add-to-list 'yas-snippet-dirs "~/.emacs.d/snippets")
    (yas-global-mode)
    (global-set-key (kbd "M-/") 'company-yasnippet))
(use-package yasnippet-snippets)

(use-package markdown-mode
  :commands (markdown-mode gfm-mode)
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))

(use-package haskell-mode)

(use-package hindent)

(use-package ghc
  :config
  (add-hook 'haskell-mode-hook (lambda () (ghc-init))))

(use-package company-ghc
  :config
  (add-to-list 'company-backends 'company-ghc))

;; (use-package anaconda-mode
;;   :config
;;   (add-hook 'python-mode-hook 'anaconda-mode)
;;   (add-hook 'python-mode-hook 'anaconda-eldoc-mode))

(use-package blacken)

(when (executable-find "ipython")
  (setq python-shell-interpreter "ipython"))

(use-package irony
  :hook
  (c-mode . irony-mode)
  (c++-mode . irony-mode))

(use-package company-irony
  :config
  (add-to-list 'company-backends 'company-irony))

(use-package flycheck-irony
  :hook
  (flycheck-mode . flycheck-irony-setup))

(use-package tex
  :demand t
  :ensure auctex
  :config
    (setq-default TeX-engine 'luatex)
    (setq-default TeX-PDF-mode t)
    (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
    (setq reftex-plug-into-AUCTeX t)
    (setq reftex-bibliography-commands '("bibliography" "nobibliography" "addbibresource"))
    (setq reftex-use-external-file-finders t)
    (setq reftex-external-file-finders
          '(("tex" . "kpsewhich -format=.tex %f")
            ("bib" . "kpsewhich -format=.bib %f")))
    (setq TeX-electric-sub-and-superscrip t)
    (setq TeX-electric-math (cons "\\(" "\\)"))
  :hook
    ((LaTeX-mode . visual-line-mode)
     (LaTeX-mode . turn-on-auto-fill)
     (LaTeX-mode . flyspell-mode)
     (LaTeX-mode . LaTeX-math-mode)
     (LaTeX-mode . turn-on-reftex)
     (TeX-after-compilation-finished-functions
       . TeX-revert-document-buffer)))

(use-package auctex-latexmk
  :hook
    (LaTeX-mode . auctex-latexmk-setup))

(use-package company-math
  :config
    (setq company-math-allow-unicode-symbols-in-faces
      '(tex-math font-latex-math-face))
    (setq company-math-allow-latex-symbols-in-faces nil)
    (setq company-math-disallow-unicode-symbols-in-faces nil)
    (add-to-list 'company-backends 'company-math-symbols-unicode)
    (add-to-list 'company-backends 'company-math-symbols-latex))

(setq org-startup-indented 'f)
(setq org-directory "~/org")
(setq org-special-ctrl-a/e 't)
(setq org-default-notes-file (concat org-directory "/notes.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-src-window-setup 'current-window)

(use-package org-bullets
  :config
  (setq org-bullets-bullet-list '("∙"))
  (add-hook 'org-mode-hook 'org-bullets-mode))

(setq org-fontify-whole-heading-line t)

(use-package ox-twbs)

(use-package ob-ipython)
(org-babel-do-load-languages
  'org-babel-load-languages
    '((python . t)
      (ipython . t)
      (shell . t)
      (latex . t)
      (C . t)))

(setq org-src-fontify-natively 't)
(setq org-src-tab-acts-natively t)

(org-add-link-type "cite"
     (defun follow-cite (name)
       "Open bibliography and jump to appropriate entry.
        The document must contain \addbibresource{filename} somewhere
        for this to work"
       (find-file-other-window
        (save-excursion
          (beginning-of-buffer)
          (save-match-data
            (re-search-forward "\\\\addbibresource{\\([^}]+\\)}")
            (concat (match-string 1) ".bib"))))
       (beginning-of-buffer)
       (search-forward name))
     (defun export-cite (path desc format)
       "Export [[autocite:cohen93]] as \autocite{cohen93} in LaTeX."
       (if (eq format 'latex)
           (if (or (not desc) (equal 0 (search "autocite:" desc)))
               (format "\\autocite{%s}" path)
             (format "\\autocite[%s]{%s}" desc path)))))

(add-to-list 'org-latex-classes
             '("notes"
               "\\documentclass{article}
   \\usepackage{mathtools}
   \\usepackage{physics}
   \\usepackage{fontspec}
   \\usepackage{unicode-math}
   \\usepackage[style=phys, hyperref=true, backref=true, backend=biber]{biblatex}
   \\usepackage[colorlinks=true, citecolor=red, breaklinks]{hyperref}
   [NO-DEFAULT-PACKAGES]
   [PACKAGES]
                \\setmainfont{Libertinus Serif}
                \\setmathfont{Libertinus Math}
                \\setsansfont{Libertinus Sans}"
                ("\\section{%s}" . "\\section*{%s}")
                ("\\subsection{%s}" . "\\subsection*{%s}")
                ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                ("\\paragraph{%s}" . "\\paragraph*{%s}")
                ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

(use-package writegood-mode
  :bind ("C-c g" . writegood-mode)
  :config
  (add-to-list 'writegood-weasel-words "actionable"))

(use-package sx
  :config
  (bind-keys :prefix "C-c s"
             :prefix-map my-sx-map
             :prefix-docstring "Global keymap for SX."
             ("q" . sx-tab-all-questions)
             ("i" . sx-inbox)
             ("o" . sx-open-link)
             ("u" . sx-tab-unanswered-my-tags)
             ("a" . sx-ask)
             ("s" . sx-search)))

(use-package notmuch)

(use-package slack
  :commands (slack-start))

(use-package pdf-tools
  :ensure t
  :mode ("\\.pdf\\'" . pdf-view-mode)
  :config
  (pdf-tools-install)
  (setq-default pdf-view-display-size 'fit-page))

(use-package dash)
(use-package dash-functional)

(require 'dired-x)
(setq-default dired-omit-files-p t)
(setq dired-omit-files (concat dired-omit-files "\\|^\\..+$"))

(use-package dired-ranger
  :bind (:map dired-mode-map
              ("W" . dired-ranger-copy)
              ("X" . dired-ranger-move)
              ("Y" . dired-ranger-paste)))
(use-package dired-filter
  :bind (:map dired-mode-map
              ("F" . dired-filter-map)))
(use-package dired-avfs)
(use-package dired-rainbow)
(use-package dired-collapse)
(use-package dired-narrow
  :bind (:map dired-mode-map
              ("/" . dired-narrow)))
(use-package dired-subtree
  :bind (:map dired-mode-map
              ("i" . dired-subtree-insert)
              ("o" . dired-subtree-remove)))

(use-package visual-fill-column
  :config
  (setq visual-fill-column-width 80))
(add-hook 'prog-mode-hook 'turn-on-visual-line-mode)
(add-hook 'text-mode-hook 'turn-on-visual-line-mode)

(use-package fish-completion
  :config
  (global-fish-completion-mode))

(use-package esh-autosuggest
  :hook
  (eshell-mode . esh-autosuggest-mode))
