Dependency resolving example for feature-modularized iOS app inspired by [this presentation](https://scrapbox.io/ikesyo/Mobile_Act_ONLINE_%236_%7C_uber%2Fneedle%E3%82%92%E7%94%A8%E3%81%84%E3%81%9F%E3%83%A2%E3%82%B8%E3%83%A5%E3%83%BC%E3%83%AB%E9%96%93%E3%81%AE%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E3%81%A8DI)

[![Continuous Integration Status](https://github.com/hrfmmr/ios-di-sandbox/workflows/CI/badge.svg)](https://github.com/hrfmmr/ios-di-sandbox/workflows/CI/badge.svg)

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
