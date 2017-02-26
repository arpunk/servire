#|
@doc
  servire public API
@end
|#

(defmodule servire
  (export (main 1)))

;;; API

(defun main
  ([`(,port)]
   (application:ensure_all_started 'ssh)
   (run (list_to_integer port)))
  ([_] (usage)))

(defun run (port)
  (serve port)
  (timer:sleep 'infinity))

(defun serve (port)
  (let* ([`#(ok ,root) (file:get_cwd)]
         [opts `(#(cwd ,root) #(root ,root))]
         [subsystem (ssh_sftpd:subsystem_spec opts)]
         [args (default-opts subsystem)]
         [`#(ok ,daemon-ref) (ssh:daemon port args)])
    (io:format "Serving ~s on port ~p~n" `(,root ,port))
    `#(ok ,daemon-ref)))

(defun usage ()
  (io:format "usage: servire port~n"))

;;; Internal functions

(defun default-opts (subsystem)
  `(#(key_cb servire-keys)
    #(subsystems (,subsystem))
    #(parallel_login true)
    #(shell ,(lambda (user _password) (spawn (lambda () (welcome user)))))
    #(max_sessions 10)
    #(id_string ,"servire")
    #(system_dir ,(servire-utils:get-priv-dir))
    #(pwdfun ,(lambda (_u _p) 'true))))

(defun pwd-fun (_user _pass _peer _state)
  'true)

(defun welcome (user)
  (io:format "Welcome ~s, you may now use sftp~n" `(,user)))