;; Optionally use the `orderless' completion style.
(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion))))
  (completion-category-defaults nil) ;; Disable defaults, use our settings
  (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring

(use-package blamer
  :bind (("s-i" . blamer-show-commit-info))
  :defer 20
  :custom
  (blamer-idle-time 0.3)
  (blamer-min-offset 70)
  :custom-face
  (blamer-face ((t :foreground "#7a88cf"
                    :background nil
                    :height 140
                    :italic t)))
  :config
  (global-blamer-mode 0))

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)
              ("C-n" . 'copilot-next-completion)
              ("C-p" . 'copilot-previous-completion))

  :config
  (add-to-list 'copilot-indentation-alist '(prog-mode 2))
  (add-to-list 'copilot-indentation-alist '(org-mode 2))
  (add-to-list 'copilot-indentation-alist '(text-mode 2))
  (add-to-list 'copilot-indentation-alist '(clojure-mode 2))
  (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))

(use-package aider
 :config
  ;; For latest claude sonnet model
  (setq aider-args '("--model" "gemini" "--no-auto-accept-architect")) ;; add --no-auto-commits if you don't want it
  (setenv "GEMINI_API_KEY" (string-trim (shell-command-to-string "pass data/google/gemini_api.key")))
  ;;(setenv "ANTHROPIC_API_KEY" anthropic-api-key)
  ;; Or chatgpt model
  ;; (setq aider-args '("--model" "o4-mini"))
  ;; (setenv "OPENAI_API_KEY" <your-openai-api-key>)
  ;; Or use your personal config file
  ;; (setq aider-args `("--config" ,(expand-file-name "~/.aider.conf.yml")))
  ;; ;;
  ;; Optional: Set a key binding for the transient menu
  (global-set-key (kbd "C-c H") 'aider-transient-menu) ;; for wider screen
  ;; or use aider-transient-menu-2cols / aider-transient-menu-1col, for narrow screen
  (aider-magit-setup-transients) ;; add aider magit function to magit menu
  ;; auto revert buffer
  (global-auto-revert-mode 1)
  (auto-revert-mode 1))

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
  
  ;(setq doom-theme 'doom-one)
  (setq doom-theme 'doom-gruvbox)
  (setq doom-font (font-spec :family "JetBrainsMono Nerd Font" :size 15))
  (set-frame-parameter nil 'undecorated t)
  
  
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
  ;;(set-fontset-font t 'hangul (font-spec :family my/hangul-font :height 120)) ;
  (set-fontset-font t 'hangul (font-spec :family my/hangul-font)) ; 반영: 자간겹침 현상?
  (setq face-font-rescale-alist '(("D2CodingLigature Nerd Font" . 1.15)
                                  ("NanumGothicCoding" . 1.1)))
  
  ;; This determines the style of line numbers in effect. If set to `nil', line
  ;; numbers are disabled. For relative line numbers, set this to `relative'.
  
  (setq auto-save-list-file-prefix "~/.config/emacs")
  
  (setq display-line-numbers-type `relative)
  (setq-default truncate-lines t)
  ;;set ui-helpers
  (global-display-line-numbers-mode 1)
  (setq display-line-numbers 'relative)
  (setq display-line-numbers-width 'auto)
  (setq display-line-numbers-width 4)
  (setq display-line-numbers-grow-only t)
  (setq display-line-numbers-width-start t)
  
  ;;(setq select-enable-clipboard t) ;; Enable clipboard integration
  (setq select-enable-primary t) ;; Enable clipboard integration
  ;; (setq select-active-regions t)  ;; Highlight selections
  
  
  ;; Set the cursor color
                                          ;(setq-default cursor-type 'bar) ;; or '(bar . 2) for a thicker bar
  (set-cursor-color "coral") ;; Replace "red" with your desired color
  
  (setq default-input-method "korean-hangul")
  (global-set-key (kbd "S-SPC") 'toggle-input-method) ; Shift+Space를 한영 전환 키로 설정
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
  (map! :leader
        :desc "consult bookmark" "B" #'consult-bookmark)
  (map! :leader
        :desc "consult bookmark" "b" #'consult-buffer)
  (map! :leader
        :desc "FuZzily find File in home"
        "f z h" (cmd!! #'affe-find "~/"))
  (map! :leader
        :desc "FuZzily find file in this Dir"
        "f z f" (cmd!! #'affe-find))
  
  
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
  
  (setopt text-mode-ispell-word-completion nil)
  (which-function-mode 1)
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
  
  
    (setq meow-two-char-escape-sequence "jk")
    (setq meow-two-char-escape-delay 0.3)
  
    (defun meow--two-char-exit-insert-state (s)
      (when (meow-insert-mode-p)
        (let ((modified (buffer-modified-p)))
          (insert (elt s 0))
          (let* ((second-char (elt s 1))
                 (event
                  (if defining-kbd-macro
                      (read-event nil nil)
                    (read-event nil nil meow-two-char-escape-delay))))
            (when event
              (if (and (characterp event) (= event second-char))
                  (progn
                    (backward-delete-char 1)
                    (set-buffer-modified-p modified)
                    (meow--execute-kbd-macro "<escape>"))
                (push event unread-command-events)))))))
  
    (defun meow-two-char-exit-insert-state ()
      (interactive)
      (meow--two-char-exit-insert-state meow-two-char-escape-sequence))
  
    (define-key meow-insert-state-keymap (substring meow-two-char-escape-sequence 0 1)
      #'meow-two-char-exit-insert-state)
  
  (defun my/meow-jump-to-pair ()
    "괄호의 앞이나 뒤, 어디서든 짝으로 점프합니다."
    (interactive)
    (let ((pos (point)))
      (condition-case nil
          (cond
           ;; 1. 현재 커서 아래가 여는 괄호일 때
           ((looking-at "\\s\(") 
            (forward-list 1) (backward-char 1))
           
           ;; 2. 현재 커서 아래가 닫는 괄호일 때
           ((looking-at "\\s\)") 
            (forward-char 1) (backward-list 1))
           
           ;; 3. 커서 바로 왼쪽이 닫는 괄호일 때 (중요!)
           ((and (char-before) (string-match "\\s\)" (char-to-string (char-before))))
            (backward-list 1))
           
           ;; 4. 커서 바로 왼쪽이 여는 괄호일 때
           ((and (char-before) (string-match "\\s\(" (char-to-string (char-before))))
            (backward-char 1) (forward-list 1) (backward-char 1))
  
           ;; 5. 줄에서 괄호 탐색
           (t
            (save-excursion
              (if (re-search-forward "[([{\"\]})]" (line-end-position) t)
                  (setq pos (match-beginning 0))
                (setq pos nil)))
            (if pos
                (progn (goto-char pos) (my/meow-jump-to-pair))
              (message "No pair found on this line"))))
        (error (message "No matching pair found")))))
  
  
  (with-eval-after-load 'meow
    (meow-normal-define-key '("C-j" . meow-page-down))
    (meow-normal-define-key '("C-k" . meow-page-up))
    (meow-normal-define-key '("/" . isearch-forward-regexp))
    (meow-normal-define-key '("?" . consult-ripgrep-with-last-regex))
    (meow-normal-define-key '("M-f" . find-grep-dired))
    (meow-normal-define-key '("M-o" . browse-url-at-point))
    (meow-normal-define-key '("C-o" . pop-global-mark))
    (meow-normal-define-key '("<" . beginning-of-buffer))
    (meow-normal-define-key '(">" . end-of-buffer))
    (meow-normal-define-key '("M-n" . ace-window))
    (meow-normal-define-key '("N" . +treemacs/toggle))
    (meow-normal-define-key '("%" . my/meow-jump-to-pair))
    (meow-leader-define-key '("y" . meow-clipboard-save))
    (meow-leader-define-key '("p" . meow-clipboard-yank))
    (meow-leader-define-key '("B" . consult-bookmark))
    (meow-leader-define-key '("b" . consult-buffer))
  )
  (global-set-key (kbd "M-n") 'ace-window)
  (map! :map grep-mode-map
        ;; :n "o" #'compile-goto-error  ; 일반 모드에서 바로 이동
        :"M-n" #'ace-window)  ; ace-window 호출 예시
  (map! :map treemacs-mode-map "N" #'+treemacs/toggle) ; Bind 'q' to toggle/close treemacs when focused
  
  (after! ace-window
    ;; Remove treemacs-mode from the ignore list so ace-window can see it
    (setq aw-ignored-buffers (delq 'treemacs-mode aw-ignored-buffers)))
  ;; (map! "M-m" #'treemacs-select-window)
  
  ;; (defun my-eat-mode-hook ()
  ;;   "Add local keybinding for ace-window in eat buffers."
  ;;   (local-set-key (kbd "M-n") 'ace-window))
  ;; (add-hook 'eat-mode-hook 'my-eat-mode-hook)
  
  ;; Enable Vertico.
  (use-package vertico
    :custom
    (vertico-scroll-margin 0) ;; Different scroll margin
    ;; (vertico-count 20) ;; Show more candidates
    (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
    (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
    :init
    (vertico-mode 1)
    ;; Configure Orderless as the primary completion style
    (setq completion-styles '(orderless basic))
    (setq orderless-matching-styles '(orderless-literal orderless-regexp))
    ;; Enable Consult commands (optional, but highly recommended)
    ;;(global-set-key (kbd "C-x C-f") 'consult-find-file)
    )
  
  ;; Persist history over Emacs restarts. Vertico sorts by history position.
  (use-package savehist
    :init
    (savehist-mode))
  
  ;; Emacs minibuffer configurations.
  (use-package emacs
    :custom
    ;; Enable context menu. `vertico-multiform-mode' adds a menu in the minibuffer
    ;; to switch display modes.
    (context-menu-mode t)
    ;; Support opening new minibuffers from inside existing minibuffers.
    (enable-recursive-minibuffers t)
    ;; Hide commands in M-x which do not work in the current mode.  Vertico
    ;; commands are hidden in normal buffers. This setting is useful beyond
    ;; Vertico.
    (read-extended-command-predicate #'command-completion-default-include-p)
    ;; Do not allow the cursor in the minibuffer prompt
    (minibuffer-prompt-properties
     '(read-only t cursor-intangible t face minibuffer-prompt)))
   ;; Option 1: Additional bindings
  (keymap-set vertico-map "?" #'minibuffer-completion-help)
  (keymap-set vertico-map "M-RET" #'minibuffer-force-complete-and-exit)
  (keymap-set vertico-map "M-TAB" #'minibuffer-complete)
  
  ;; Option 2: Replace `vertico-insert' to enable TAB prefix expansion.
  ;; (keymap-set vertico-map "TAB" #'minibuffer-complete)
  (setq completion-styles '(basic substring partial-completion flex))
  (setq read-file-name-completion-ignore-case t
        read-buffer-completion-ignore-case t
        completion-ignore-case t)
  (setq completion-in-region-function #'consult-completion-in-region)
  ;; Optionally use the `orderless' completion style.
  (use-package orderless
    :custom
    ;; Configure a custom style dispatcher (see the Consult wiki)
    ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
    ;; (orderless-component-separator #'orderless-escapable-split-on-space)
    (completion-styles '(orderless basic))
    (completion-category-overrides '((file (styles partial-completion))))
    (completion-category-defaults nil) ;; Disable defaults, use our settings
    (completion-pcm-leading-wildcard t)) ;; Emacs 31: partial-completion behaves like substring
  (use-package blamer
    :bind (("s-i" . blamer-show-commit-info))
    :defer 20
    :custom
    (blamer-idle-time 0.3)
    (blamer-min-offset 70)
    :custom-face
    (blamer-face ((t :foreground "#7a88cf"
                      :background nil
                      :height 140
                      :italic t)))
    :config
    (global-blamer-mode 0))
  ;; accept completion from copilot and fallback to company
  (use-package! copilot
    :hook (prog-mode . copilot-mode)
    :bind (:map copilot-completion-map
                ("<tab>" . 'copilot-accept-completion)
                ("TAB" . 'copilot-accept-completion)
                ("C-TAB" . 'copilot-accept-completion-by-word)
                ("C-<tab>" . 'copilot-accept-completion-by-word)
                ("C-n" . 'copilot-next-completion)
                ("C-p" . 'copilot-previous-completion))
  
    :config
    (add-to-list 'copilot-indentation-alist '(prog-mode 2))
    (add-to-list 'copilot-indentation-alist '(org-mode 2))
    (add-to-list 'copilot-indentation-alist '(text-mode 2))
    (add-to-list 'copilot-indentation-alist '(clojure-mode 2))
    (add-to-list 'copilot-indentation-alist '(emacs-lisp-mode 2)))
  
  (use-package aider
   :config
    ;; For latest claude sonnet model
    (setq aider-args '("--model" "gemini" "--no-auto-accept-architect")) ;; add --no-auto-commits if you don't want it
    (setenv "GEMINI_API_KEY" (string-trim (shell-command-to-string "pass data/google/gemini_api.key")))
    ;;(setenv "ANTHROPIC_API_KEY" anthropic-api-key)
    ;; Or chatgpt model
    ;; (setq aider-args '("--model" "o4-mini"))
    ;; (setenv "OPENAI_API_KEY" <your-openai-api-key>)
    ;; Or use your personal config file
    ;; (setq aider-args `("--config" ,(expand-file-name "~/.aider.conf.yml")))
    ;; ;;
    ;; Optional: Set a key binding for the transient menu
    (global-set-key (kbd "C-c H") 'aider-transient-menu) ;; for wider screen
    ;; or use aider-transient-menu-2cols / aider-transient-menu-1col, for narrow screen
    (aider-magit-setup-transients) ;; add aider magit function to magit menu
    ;; auto revert buffer
    (global-auto-revert-mode 1)
    (auto-revert-mode 1))
  (use-package! lsp-proxy
    :config
    (set-lookup-handlers! 'lsp-proxy-mode
      :definition '(lsp-proxy-find-definition :async t)
      :references '(lsp-proxy-find-references :async t)
      :implementations '(lsp-proxy-find-implementations :async t)
      :type-definition '(lsp-proxy-find-type-definition :async t)
      :documentation '(lsp-proxy-describe-thing-at-point :async t)))
    :costom
    (setq lsp-clients-clangd-args
            '("-j=4" ;; Example: Use 4 jobs for background indexing
              "--background-index"
              "--clang-tidy" ;; Enable Clang-Tidy checks
              "--completion-style=detailed"
              "-log=error"))
  
  
  (meow-leader-define-key '("g" . lsp-find-references))
  (meow-leader-define-key '("d" . lsp-find-definition))
  (meow-leader-define-key '("q" . lsp-find-declaration))
  
  (with-eval-after-load 'meow
    (meow-normal-define-key '("M-;" . lsp-find-references))
    (meow-normal-define-key '("M-'" . lsp-find-definition))
    (meow-normal-define-key '("M-\\" . rgrep))
    (meow-normal-define-key '("M-[" . lsp-find-type-definition))
    (meow-normal-define-key '("M-]" . lsp-find-implementations))
  )
  
  
  
  ;; treesit-auto configuration
  (use-package treesit-auto
    :ensure t
    :custom
    (treesit-auto-langs '(python rust cpp))
    ;; Pin a known working version for the C++ grammar to avoid mismatches
    ;; (treesit-language-source-alist
    ;;  `((cpp . ,(treesit-auto--gh-uri "tree-sitter/tree-sitter-cpp" "v0.22.0"))
    ;;    (rust . ,(treesit-auto--gh-uri "tree-sitter/tree-sitter-rust"))
    ;;    (python . ,(treesit-auto--gh-uri "tree-sitter/tree-sitter-python"))))
    ;; Populates auto-mode-alist with the treesit modes *before* any files are opened.
    (treesit-auto-add-to-auto-mode-alist t)
    ;; Increase the font-lock level for more detailed highlighting
    ;;(treesit-font-lock-level 4)
    :config
    (treesit-auto-add-to-auto-mode-alist t)
    (global-treesit-auto-mode))
  
  (use-package flycheck
    :ensure t
    :init (global-flycheck-mode))
  
  ;; lsp-mode configuration
  (use-package lsp-mode
    :after treesit-auto
    :commands lsp
    :ensure t
    :custom
    (lsp-inlay-hint-enable t)
  
    :init
    ;; Crucial: Ensure semantic highlighting is off so Tree-sitter can work
    ;;(setq lsp-enable-semantic-highlighting nil)
  
    :hook
    (treesit-auto-mode . lsp-deferred)
    ;; Fallback hooks for non-treesitter modes (e.g., if treesit-auto fails)
    ((c-mode c++-mode) . lsp-deferred)
    ;;(lsp-ui-doc-mode . lsp-deferred)
    ;;(lsp-inlay-hints-mode . lsp-deferred)
  
    :config
    ;; Additional lsp-mode settings
    (setq lsp-diagnostics-provider :flycheck)
  
    
    (defun my/consult-lsp-symbols-at-point ()
      "Search for LSP symbols with the symbol at point as initial input."
      (interactive)
      (consult-lsp-symbols (thing-at-point 'symbol)))
  
    ;; Optional: Bind the new command to a key
    (global-set-key (kbd "C-.") '+vertico/search-symbol-at-point)
    (meow-normal-define-key '("C-." . +vertico/search-symbol-at-point))
  
    (setq consult-lsp-symbols-command (lambda () (thing-at-point 'symbol)))
  )
  
  
  ;; lsp-ui configuration (No changes needed)
  (use-package lsp-ui
    :after lsp-mode
    :commands lsp-ui-mode
    :hook
    (lsp-mode . lsp-ui-mode)
  
    :config
    (setq lsp-ui-sideline-enable t)
    (setq lsp-ui-doc-enable t)
    (setq lsp-ui-peek-enable t)
    (setq lsp-ui-doc-show-on-cursor t)
    (setq lsp-ui-doc-show-with-diagnostics t)
    (define-key lsp-ui-mode-map (kbd "M-,") #'lsp-ui-peek-find-definitions)
    (define-key lsp-ui-mode-map (kbd "M-.") #'lsp-ui-peek-find-references))
  
  
      ;; (use-package lsp-mode
      ;;   :commands lsp
      ;;   :hook ((c-mode c++-mode) . lsp-deferred)
      ;;   :config
      ;;   (setq lsp-prefer-flymake nil) ; or t, depending on preference
      ;;   ;; Add other clangd-specific settings here if needed
      ;;   )
      ;; (use-package rustic
      ;;   :mode "\\.rs\\'"
      ;;   :hook (rustic-mode . lsp-deferred)
      ;;   :config
      ;;   ;; Add rustic/rust-analyzer specific settings here
      ;;   (setq rustic-format-on-save t) ; Example: enable formatting on save
      ;;   )
     (require 'company)
     (global-company-mode t)
     ;;(add-hook 'lsp-mode-hook 'company-mode)
     ;; Enable lsp-ui-signature-mode globally
     ;;(add-hook 'lsp-mode-hook 'lsp-ui-signature-mode)
  
  (use-package! corfu
    :init
    (global-corfu-mode 1)
  :custom
    (corfu-auto t)
    (corfu-delay 0.2)
    (:map corfu-map
          ;("C-n" . corfu-next)          ; Bind Shift+n to move down
          ;("C-p" . corfu-previous)      ; Bind Shift+p to move up
          ("S-<tab>" . corfu-previous)  ; Keep Shift+tab for previous
          ("<tab>" . corfu-next))      ; Keep tab for next
    )
  
  (use-package! cape
    :after corfu
    :init
    (add-to-list 'completion-at-point-functions #'cape-dabbrev)
    (add-to-list 'completion-at-point-functions #'cape-file)
    (add-to-list 'completion-at-point-functions #'cape-keyword)
    (add-to-list 'completion-at-point-functions #'cape-line)
    (add-to-list 'completion-at-point-functions #'cape-keyword)
    :config
    ;; Example: Merge LSP and snippet completion sources
    ;;(add-hook 'completion-at-point-functions #'cape-super-capf)
    )
  
  ;; Configure specific completion styles for file paths
  (after! corfu
    (setq completion-category-overrides '((file (styles partial-completion))))
    ;; Use orderless as your primary style, with basic as a fallback.
    (setq completion-styles '(orderless basic)))
  
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
  ;; If you use `org' and don't want your org files in the default location below,
  ;; change `org-directory'. It must be set before org loads!
  (setq org-directory "~/notes/"
        org-roam-directory "~/notes/resources/")
  
  (setq org-agenda-files 
        (seq-filter (lambda (file) 
                      ;; Exclude files in the "archive" or "private" directory
                      (not (string-match-p "/2024/\\|/2025/" file)))
                    (directory-files-recursively "~/notes" "\\.org$")))
  
  (add-hook 'org-mode-hook #'hl-todo-mode)
  
  (require 'org-indent)
  
  (setq org-log-reschedule 'time)
  (setq org-log-done 'time)
  
  (setq alert-default-style 'libnotify)
  (use-package org-wild-notifier
    :after org
    :config
    (setq org-wild-notifier-alert-time '(10 30)
          org-wild-notifier-keyword-whitelist nil
          alert-fade-time 50
          org-wild-notifier--alert-severity 'high
          org-wild-notifier-keyword-blacklist '("personal" "PERSONAL"))
  
    (org-wild-notifier-mode t))
  
  ;; Follow the links
  (setq org-return-follows-link  t)
  
  ;; Associate all org files with org mode
  ;; (add-to-list 'auto-mode-alist '("\\.org\\'" . org-mode))
  
  
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
    (meow-leader-define-key '("G" . org-roam-graph))
    (meow-leader-define-key '("D" . org-roam-dailies-capture-today))
    (meow-leader-define-key '("T" . org-roam-dailies-goto-date))
  )
  
  (define-key org-mode-map (kbd "M-k") 'org-previous-block)
  (define-key org-mode-map (kbd "M-j") 'org-next-block)
  (define-key org-mode-map (kbd "S-M-<left>") 'org-promote-subtree)
  (define-key org-mode-map (kbd "S-M-<right>") 'org-demote-subtree)
  
  
  (with-eval-after-load 'org
    (setq org-use-speed-commands t)
    (setq org-enforce-todo-dependencies t)
  
    (setq org-lowest-priority ?F)  ;; Gives us priorities A through F
    (setq org-default-priority ?C) ;; If an item has no priority, it is considered [#C].
  
    (setq org-priority-faces
          '((65 . "#BF616A")
            (66 . "#EBCB8B")
            (67 . "#B48EAD")
            (68 . "#81A1C1")
            (69 . "#5E81AC")
            (70 . "#4C566A")))
  
    (setq org-todo-keywords
          '((sequence
             "TODO(t)" "PLANNING(p)" "IN-PROGRESS(s)" "VERIFYING(v)" "BLOCKED(b)" "IDEA(i)" ; Needs further action
             "|"
             "DONE(d)" "DELIGATED(e)" "WONT-DO(n)")))                           ; Needs no action currently
  
    (setq org-todo-keyword-faces
          '(("TODO"      :inherit (org-todo region) :foreground "#A3BE8C" :weight bold)
            ("PLANNING"      :inherit (org-todo region) :foreground "#98B080" :weight bold)
            ("IN-PROGRESS"      :inherit (org-todo region) :foreground "#88C0D0" :weight bold)
            ("VERIFYING"      :inherit (org-todo region) :foreground "#8AD0D0" :weight bold)
            ("BLOCKED"      :inherit (org-todo region) :foreground "#B8BCBB" :weight bold)
            ("IDEA"      :inherit (org-todo region) :foreground "#EBCB8B" :weight bold)
            ("DONE"      :inherit (org-todo region) :foreground "#30343d" :weight bold)
            ("DELIGATED" :inherit (org-todo region) :foreground "#20242d" :weight bold)
            ("WONT-DO" :inherit (org-todo region) :foreground "#10141d" :weight bold)
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
    (dolist (face '((org-level-1 . 1.2)
                    (org-level-2 . 1.05)
                    (org-level-3 . 1.0)
                    (org-level-4 . 1.0)
                    (org-level-5 . 1.0)
                    (org-level-6 . 1.0)
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
  
  
  
  (setq org-capture-templates
        '(("g" "General To-Do"
           entry (file+headline "todo.org" "Inbox")
           "* TODO [#B] %? [/] \n:Created: %T\n"
           :empty-lines 0
           :unnarrowed t)
          ("m" "Meeting"
           entry (file+datetree "meetings/meetings.org")
           "* %? :meeting:%^g \n:Created: %T\n** Attendees\n*** \n** Notes\n** Action Items\n*** TODO [#B]  [/]\n"
           :tree-type week
           :clock-in t
           :clock-resume t
           :empty-lines 0)
        ))
  
  ;; Tags
  (setq org-tag-alist '(
                        ;; Project types
                        (:startgroup . nil)
                        ("@GEN-PROJ" . nil)
                        ("@CCRC" . nil)
                        ("@CCIC27" . nil)
                        (:endgroup . nil)
  
                        ;; Meeting tags
                        ("HR" . ?h)
                        ("general" . ?l)
                        ("meeting" . ?m)
                        ("misc" . ?z)
                        ("planning" . ?p)
  
                        ;; Work Log Tags
                        ("accomplishment" . ?a)
                        ))
  
  (use-package org-roam
    :ensure t
    :init
    (setq org-roam-v2-ack t)
    :custom
    (org-roam-completion-everywhere t)
    :config
    (org-roam-setup))
  
           ;;; find by titles and tags  :TODO:check if this works..
  
  ;; (setq org-roam-node-display-template
  ;;       (concat "${type:15} ${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  (setq org-roam-node-display-template
        (concat "${title:*} " (propertize "${tags:10}" 'face 'org-tag)))
  
  (setq org-roam-capture-templates
        '(
          ("e" "etc" plain "%?"
           :if-new (file+head "main/${slug}.org"
                              "#+filetags: :etc:\n#+date: %U\n#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          ("r" "reference" plain "%?"
           :if-new (file+head "reference/${title}.org"
                              "#+filetags: :reference:\n#+date: %U\n#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          ("a" "article" plain "%?"
           :if-new (file+head "articles/${title}.org"
                              "#+filetags: :article:\n#+date: %U\n#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          ("p" "projects" plain "%?"
           :if-new (file+head "projects/${title}.org"
                              "#+filetags: :project:\n#+date: %U\n#+title: ${title}\n")
           :immediate-finish t
           :unnarrowed t)
          ("d" "default" plain "%?"
           :if-new (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                              "#+filetags: :etc:\n#+date: %U\n#+title: ${title}\n")
           :unnarrowed t)
          ("n" "Note" plain "%?"
           :if-new (file+head "reference/note/${slug}.org"
                              "#+filetags: :note:\n#+date: %U\n#+title: ${title}\n")
           :unnarrowed t)
          ))
  
  
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
  
      ;;set -helpers
      (setq-default truncate-lines t)
      (global-display-line-numbers-mode 1)
      (setq display-line-numbers 'relative)
      (setq display-line-numbers-width 'auto)
      (setq display-line-numbers-width 4)
      (setq display-line-numbers-grow-only t)
      (setq display-line-numbers-width-start t)
      (setq display-line-numbers-type 'relative)
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
      (org-superstar-mode)
      (my/prettify-symbols-setup)
      (svg-tag-mode)
      ;; (set-face-attribute org-level-1 nil :foreground "yellow")
      ;; (set-face-attribute org-level-2 nil :foreground "blue")
      ;; (set-face-attribute org-level-3 nil :foreground "blue")
      ;; (set-face-attribute org-level-4 nil :foreground "blue")
      ;; (set-face-attribute org-level-5 nil :foreground "blue")
      ;; (set-face-attribute org-level-6 nil :foreground "blue")
      )
  
    (defun my/org-agenda-mode-start ()
      (my/prettify-symbols-setup)
      (org-super-agenda-mode)
      )
  
  
    ;; Turn on variable pitch fonts in Org Mode buffers
    (add-hook 'org-agenda-mode-hook 'my/prettify-symbols-setup)
    (add-hook 'org-mode-hook 'my/org-mode-start)
  
    ;; Register hooks with org-present
    (add-hook 'org-present-mode-hook 'my/org-present-start)
    (add-hook 'org-present-mode-quit-hook 'my/org-present-end)
    (add-hook 'org-present-after-navigate-functions 'my/org-present-prepare-slide)
  
  
  
  
  
    ;; Allows you to edit entries directly from org-brain-visualize
   ;;( use-package polymode
   ;; :defer t)
  
  
    (use-package org-brain :ensure t
      :init
      (setq org-brain-path "~/notes/brain")
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
            org-brain-file-entries-use-title nil)
       ;;(add-hook 'org-brain-visualize-mode-hook #'org-brain-polymode)
  
  )
  
  
    (use-package org-auto-tangle
      :load-path "site-lisp/org-auto-tangle/"    ;; this line is necessary only if you cloned the repo in your site-lisp directory
      :defer t
      :hook (org-src-mode . org-auto-tangle-mode))
  
  
  (use-package! org-jira
    :config
    (setq jiralib-url "http://jira.lge.com/")
    (setq org-jira-api-token (string-trim (shell-command-to-string "pass show jira/org-jira")))
    (setq org-jira-auth-type 'bearer)
    ;; (setq jiralib-token
    ;;    (cons "Authorization"
    ;;          (concat "Bearer " (auth-source-pick-first-password
    ;;                             :host "http://jira.lge.com/"))))
  )
  
  
  
  )
                                          ;       (with-eval-after-load 'geiser-mode
                                          ;        (setq geiser-mode-auto-p nil)
                                          ;       (defun orka-geiser-connect ()
                                          ;        (interactive)
                                          ;       (geiser-connect 'guile "localhost" "37146"))
  
                                          ;    (define-key geiser-mode-map (kbd "C-c M-j") 'orka-geiser-connect))
