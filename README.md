servire
=======

Serve the current directory over SFTP.

Quick and dirty escript for sharing files and directories over SFTP
without having to add users to your system. It might improve in the
future.

You need to have Erlang and `rebar3` installed in order to compile and
run the escript.

## Build
```sh
$ cd servire
$ rebar3 escriptize
$ cp _build/default/bin/servire $YOUR_LOCAL_PATH/bin
```

## Usage

First you need to create a `sshd.pem` file and place it under
`$HOME/.servire` directory.

```sh
$ cd /tmp
$ servire 9999
Serving /tmp on port 9999
```

## License

Copyright (c) 2017 Ricardo Lanziano

This work is free. You can redistribute it and/or modify it under the
terms of the MIT License. See the [LICENSE](LICENSE) file for more
details.
