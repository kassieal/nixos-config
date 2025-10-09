# Reminders about secret management

```
// generate age key
nix-shell -p age --run "age-keygen -y ~/.config/sops/age/keys.txt"

// edit secret file
nix-shell -p sops --run "sops secrets.yaml"

// update file for more hosts
nix-shell -p sops --run "sops updatekeys secrets.yaml"
```

- use The gpg key, make sure it's running and imported
- generate a key for the machine
- add it to the .sops.yaml
- make sure GPG key is imported for the machine using the shell.nix
