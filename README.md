# BFortran

a Brainfuck interpreter written in Fortran90

## How to build / install:

1. Install [fpm](https://fpm.fortran-lang.org/)
2. Run `fpm build`
3. (To install) Run `fpm install`. The binary will be located in ~/.local/bin

## How to use:

```console
# if installed
$ Brainfuck <path/to/bf/file>

# otherwise :
$ fpm run -- <path/to/bf/file>
```
