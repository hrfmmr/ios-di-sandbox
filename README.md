Dependency resolving example for feature-modularized iOS app

## Prerequisites

* [Mint](https://github.com/yonaskolb/Mint)
* [Needle](https://github.com/uber/needle#using-homebrew)

## Set up

```sh
make
```

if you are running on M1 Mac, execute following command to ensure homebrew's binary path is applied while Run-Script phase.

```
cat << 'EOF' | tee .envrc
export PATH=$PATH:/opt/homebrew/bin:/opt/homebrew/sbin
EOF
```
