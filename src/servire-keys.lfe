#|
@doc
  servire SSH key callback API
@end
|#

(defmodule servire-keys
  (behaviour ssh_server_key_api)
  (export (host_key 2)
          (is_auth_key 3)))

;;; API

(defun host_key (_type _opts)
  (let* [(pem-file (++ (servire-utils:get-priv-dir) "/sshd.pem"))
         (`#(ok ,pem) (file:read_file pem-file))
         (`[,rsa] (public_key:pem_decode pem))]
    `#(ok ,(public_key:pem_entry_decode rsa))))

(defun is_auth_key (_key _user _ssh_opts)
  'true)
