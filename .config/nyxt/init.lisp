
;; Load search-engines.lisp after loading nx-search-engines.
#+nyxt-2
(load-after-system :nx-search-engines (nyxt-init-file "search-engines.lisp"))
#+nyxt-3
(define-nyxt-user-system-and-load "nyxt-user/search-engines"
  :depends-on (:nx-search-engines) :components ("search-engines.lisp"))
