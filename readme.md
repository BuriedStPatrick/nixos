# NixOS Config

This is my NixOS build config.

![Desktop screenshot](./docs/desktop.png)

> Note that this assumes a lot at the moment:
> 1. Your name is patrick
> 2. You have your NixOS config at ~/nixos

## Build

```bash
# First time, assume this repo is at ~/nixos
sudo nixos-rebuild switch --flake ${HOME}/nixos#nixos

# Consecutive builds
nixbuild
```

## Edit config

```bash
nixedit
```

## Clean up old generations

```bash
nixclean
```
