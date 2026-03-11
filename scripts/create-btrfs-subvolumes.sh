#!/usr/bin/env bash
set -euo pipefail

MNT="${1:-/mnt}"

for subvol in @ @home @nix @log @snapshots; do
  if [ ! -d "$MNT/$subvol" ]; then
    btrfs subvolume create "$MNT/$subvol"
  fi
done

echo "Created subvolumes under $MNT: @ @home @nix @log @snapshots"
