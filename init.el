;;; init.el --- Emacs config for Elixir hacking  -*- lexical-binding: t; -*-

;; Copyright (C) 2024 Wilhelm H Kirschbaum

;; Author           : Wilhelm H Kirschbaum
;; Version          : 1.0
;; URL              : https://github.com/wkirschbaum/elixir-developer-mode
;; Package-Requires : ((emacs "30.1"))
;; Created          : December 2024
;; Keywords         : elixir languages tree-sitter


;; Copyright (C) 2024-2025 Wilhelm H Kirschbaum

;; Author: Wilhelm H Kirschbaum <wkirschbaum@gmail.com>
;; Created: December 2024
;; Keywords: elixir languages tree-sitter

;;  This program is free software: you can redistribute it and/or modify
;;  it under the terms of the GNU General Public License as published by
;;  the Free Software Foundation, either version 3 of the License, or
;;  (at your option) any later version.

;;  This program is distributed in the hope that it will be useful,
;;  but WITHOUT ANY WARRANTY; without even the implied warranty of
;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;;  GNU General Public License for more details.

;;  You should have received a copy of the GNU General Public License
;;  along with this program.  If not, see <https://www.gnu.org/licenses/>.


;;; Commentary:

;; This package defines elixir-ts-mode which is a major mode for editing
;; Elixir and Heex files.

;; Features

;;; Code:

;; Runtime tweaks
(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))

;; Native config
(add-hook 'prog-mode-hook 'display-line-numbers-mode)

;; Set up the package manager
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)

;; Add extra packages

;;; completion help
(use-package which-key
  :ensure t)

;;; Git porcelain
(use-package magit
  :ensure t)

;;; Language server
(use-package lsp-mode
  :ensure t
  :init
  ;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
  (setq lsp-keymap-prefix "C-c l")
  :hook ((lsp-mode . lsp-enable-which-key-integration))
  :commands lsp)

;; Load ts-modes if they can be loaded
(require 'treesit)

(setq treesit-language-source-alist
      '((elixir "https://github.com/elixir-lang/tree-sitter-elixir")
        (heex "https://github.com/phoenixframework/tree-sitter-heex")))

(defun elixir-bootstrap ()
  (interactive)
  (mapc #'treesit-install-language-grammar (mapcar #'car treesit-language-source-alist))
  (lsp-install-server t 'elixir-ls)
  (require 'elixir-ts-mode)
  (require 'heex-ts-mode))

;; automatically bootstrap when the treesit libraries aren't loaded
(if (or (not (treesit-ready-p 'elixir t)) (not (treesit-ready-p 'heex t)))
    (elixir-bootstrap))

(if (treesit-ready-p 'elixir t) (require 'elixir-ts-mode))
(if (treesit-ready-p 'heex t) (require 'heex-ts-mode))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(lsp-elixir-ls-download-url
   (format
    (concat "https://github.com/elixir-lsp/elixir-ls"
	    "/releases/download/%1$s/elixir-ls-%1$s.zip")
    lsp-elixir-ls-version))
 '(lsp-elixir-ls-version "v0.26.0")
 '(package-selected-packages nil))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; init.el ends here
