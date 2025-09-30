An ini file parser.

Rewritten to not use `pcre`, because `pcre` depends on `libpcre3` which is [not
available](https://packages.debian.org/search?suite=trixie&section=all&arch=any&lang=en&searchon=names&keywords=libpcre3)
on Debian 13, and generaly obsolete. The modern alternative is `libpcre2`, which
has ocaml bindings in the opam package `pcre2`.

Published on opam as `inifiles`: https://ocaml.org/p/inifiles/latest

This work is based on the sources of the original `ocaml-inifiles`:
- sources: http://archive.ubuntu.com/ubuntu/pool/universe/o/ocaml-inifiles/ocaml-inifiles_1.2.orig.tar.gz
- opam package: https://github.com/ocaml/opam-repository/blob/6bfdcda303765cd219b61744da109c4dad079ad4/packages/ocaml-inifiles/ocaml-inifiles.1.2/opam
