;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-
(defun light-mode ()
  (interactive)
  (load-theme 'doom-one-light))

(defun dark-mode ()
  (interactive)
  (load-theme 'doom-vibrant))

;; ui
(setq doom-theme 'doom-vibrant
      doom-font (font-spec :family "Source Code Pro" :size 17)
      doom-variable-pitch-font (font-spec :family "Source Sans Pro")
      doom-big-font (font-spec :family "Source Code Pro" :size 20))
(global-visual-line-mode 0)
(remove-hook 'text-mode-hook #'auto-fill-mode)
(auto-fill-mode 0)

;; emacs
(setq dired-dwim-target t)

;; lang

;; guile
;; Fedora 30 installs Guile 2.0 and 2.2 as separate packages;
;; make Geiser use 2.2
(setq geiser-guile-binary "/usr/bin/guile2.2"
      geiser-active-implementations '(guile))

;; LaTeX
(setq auto-mode-alist (cons '("\\.latex$" . latex-mode) auto-mode-alist))

;; org-mode
(after! org
  ; stop hard line breaks in org mode
  ;(add-hook 'org-mode-hook 'visual-line-mode)
  (remove-hook 'org-mode-hook 'auto-fill-mode)
  (setq org-todo-keywords
        '((sequence "TODO(t)" "IN PROGRESS(p)" "WAITING(w)" "|" "DONE(d)" "CLOSED(c)")))
  (setq org-todo-keyword-faces
        '(("IN PROGRESS" warning bold)
          ("WAITING" error bold)
          ("CLOSED" org-done)))
  (setq org-default-notes-file
        (expand-file-name +org-capture-notes-file org-directory)
        org-capture-templates
        '(("t" "TODO" entry
           (file+headline +org-capture-todo-file "Inbox")
           "* TODO %^{What do you need to do?}\n%?" :prepend t :kill-buffer t)
          ("n" "Note" entry (file+headline +org-capture-todo-file "Notes")
           "* %?\n%t"))
        )
  (setq org-archive-location (concat "archive/archive-" (format-time-string "%Y%m" (current-time)) ".org_archive::"))
  (setq org-startup-truncated nil)
  (setq org-log-done 'time)
  (setq org-export-with-smart-quotes t))

;; salt
(add-hook 'salt-mode-hook
          (lambda()
            (flyspell-mode 1)))

;; custom key bindings
;; or, reverting stupid doom decisions
(map! :ne "SPC m l" #'light-mode
      :ne "SPC m d" #'dark-mode)

(map! (:after org
        :map org-mode-map
        :ni [C-return] #'org-insert-heading-respect-content
        :ni [C-S-return] #'org-insert-todo-heading-respect-content

        :map outline-mode-map
        :ni [C-return] #'org-insert-heading-respect-content
        :ni [C-S-return] #'org-insert-todo-heading-respect-content

        :map evil-org-mode-map
        :ni [C-return] #'org-insert-heading-respect-content
        :ni [C-S-return] #'org-insert-todo-heading-respect-content))
