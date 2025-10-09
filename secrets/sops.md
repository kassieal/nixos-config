# Reminders about secret management
Generate age key
```
nix-shell -p age --run "age-keygen -y ~/.config/sops/age/keys.txt"
```

Edit secret file
```
nix-shell -p sops --run "sops secrets.yaml"
```

Update file for more hosts
```
nix-shell -p sops --run "sops updatekeys secrets.yaml"
```

- generate a key for the machine
- add it to the .sops.yaml
