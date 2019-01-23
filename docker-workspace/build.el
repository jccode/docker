;;
;; Script for initilize emacs init files.
;; 
;;  1) Download all packages from melpa;
;;  2) Install necessary fonts for doom-modeline
;; 


;; Because (all-the-icons-install-fonts 1) will ask to choose isntall path
;; Override this function
(defun install-all-icon-fonts (&optional pfx path)
  "Helper function to download and install the latests fonts based on OS.
When PFX is non-nil, ignore the prompt and just install"
  (interactive "P")
  (when (or pfx (yes-or-no-p "This will download and install fonts, are you sure you want to do this?"))
    (let* ((url-format "https://github.com/domtronn/all-the-icons.el/blob/master/fonts/%s?raw=true")
           (font-dest (or path (cl-case window-system
                        (x  (concat (or (getenv "XDG_DATA_HOME")            ;; Default Linux install directories
                                        (concat (getenv "HOME") "/.local/share"))
                                    "/fonts/"))
                        (mac (concat (getenv "HOME") "/Library/Fonts/" ))
                        (ns (concat (getenv "HOME") "/Library/Fonts/" )))))  ;; Default MacOS install directory
           (known-dest? (stringp font-dest))
           (font-dest (or font-dest (read-directory-name "Font installation directory: " "~/"))))

      (unless (file-directory-p font-dest) (mkdir font-dest t))

      (mapc (lambda (font)
              (url-copy-file (format url-format font) (expand-file-name font font-dest) t))
            all-the-icons-font-names)
      (when known-dest?
        (message "Fonts downloaded, updating font cache... <fc-cache -f -v> ")
        (shell-command-to-string (format "fc-cache -f -v")))
      (message "%s Successfully %s `all-the-icons' fonts to `%s'!"
               (all-the-icons-wicon "stars" :v-adjust 0.0)
               (if known-dest? "installed" "downloaded")
               font-dest)))) 




;; ====================
;; Load script
;; ====================

(load-file "~/emacs/init.el")
(setq install-path (concat (getenv "HOME") "/.local/share" "/fonts/"))
(install-all-icon-fonts 1 install-path)
