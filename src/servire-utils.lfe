#|
@doc
  servire misc utils
@end
|#

(defmodule servire-utils
  (export all))

;; Misc utils

(defun get-priv-dir ()
  (++ (os:getenv "HOME") "/.servire"))
