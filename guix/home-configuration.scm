;; This "home-environment" file can be passed to 'guix home reconfigure'
;; to reproduce the content of your profile.  This is "symbolic": it only
;; specifies package names.  To reproduce the exact same profile, you also
;; need to capture the channels being used, as returned by "guix describe".
;; See the "Replicating Guix" section in the manual.

(use-modules (gnu home)
	     ((guix licenses) #:prefix license:)
             (gnu packages)
             (gnu services)
             (guix gexp)
	     (guix packages)
	     (gnu packages terminals)
	     (guix download)
	     (guix build-system copy)
	     (guix git-download)
	     (guix utils)
             (gnu home services shells)
	     (gnu home services)
	     (gnu packages dictionaries))

;; Custom Packages

;; Dictionary file for sdcv
(define collaborative-dictionary-stardict
  (package
    (name "collaborative-dictionary-stardict")
    (version "2.4.2")
    (source
      (origin
	(method url-fetch)
	(uri (string-append "http://download.huzheng.org/dict.org/stardict-dictd_www.dict.org_gcide-" version ".tar.bz2"))
	(sha256 (base32 "0dq5d5hsiwb4wxcaxx5i8gq13pwxc64dn8sd5izqk5m8cckhgqvw"))))
    (build-system copy-build-system)
    (arguments
      '(#:install-plan
	'(("./" "share/dic/"))))
    (synopsis "The Collaborative International Dictionary of English")
    (description "The GNU Collaborative International Dictionary of English, or GCIDE for short, is a free dictionary derived from Webster's Revised Unabridged Dictionary Version published 1913 by the C. & G. Merriam Co. Springfield, Mass. Under the direction of Noah Porter, D.D., LL.D. and supplemented with some new definitions, in particular from WordNet.")
    (home-page "http://download.huzheng.org/")
    (license license:gpl3+)))

;; Just the terminfo defined by kitty
(define kitty-terminfo
  (package (inherit kitty)
    (name "kitty-terminfo")
    (build-system copy-build-system)
    (arguments
      '(#:install-plan
	'(("terminfo/" "share/terminfo/"))))
    (native-inputs `())
    (inputs `())))

(home-environment
  ;; Below is the list of packages that will show up in your
  ;; Home profile, under ~/.guix-home/profile.
  (packages (append
	      (map (compose list specification->package+output)
		   (list "sdcv" "git" "fish" "exa" "fd" "neovim" "bat" "curl" "ripgrep"))
	      (list collaborative-dictionary-stardict kitty-terminfo)))

  ;; Below is the list of Home services.  To search for available
  ;; services, run 'guix home search KEYWORD' in a terminal.
  (services
   (list (service home-fish-service-type
                  (home-fish-configuration
                   (aliases '( ; ("btm" . "btm --battery")
                              ("cat" . "bat -p --pager=\"less -XR\"")
                              ("clh" . "history -c && exit")
                              ("dict" . "sdcv")
                              ; ("diff" . "diff --color=auto")
                              ; ("egrep" . "egrep --color=auto")
                              ("fd" . "fdfind")
                              ; ("fgrep" . "fgrep --color=auto")
                              ; ("grep" . "grep --color=auto")
                              ("inst" . "sudo apt -y install")
                              ; ("l" . "ls -CF")
                              ; ("la" . "ls -A")
                              ("less" . "bat --paging always")
                              ; ("ll" . "ls -alF")
                              ("ls" . "exa")
                              ; ("ssh" . "kitty +kitten ssh")
                              ; ("t" . "todo-txt")
                              ; ("upgr" . "sudo apt update; sudo apt -y upgrade && sudo apt -y autoremove; flatpak update -y; cargo install-update -ag; fwupdmgr update")
                              ; ("upgr4" . "sudo apt-get -o Acquire::ForceIPv4=true update && sudo apt-get -y -o Acquire::ForceIPv4=true upgrade && sudo apt-get -y -o Acquire::ForceIPv4=true autoremove")
                              ("vi" . "nvim")
                              ("vim" . "nvim")
                              ; ("vpn" . "sudo wg-quick up wg0")
                              ; ("vpnd" . "sudo wg-quick down wg0")
                              ("weather" . "curl https://wttr.in/ 2> /dev/null")))
                   (config (list (local-file "../fish/.config/fish/config.fish")))
		   ))

	 ;; Environment variables go here
	 (simple-service 'some-useful-env-vars-service
		home-environment-variables-service-type
		     `(("STARDICT_DATA_DIR" . ,(file-append collaborative-dictionary-stardict "/share"))
		       ("TERMINFO" . ,(file-append kitty-terminfo "/share/terminfo")))))))
