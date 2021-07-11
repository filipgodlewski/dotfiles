;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; SETUP
(setq user-full-name "Filip Godlewski"
      user-mail-address "f@godlewski.xyz")

;; FONT
(setq-default line-spacing 2)
(setq doom-font (font-spec :family "FiraCode Nerd Font Mono" :size 12 :weight 'regular))

(custom-set-faces!
  '(font-lock-builtin-face :family "Victor Mono" :size 12 :slant italic)
  '(font-lock-comment-face :family "Victor Mono" :size 12 :slant italic)
)

;; THEME
(setq doom-theme 'doom-gruvbox)

;; EDITOR
(setq display-line-numbers nil)

;; ORG-MODE
(setq org-directory "~/org/")

;; PROJECTILE
(setq projectile-project-search-path '("~/Documents/personal_projects" "~/Documents/learning"))
