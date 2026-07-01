# Kantum's dotfiles

Know everything about my setup

For Mac, first install nix and activate flake and nix-command, then link the nix-darwin like so:
```shell
 sudo ln -s $PWD /etc/nix-darwin
```

## OpenCode Sandbox

OpenCode runs as a sandboxed `opencode` user. Grant/revoke repo access:

```
opencode-allow /path/to/repo
opencode-deny /path/to/repo
```
