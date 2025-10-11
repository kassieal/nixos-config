# Kassie's Configuration
## Description
A highly modular Nix flake that acts as the configuration for various systems I have about. Optimised to make adding modules trivial, no need to modify existing code to add new modules.

## Installation
Clone Repository:
```bash
git clone https://github.com/kassieal/nixos-config && cd nixos-config
```

Format with Disko and Verify Partioning:
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode disko hosts/<host-name>/disko.nix && lsblk
```

Generate the Hardware Configuration File:
```bash
sudo nixos-generate-config --no-filesystems --root /mnt/persist
```

Copy Hardware Configuration into Repository:
```bash
sudo cp /mnt/etc/nixos/hardware-configuration.nix hosts/<host-name>
```

Copy Configuration to Filesystem:
```bash
cd ../ && sudo cp -r nixos-config /mnt/persist/etc/nixos/
```

Change Directory to Repository:
```bash
cd /mnt/persist/etc/nixos/nixos-config
```

Install with Flake
```
sudo nixos-install --flake .#<host-name> --root /mnt
```
