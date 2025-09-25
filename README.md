An ini file parser.

Rewritten to not use `pcre`, because `pcre` depends on `libpcre3` which is [not
available](https://packages.debian.org/search?suite=trixie&section=all&arch=any&lang=en&searchon=names&keywords=libpcre3)
on Debian 13, and generaly obsolete. The modern alternative is `libpcre2`, which
has ocaml bindings in the opam package `pcre2`.
