;;; -*- lexical-binding:t -*-

(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (ace-jump-mode company-tabnine youdao-dictionary emojify pyim xclip color-theme-modern solarized-theme spacemacs-theme monokai-theme dracula-theme smex protobuf-mode real-auto-save company-restclient restclient zoom-window neotree f zoom highlight-parentheses markdown-mode counsel yasnippet-snippets eglot python-mode ace-window magit)))
 '(zoom-size (quote (0.618 . 0.618))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(defun require-package (package &optional min-version no-refresh)
  "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
  (if (package-installed-p package min-version)
      t
    (if (or (assoc package package-archive-contents) no-refresh)
        (if (boundp 'package-selected-packages)
            ;; Record this as a package the user installed explicitly
            (package-install package nil)
          (package-install package))
      (progn
        (package-refresh-contents)
        (require-package package min-version t)))))

(defun require-packages (packages)
  (while packages
    (require-package (car packages))
    (setq packages (cdr packages)))
  t)

(require-packages package-selected-packages)

(add-to-list 'load-path (expand-file-name (locate-user-emacs-file "custom")))

(tool-bar-mode 0)
(menu-bar-mode 0)
(scroll-bar-mode 0)

(require 'emojify)
(let ((emoji-set "emojione-v2.2.6-22"))
  (if (not (file-exists-p (expand-file-name emoji-set emojify-emojis-dir)))
      (emojify-download-emoji emoji-set)
    nil)
  (set-variable 'emojify-emoji-set emoji-set))

(defun gui-setup ()
  (setq ediff-window-setup-function 'ediff-setup-windows-plain)
  ;; Auto generated by cnfonts
  ;; <https://github.com/tumashu/cnfonts>
  (set-face-attribute
   'default nil
   :font (font-spec :name "-PfEd-DejaVu Sans Mono-bold-normal-normal-*-*-*-*-*-m-0-iso10646-1"
                    :weight 'normal
                    :slant 'normal
                    :size 11.5))
  (dolist (charset '(kana han symbol cjk-misc bopomofo))
    (set-fontset-font
     (frame-parameter nil 'font)
     charset
     (font-spec :name "-ADBO-Source Han Sans CN-light-normal-normal-*-*-*-*-*-*-0-iso10646-1"
                :weight 'normal
                :slant 'normal
                :size 13.5)))
  (global-emojify-mode))

(if window-system
    (gui-setup)
  nil)

(require 'pyim)
(require 'pyim-basedict)
(pyim-basedict-enable)
(setq default-input-method "pyim")

(display-time)
(setq explicit-shell-file-name "/bin/bash")

(load-theme 'solarized-dark t)

(require 'awesome-tab)
(awesome-tab-mode t)
(setq awesome-tab-height 120)
(setq awesome-tab-active-bar-height 20)
(global-set-key (kbd "M-1") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-2") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-3") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-4") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-5") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-6") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-7") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-8") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-9") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "M-0") 'awesome-tab-select-visible-tab)
(global-set-key (kbd "C-c ;") 'awesome-tab-forward)
(global-set-key (kbd "C-c h") 'awesome-tab-backward)
(global-set-key (kbd "C-c n") 'awesome-tab-forward-group)
(global-set-key (kbd "C-c p") 'awesome-tab-backward-group)
(global-set-key (kbd "C-c t") 'awesome-tab-counsel-switch-group)

(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(electric-pair-mode t)

(require 'highlight-parentheses)
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

(require 'real-auto-save)
(setq real-auto-save-interval 1)
(add-hook 'prog-mode-hook 'real-auto-save-mode)

(global-set-key (kbd "C-c .") 'highlight-symbol-at-point)
(global-set-key (kbd "C-c ,") 'unhighlight-regexp)

(global-set-key (kbd "C-c /") 'comment-region)
(global-set-key (kbd "C-c k") 'uncomment-region)
(global-set-key (kbd "C-c l") 'comment-line)

(global-set-key (kbd "C-c g") 'magit-status)
(require 'magit)
(set-variable 'magit-process-yes-or-no-prompt-regexp "(\\(yes\\)/\\(no\\)/\\[fingerprint\\])\\? $")

(require 'zoom)
(global-set-key (kbd "M-+") 'zoom)
(global-set-key (kbd "M-_") 'balance-windows)

(require 'zoom-window)
(global-set-key (kbd "C-x +") 'zoom-window-zoom)
(global-set-key (kbd "C-x _") 'zoom-window-next)

(global-set-key (kbd "M-o") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(setq aw-dispatch-always nil)

(require 'ace-jump-mode)
(global-set-key (kbd "M--") 'ace-jump-word-mode)
(global-set-key (kbd "C-M--") 'ace-jump-line-mode)

(global-set-key (kbd "C-c o") 'project-find-file)

(require 'youdao-dictionary)
(global-set-key (kbd "C-c y") 'youdao-dictionary-search-at-point)

(require 'yasnippet)
(yas-global-mode 1)

(ivy-mode 1)
(setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(global-set-key (kbd "C-c C-s") 'swiper)
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "C-c C-r") 'ivy-resume)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "C-c m") 'counsel-bookmark)
(global-set-key (kbd "C-c r") 'counsel-rg)
(global-set-key (kbd "C-c i") 'counsel-imenu)
(global-set-key (kbd "C-c b") 'counsel-ibuffer)
(global-set-key (kbd "C-c j") 'counsel-file-jump)
(define-key minibuffer-local-map (kbd "C-r") 'counsel-minibuffer-history)

(require 'smex)
(smex-initialize)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)

(setq confirm-kill-emacs 'yes-or-no-p)

(require 'bookmark)
(setq bookmark-default-file "/mnt/share/Documents/.bookmark")

(require 'company-restclient)
(push 'company-restclient company-backends)
(add-hook 'restclient-mode-hook #'company-mode-on)

(require 'company-tabnine)
(add-to-list 'company-backends #'company-tabnine)
(set-variable 'company-tabnine-binaries-folder
              (locate-user-emacs-file
               (file-name-nondirectory company-tabnine-binaries-folder)))
(if (not (file-exists-p company-tabnine-binaries-folder))
    (company-tabnine-install-binary))

(setq company-show-numbers t)

(require 'eglot)
(define-key eglot-mode-map (kbd "C-c d") 'eglot-help-at-point)
(add-hook 'python-mode-hook #'eglot-ensure)

(require 'python-mode)
(define-key python-mode-map (kbd "C-c f") 'eglot-format-buffer)

(add-hook 'python-mode-hook #'company-mode-on)
