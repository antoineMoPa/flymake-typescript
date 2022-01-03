UPDATE: This was a fun experiment, but I strongly suggest lsp-mode, which works incredibly well with typescript. I wished I had discovered this earlier:

https://emacs-lsp.github.io/lsp-mode/page/lsp-typescript/


# flymake-typescript

This is a very basic flymake backend for typescript. It will find the tsc executable in the current project.

# History

While working on a small 3D game for fun with BabylonJS, I realized there was no typescript-flymake package. I wasted a whole saturday coding this.

# Shortcomings

Currently, it is not configurable (as in we can't change the command executable). Also, we cannot set a config. Also, the package is not on melpa/elpa yet.

# Contributing

Any help is welcome, from documenting, finding bugs to addressing shortcomings!
