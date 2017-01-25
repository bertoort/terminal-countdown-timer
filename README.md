# Terminal Countdown Timer

Simple CLI timer written in Haskell.

## IOS Download

```sh
$ brew install wget
$ wget https://github.com/berto/terminal-countdown-timer/raw/master/bin/timer 
$ chmod u+x timer
$ mv timer /usr/local/bin
```

## Running / Testing

First, install stack. `curl -sSL https://get.haskellstack.org/ | sh` will work on most Unix systems, otherwise checkout https://docs.haskellstack.org/en/stable/README/ . If you haven't run other Haskell projects on your system, the first time you try to build the project it may say you have to run `stack setup`; do so.

Running:
```bash
stack build && stack exec timer 
```

Testing:
```bash
stack build && stack test
```

Installing:
```bash
stack build && stack install .
