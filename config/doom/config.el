;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
;;
;;
;;


(setq doom-theme 'doom-one)
(setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))

;;; Theme and Fonts ----------------------------------------
(set-frame-parameter nil 'alpha-background 95) ; For current frame
(add-to-list 'default-frame-alist '(alpha-background . 95)) ; For all new frames henceforth

;; Let the desktop background show through
(defun kb/toggle-window-transparency ()
  "Toggle transparency."
  (interactive)
  (let ((alpha-transparency 95))
    (if (< (or (frame-parameter nil 'alpha-background) 100) 100)
        (set-frame-parameter nil 'alpha-background 100)
      (set-frame-parameter nil 'alpha-background alpha-transparency))))

;; Install doo-thmemes
;; (unless (package-installed-p 'doom-themes)
;;   (package-install 'doom-themes))

;; Load up doom-palenight for the System Crafters look
;; (load-theme 'doom-palenight t)

;; Set reusable font name variables
;; (defvar my/fixed-width-font "JetBrains Mono"
;;   "The font to use for monospaced (fixed width) text.")
;; (set-fontset-font t 'hangul (font-spec :family "D2Coding"))
;; (defvar my/fixed-width-font "D2CodingLigature Nerd Font"
;;   "The font to use for monospaced (fixed width) text.")
(defvar my/fixed-width-font "JetBrainsMono Nerd Font"
  "The font to use for monospaced (fixed width) text.")

(defvar my/variable-width-font "Iosevka Aile"
  "The font to use for variable-pitch (document) text.")

(defvar my/hangul-font "D2CodingLigature Nerd Font"
  "The font to use for hangul (document) text.")

;; NOTE: These settings might not be ideal for your machine, tweak them as needed!
(set-face-attribute 'default nil :font my/fixed-width-font :weight 'light :height 110)
(set-face-attribute 'fixed-pitch nil :font my/fixed-width-font :weight 'light :height 110)
(set-face-attribute 'variable-pitch nil :font my/variable-width-font :weight 'light :height 1.1)
;;(set-face-attribute 'hangul nil :font my/hangul-font :weight 'light :height 120)
(set-fontset-font t 'hangul (font-spec :family my/hangul-font :height 120)) ;

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.

(setq display-line-numbers-type `relative)
;;set ui-helpers
(global-display-line-numbers-mode 1)
(setq display-line-numbers 'relative)
(setq display-line-numbers-width 'auto)

;; Set the cursor color
                                        ;(setq-default cursor-type 'bar) ;; or '(bar . 2) for a thicker bar
(set-cursor-color "coral") ;; Replace "red" with your desired color

(setq default-input-method "korean-hangul")
(add-hook 'post-command-hook
          (lambda ()
            (set-cursor-color
             (if current-input-method "tan" "coral"))))


(with-eval-after-load 'simple
  (setq-default display-fill-column-indicator-column 80)
  (add-hook 'prog-mode-hook 'display-fill-column-indicator-mode))

;;FONTS
;; (add-to-list 'default-frame-alist '(font . "JetBrainsMono Nerd Font-11"))
;; (add-to-list 'default-frame-alist '(font . "D2CodingLigature Nerd Font-11"))
;; (set-fontset-font t 'hangul (font-spec :family "font-jetbrains-mono"))
;; (add-to-list 'language-specific-font-alist '("korean" . "D2CodingLigature Nerd Font-11"))

(set-language-environment "Korean")
(prefer-coding-system 'utf-8)

;; #set editing tools
(map! :leader
      :desc "Comment line" ";" #'comment-line)


;;##consult-repgrep - search
;; You can use this hydra menu that have all the commands
;; (map! :n "s-SPC" 'harpoon-quick-menu-hydra)
;; (map! :n "s-s" 'harpoon-add-file)
(defun consult-ripgrep-with-last-regex ()
  "Run consult-ripgrep with the last regex from regex-search-ring."
  (interactive)
  (consult-ripgrep nil (car regexp-search-ring)))

(with-eval-after-load 'simple
  (setq-default display-fill-column-indicator-column 80)
  (add-hook 'prog-mode-hook 'display-fill-column-indicator-mode))

;;##vundo
(use-package vundo
  :commands (vundo)

  :config
  ;; Take less on-screen space.
  (setq vundo-compact-display t)

  ;; Better contrasting highlight.
  (custom-set-faces
    '(vundo-node ((t (:foreground "#808080"))))
    '(vundo-stem ((t (:foreground "#808080"))))
    '(vundo-highlight ((t (:foreground "#FFFF00")))))

  ;; Use `HJKL` VIM-like motion, also Home/End to jump around.
  (define-key vundo-mode-map (kbd "l") #'vundo-forward)
  (define-key vundo-mode-map (kbd "<right>") #'vundo-forward)
  (define-key vundo-mode-map (kbd "h") #'vundo-backward)
  (define-key vundo-mode-map (kbd "<left>") #'vundo-backward)
  (define-key vundo-mode-map (kbd "j") #'vundo-next)
  (define-key vundo-mode-map (kbd "<down>") #'vundo-next)
  (define-key vundo-mode-map (kbd "k") #'vundo-previous)
  (define-key vundo-mode-map (kbd "<up>") #'vundo-previous)
  (define-key vundo-mode-map (kbd "<home>") #'vundo-stem-root)
  (define-key vundo-mode-map (kbd "<end>") #'vundo-stem-end)
  (define-key vundo-mode-map (kbd "q") #'vundo-quit)
  (define-key vundo-mode-map (kbd "C-g") #'vundo-quit)
  (define-key vundo-mode-map (kbd "RET") #'vundo-confirm)

  )
(with-eval-after-load 'meow
  (meow-leader-define-key '("U" . vundo))
  )

(use-package jinx
;  :hook (org-mode . jinx-mode)
  :bind (("M-$" . jinx-correct)
         ("C-M-$" . jinx-languages)))

;; You can use this hydra menu that have all the commands
;; (map! :n "s-SPC" 'harpoon-quick-menu-hydra)
;; (map! :n "s-s" 'harpoon-add-file)
(with-eval-after-load 'meow
  (meow-normal-define-key '("R" . harpoon-quick-menu-hydra))
  (meow-normal-define-key '("S" . harpoon-add-file))
  )
;; And the vanilla commands
(map! :leader "j c" 'harpoon-clear)
(map! :leader "j f" 'harpoon-toggle-file)
(map! :leader "1" 'harpoon-go-to-1)
(map! :leader "2" 'harpoon-go-to-2)
(map! :leader "3" 'harpoon-go-to-3)
(map! :leader "4" 'harpoon-go-to-4)
(map! :leader "5" 'harpoon-go-to-5)
(map! :leader "6" 'harpoon-go-to-6)
(map! :leader "7" 'harpoon-go-to-7)
(map! :leader "8" 'harpoon-go-to-8)
(map! :leader "9" 'harpoon-go-to-9)

(with-eval-after-load 'geiser-mode
  (setq geiser-mode-auto-p nil)
  (defun orka-geiser-connect ()
    (interactive)
    (geiser-connect 'guile "localhost" "37146"))

  (define-key geiser-mode-map (kbd "C-c M-j") 'orka-geiser-connect))

(with-eval-after-load 'meow
  (meow-normal-define-key '("C-j" . meow-page-down))
  (meow-normal-define-key '("C-k" . meow-page-up))
  (meow-normal-define-key '("/" . isearch-forward-regexp))
  (meow-normal-define-key '("?" . consult-ripgrep-with-last-regex))
  (meow-normal-define-key '("M-f" . find-grep-dired))
  (meow-normal-define-key '("M-o" . browse-url-at-point))
  (meow-normal-define-key '("C-o" . pop-global-mark))
  (meow-leader-define-key '("y" . meow-clipboard-save))
  (meow-leader-define-key '("p" . meow-clipboard-yank))
  )



(global-set-key (kbd "M-n") 'ace-window)



(defun lsp-booster--advice-json-parse (old-fn &rest args)
  "Try to parse bytecode instead of json."
  (or
   (when (equal (following-char) ?#)
     (let ((bytecode (read (current-buffer))))
       (when (byte-code-function-p bytecode)
         (funcall bytecode))))
   (apply old-fn args)))
(advice-add (if (progn (require 'json)
                       (fboundp 'json-parse-buffer))
                'json-parse-buffer
              'json-read)
            :around
            #'lsp-booster--advice-json-parse)

(defun lsp-booster--advice-final-command (old-fn cmd &optional test?)
  "Prepend emacs-lsp-booster command to lsp CMD."
  (let ((orig-result (funcall old-fn cmd test?)))
    (if (and (not test?)                             ;; for check lsp-server-present?
             (not (file-remote-p default-directory)) ;; see lsp-resolve-final-command, it would add extra shell wrapper
             lsp-use-plists
             (not (functionp 'json-rpc-connection))  ;; native json-rpc
             (executable-find "emacs-lsp-booster"))
        (progn
          (when-let ((command-from-exec-path (executable-find (car orig-result))))  ;; resolve command from exec-path (in case not found in $PATH)
            (setcar orig-result command-from-exec-path))
          (message "Using emacs-lsp-booster for %s!" orig-result)
          (cons "emacs-lsp-booster" orig-result))
      orig-result)))
(advice-add 'lsp-resolve-final-command :around #'lsp-booster--advice-final-command)

    (use-package lsp-mode
      :commands lsp
      :hook ((c-mode c++-mode) . lsp-deferred)
      :config
      (setq lsp-prefer-flymake nil) ; or t, depending on preference
      ;; Add other clangd-specific settings here if needed
      )

    (use-package rustic
      :mode "\\.rs\\'"
      :hook (rustic-mode . lsp-deferred)
      :config
      ;; Add rustic/rust-analyzer specific settings here
      (setq rustic-format-on-save t) ; Example: enable formatting on save
      )

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/notes/"
      org-roam-directory "~/notes/resources/")

(add-hook 'org-mode-hook #'hl-todo-mode)
(setq display-line-numbers-width 'auto)

(require 'org-indent)

(setq org-log-reschedule 'time)

  (custom-set-variables
   '(org-agenda-custom-commands
     '(("o" "Office agenda, ignore PERSONAL tag"
        ((agenda ""))
        ((org-agenda-tag-filter-preset '("-PERSONAL"))))
       ("v" "Personal agenda, ignore OFFICE tag"
        ((agenda ""))
        ((org-agenda-tag-filter-preset '("-OFFICE"))))
       )))

(with-eval-after-load 'meow
  (meow-leader-define-key '("N" . org-roam-node-find))
  (meow-leader-define-key '("P" . org-roam-capture))
  (meow-leader-define-key '("C" . org-capture))
  )

(with-eval-after-load 'org
  (setq org-use-speed-commands t)
  (setq org-enforce-todo-dependencies t)

  (setq org-lowest-priority ?F)  ;; Gives us priorities A through F
  (setq org-default-priority ?E) ;; If an item has no priority, it is considered [#E].

  (setq org-priority-faces
        '((65 . "#BF616A")
          (66 . "#EBCB8B")
          (67 . "#B48EAD")
          (68 . "#81A1C1")
          (69 . "#5E81AC")
          (70 . "#4C566A")))

  (setq org-todo-keywords
        '((sequence
           "TODO(t)" "START(s)" "HOLD(h)" "WAIT(w)" "IDEA(i)" ; Needs further action
           "|"
           "DONE(d)" "DELIGATED(e)")))                           ; Needs no action currently

  (setq org-todo-keyword-faces
        '(("TODO"      :inherit (org-todo region) :foreground "#A3BE8C" :weight bold)
          ("START"      :inherit (org-todo region) :foreground "#88C0D0" :weight bold)
          ("HOLD"      :inherit (org-todo region) :foreground "#8FBCBB" :weight bold)
          ("WAIT"     :inherit (org-todo region) :foreground "#81A1C1" :weight bold)
          ("IDEA"      :inherit (org-todo region) :foreground "#EBCB8B" :weight bold)
          ("DONE"      :inherit (org-todo region) :foreground "#30343d" :weight bold)
          ("DELIGATED" :inherit (org-todo region) :foreground "#20242d" :weight bold)
          ))

  ;; (custom-theme-set-faces!
  ;;   'doom-one
    ;; '(org-level-8 :inherit outline-3 :height 1.0)
    ;; '(org-level-7 :inherit outline-3 :height 1.0)
    ;; '(org-level-6 :inherit outline-3 :height 1.1)
    ;; '(org-level-5 :inherit outline-3 :height 1.2)
    ;; '(org-level-4 :inherit outline-3 :height 1.3)
    ;; '(org-level-3 :inherit outline-3 :height 1.4)
    ;; '(org-level-2 :inherit outline-2 :height 1.5)
    ;; '(org-level-1 :inherit outline-1 :height 1.6)
    ;; '(org-document-title  :height 1.8 :bold t :underline nil))

;; Make the document title a bit bigger
  (set-face-attribute 'org-document-title nil :font my/variable-width-font :weight 'bold :height 1.8)

  ;; Resize Org headings
  (dolist (face '((org-level-1 . 1.6)
                  (org-level-2 . 1.5)
                  (org-level-3 . 1.4)
                  (org-level-4 . 1.3)
                  (org-level-5 . 1.2)
                  (org-level-6 . 1.1)
                  (org-level-7 . 1.0)
                  (org-level-8 . 1.0)))
    (set-face-attribute (car face) nil :font my/variable-width-font :weight 'medium :height (cdr face)))


    ;; Make sure certain org faces use the fixed-pitch face when variable-pitch-mode is on
  (set-face-attribute 'org-indent nil :inherit '(org-hide fixed-pitch))
  (set-face-attribute 'org-block nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-table nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-formula nil :inherit 'fixed-pitch)
  (set-face-attribute 'org-code nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-special-keyword nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-meta-line nil :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-checkbox nil :inherit 'fixed-pitch)
  (plist-put org-format-latex-options :scale 2)

  (setq org-adapt-indentation t
        org-hide-leading-stars t
        org-hide-emphasis-markers t
        org-pretty-entities t
        )

  (setq org-src-fontify-natively t
        org-src-tab-acts-natively t
        org-edit-src-content-indentation 0)

;;; Centering Org Documents --------------------------------

  ;; Install visual-fill-column
  ;; (unless (package-installed-p 'visual-fill-column)
  ;;   (package-install 'visual-fill-column))

  ;; Configure fill width
  (setq visual-fill-column-width 110
        visual-fill-column-center-text t)

  (use-package org-roam
    :ensure t
    :init
    (setq org-roam-v2-ack t)
    :custom
    (org-roam-completion-everywhere t)
    :config
    (org-roam-setup))

         ;;; find by titles and tags  :TODO:check if this works..
  (setq org-roam-node-display-template
        (concat "${title:*} "
                (propertize "${tags:10}" 'face 'org-tag)))

;;; Org Present --------------------------------------------

  ;; Install org-present if needed
  ;; (unless (package-installed-p 'org-present)
  ;;   (package-install 'org-present))

  (defun my/org-present-prepare-slide (buffer-name heading)
    ;; Show only top-level headlines
    (org-overview)

    ;; Unfold the current entry
    (org-show-entry)

    ;; Show only direct subheadings of the slide but don't expand them
    (org-show-children))

  (defun my/org-present-start ()
    ;; Tweak font sizes
    (setq-local face-remapping-alist '((default (:height 1.5) variable-pitch)
                                       (header-line (:height 4.0) variable-pitch)
                                       (org-document-title (:height 1.75) org-document-title)
                                       (org-code (:height 1.55) org-code)
                                       (org-verbatim (:height 1.55) org-verbatim)
                                       (org-block (:height 1.25) org-block)
                                       (org-block-begin-line (:height 0.7) org-block)))

    ;; Set a blank header line string to create blank space at the top
    (setq header-line-format " ")

    ;; Display inline images automatically
    (org-display-inline-images)

    ;; Center the presentation and wrap lines
    (visual-fill-column-mode 1)
    (setq display-line-numbers nil)
    (visual-line-mode 1)
    )

  (defun my/org-present-end ()
    ;; Reset font customizations
    (setq-local face-remapping-alist '((default variable-pitch default)))

    ;; Clear the header line string so that it isn't displayed
    (setq header-line-format nil)

    ;; Stop displaying inline images
    (org-remove-inline-images)

    ;; Stop centering the document
    (visual-fill-column-mode 0)
    (visual-line-mode 0)
    (setq display-line-numbers-type `relative)
    ;;set ui-helpers
    (global-display-line-numbers-mode 1)
    (setq display-line-numbers 'relative)
    (setq display-line-numbers-width 'auto)
    )

  (defun my/prettify-symbols-setup ()
    "Beautify keywords"
    (setq prettify-symbols-alist
          (mapcan (lambda (x) (list x (cons (upcase (car x)) (cdr x))))
                  '(; Greek symbols
                    ("lambda" . ?λ)
                    ("delta"  . ?Δ)
                    ("gamma"  . ?Γ)
                    ("phi"    . ?φ)
                    ("psi"    . ?ψ)
                                        ; Org headers
                    ("#+title:"  . "")
                    ("#+author:" . "")
                    ("#+date:"   . "")
                                        ; Checkboxes
                    ("[ ]" . "")
                    ("[X]" . "")
                    ("[-]" . "")
                                        ; Blocks
                    ("#+begin_src"   . "") ; 
                    ("#+end_src"     . "")
                    ("#+begin_quote" . "‟")
                    ("#+end_quote" . "”")
                    ("#+begin_export" . "------")
                    ("#+end_export" . "------")
                    ("#+begin_example" . "------")
                    ("#+end_example" . "------")
                                        ; Drawers
                                        ;    ⚙️
                    (":properties:" . "")
                                        ; Agenda scheduling
                    ("SCHEDULED:"   . "🕘")
                    ("DEADLINE:"    . "⏰")
                                        ; Agenda tags  
                    (":@projects:"  . "☕")
                    (":work:"       . "🚀")
                    (":@inbox:"     . "✉️")
                    (":goal:"       . "🎯")
                    (":task:"       . "📋")
                    (":@thesis:"    . "📝")
                    (":thesis:"     . "📝")
                    (":uio:"        . "🏛️")
                    (":emacs:"      . "")
                    (":learn:"      . "🌱")
                    (":code:"       . "💻")
                    (":fix:"        . "🛠️")
                    (":bug:"        . "🚩")
                    (":read:"       . "📚")
                                        ; Roam tags
                    ("#+filetags:"  . "📎")
                    (":wip:"        . "🏗️")
                    (":ct:"         . "➡️") ; Category Theory
                                        ; ETC
                    (":verb:"       . "🌐") ; HTTP Requests in Org mode
                    )))
    (prettify-symbols-mode))

(use-package svg-tag-mode
  :after org
    :config
    (defconst date-re "[0-9]\\{4\\}-[0-9]\\{2\\}-[0-9]\\{2\\}")
    (defconst time-re "[0-9]\\{2\\}:[0-9]\\{2\\}")
    (defconst day-re "[A-Za-z]\\{3\\}")
    (defconst day-time-re (format "\\(%s\\)? ?\\(%s\\)?" day-re time-re))

    (defun svg-progress-percent (value)
      (svg-image (svg-lib-concat
                  (svg-lib-progress-bar (/ (string-to-number value) 100.0)
                                        nil :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                  (svg-lib-tag (concat value "%")
                               nil :stroke 0 :margin 0)) :ascent 'center))

    (defun svg-progress-count (value)
      (let* ((seq (mapcar #'string-to-number (split-string value "/")))
             (count (float (car seq)))
             (total (float (cadr seq))))
        (svg-image (svg-lib-concat
                    (svg-lib-progress-bar (/ count total) nil
                                          :margin 0 :stroke 2 :radius 3 :padding 2 :width 11)
                    (svg-lib-tag value nil
                                 :stroke 0 :margin 0)) :ascent 'center)))
    (setq svg-tag-tags
          `(;; Org tags
            ;; (":\\([A-Za-z0-9]+\\)" . ((lambda (tag) (svg-tag-make tag))))
            ;; (":\\([A-Za-z0-9]+[ \-]\\)" . ((lambda (tag) tag)))

            ;; Task priority
            ("\\[#[A-Z]\\]" . ( (lambda (tag)
                                  (svg-tag-make tag :face 'org-priority
                                                :beg 2 :end -1 :margin 0))))

            ;; Progress
            ("\\(\\[[0-9]\\{1,3\\}%\\]\\)" . ((lambda (tag)
                                                (svg-progress-percent (substring tag 1 -2)))))
            ("\\(\\[[0-9]+/[0-9]+\\]\\)" . ((lambda (tag)
                                              (svg-progress-count (substring tag 1 -1)))))

            ;; TODO / DONE
            ;; ("TODO" . ((lambda (tag) (svg-tag-make "TODO" :face 'org-todo
            ;;                                                                                   :inverse t :margin 0))))
            ;; ("DONE" . ((lambda (tag) (svg-tag-make "DONE" :face 'org-done :margin 0))))


            ;; Citation of the form [cite:@Knuth:1984]
            ("\\(\\[cite:@[A-Za-z]+:\\)" . ((lambda (tag)
                                              (svg-tag-make tag
                                                            :inverse t
                                                            :beg 7 :end -1
                                                            :crop-right t))))
            ("\\[cite:@[A-Za-z]+:\\([0-9]+\\]\\)" . ((lambda (tag)
                                                       (svg-tag-make tag
                                                                     :end -1
                                                                     :crop-left t))))


            ;; Active date (with or without day name, with or without time)
            (,(format "\\(<%s>\\)" date-re) .
             ((lambda (tag)
                (svg-tag-make tag :beg 1 :end -1 :margin 0))))
            (,(format "\\(<%s \\)%s>" date-re day-time-re) .
             ((lambda (tag)
                (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0))))
            (,(format "<%s \\(%s>\\)" date-re day-time-re) .
             ((lambda (tag)
                (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0))))

            ;; Inactive date  (with or without day name, with or without time)
            (,(format "\\(\\[%s\\]\\)" date-re) .
             ((lambda (tag)
                (svg-tag-make tag :beg 1 :end -1 :margin 0 :face 'org-date))))
            (,(format "\\(\\[%s \\)%s\\]" date-re day-time-re) .
             ((lambda (tag)
                (svg-tag-make tag :beg 1 :inverse nil :crop-right t :margin 0 :face 'org-date))))
            (,(format "\\[%s \\(%s\\]\\)" date-re day-time-re) .
             ((lambda (tag)
                (svg-tag-make tag :end -1 :inverse t :crop-left t :margin 0 :face 'org-date)))))))

  (defun my/org-mode-start ()
    ;; Tweak font sizes
    (variable-pitch-mode)
    ;;(org-superstar-mode)
    (my/prettify-symbols-setup)
    ;;(svg-tag-mode)
    ;; (set-face-attribute org-level-1 nil :foreground "yellow")
    ;; (set-face-attribute org-level-2 nil :foreground "blue")
    ;; (set-face-attribute org-level-3 nil :foreground "blue")
    ;; (set-face-attribute org-level-4 nil :foreground "blue")
    ;; (set-face-attribute org-level-5 nil :foreground "blue")
    ;; (set-face-attribute org-level-6 nil :foreground "blue")
    )

  (defun my/org-agenda-mode-start ()
    (my/prettify-symbols-setup)
    ;;(org-super-agenda-mode)
    )


  ;; Turn on variable pitch fonts in Org Mode buffers
  (add-hook 'org-agenda-mode-hook 'my/prettify-symbols-setup)
  (add-hook 'org-mode-hook 'my/org-mode-start)

  ;; Register hooks with org-present
  (add-hook 'org-present-mode-hook 'my/org-present-start)
  (add-hook 'org-present-mode-quit-hook 'my/org-present-end)
  (add-hook 'org-present-after-navigate-functions 'my/org-present-prepare-slide)

  (use-package org-brain :ensure t
    :init
    (setq org-brain-path "/data/orka/notes/brain")
    ;; For Evil users
    (with-eval-after-load 'evil
      (evil-set-initial-state 'org-brain-visualize-mode 'emacs))
    :config
    (bind-key "C-c b" 'org-brain-prefix-map org-mode-map)
    (setq org-id-track-globally t)
    (setq org-id-locations-file "~/.emacs.d/.org-id-locations")
    (add-hook 'before-save-hook #'org-brain-ensure-ids-in-buffer)
    (push '("b" "Brain" plain (function org-brain-goto-end)
            "* %i%?" :empty-lines 1)
          org-capture-templates)
    (setq org-brain-visualize-default-choices 'all)
    (setq org-brain-title-max-length 12)
    (setq org-brain-include-file-entries nil
          org-brain-file-entries-use-title nil))

  ;; Allows you to edit entries directly from org-brain-visualize
  ;; (use-package polymode
  ;;   :config
  ;;   (add-hook 'org-brain-visualize-mode-hook #'org-brain-polymode))

  (use-package org-auto-tangle
    :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory
    :defer t
    :hook (org-src-mode . org-auto-tangle-mode))

)

                                        ;       (with-eval-after-load 'geiser-mode
                                        ;        (setq geiser-mode-auto-p nil)
                                        ;       (defun orka-geiser-connect ()
                                        ;        (interactive)
                                        ;       (geiser-connect 'guile "localhost" "37146"))

                                        ;    (define-key geiser-mode-map (kbd "C-c M-j") 'orka-geiser-connect))
