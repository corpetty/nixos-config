# NixOS Configuration files

## Description

This repo defines [NixOS]() configuration for my hosts (currently only desktop). It follows the wisdom of the great `jakubgs`, so blame him for decisions. 

## Usage

Symlink the repo to `/etc/nixos`:

```bash
sudo ln -s $(realpath nixos-config) /etc/nixos
```

Deploy the configuration for given host using `--flake`:

```bash
sudo nixos-rebuild switch --flake `/etc/nixos#bean`
```

If the hostname matches `--flake` is not necessary. 

## Secrets (not implemented yet)
Secrets are fetched by `/roles/secrets.nix`:

1. Checking `secrets.nix` for overrides.
2. By calling `pass` for a given path.

Use `example.serets.nix` to create `secrets.nix`