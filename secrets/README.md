# Reminders about secret management
Generate key from ssh
```
nix-shell -p ssh-to-pgp --run "ssh-to-pgp -i /etc/ssh/ssh_host_rsa_key -o machine_name.asc"
```
Get the ssh fingerprint
```
nix-shell -p ssh-to-age --run "cat /etc/ssh/ssh_host_ed25519_key.pub | ssh-to-age"
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
- update keys
- reboot into system
