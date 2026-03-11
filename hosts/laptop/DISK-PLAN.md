# laptop disk plan

Use a single btrfs root filesystem with Timeshift-friendly subvolumes:

- `@` -> `/`
- `@home` -> `/home`
- `@nix` -> `/nix`
- `@log` -> `/var/log`
- `@snapshots` -> `/.snapshots`

Recommended mount options:

- `compress=zstd:3`
- `noatime`

This repo expects no disk encryption.
