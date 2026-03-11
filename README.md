# nixos

NixOS flake repo for Brian's machines.

## Hosts

- `laptop` — daily-driver laptop, NVIDIA, Wayland + Sway, Docker, libvirt, btrfs
- `desktop` — daily-driver desktop, NVIDIA, Wayland + Sway, Docker, libvirt, btrfs
- `vm` — daily-driver VM host, NVIDIA, Wayland + Sway, Docker, libvirt, btrfs
- `gaminglaptop` — new laptop, NVIDIA, Wayland + Sway, Docker, libvirt, btrfs

## Opinions baked in

- `x86_64-linux` everywhere
- btrfs, no disk encryption
- NVIDIA on all x86_64 hosts
- Wayland + Sway from day one
- Docker enabled everywhere
- libvirt enabled on all four hosts
- Meant to be usable as a real daily driver after first rebuild
- Snapshot tooling included for extra rollback protection

## Btrfs snapshot layout

This repo is set up around a snapper-friendly btrfs subvolume plan:

- `@` -> `/`
- `@home` -> `/home`
- `@nix` -> `/nix`
- `@log` -> `/var/log`
- `@snapshots` -> `/.snapshots`

Included:

- `services.btrfs.autoScrub`
- `snapper` timeline + cleanup policy for `/` and `/home`
- `scripts/create-btrfs-subvolumes.sh` helper
- `modules/filesystems/btrfs-subvolumes-example.nix` mount example

## Layout

- `flake.nix` — entry point
- `hosts/` — per-host configs and hardware placeholders
- `modules/` — shared NixOS modules
- `home/` — shared Home Manager config
- `scripts/` — helper scripts

## Important note on passwords

The shared user is currently configured as `drakzon` with an `initialPassword` in Nix for bootstrap convenience. That works, but it is not the clean final form. After first boot, you should switch to a hashed password or use something like sops-nix / agenix unless you enjoy leaving landmines in your repo.

## Next steps

1. Replace each `hosts/*/hardware-configuration.nix` with the generated hardware file from that machine.
2. Apply the btrfs subvolume layout during install so the generated hardware config mounts the expected subvolumes.
3. Rebuild a target host:

```bash
sudo nixos-rebuild switch --flake .#laptop
```

Or for another host:

```bash
sudo nixos-rebuild switch --flake .#desktop
```
