#!/usr/bin/env bash
TMPDIR="DIR-FOR-TEST"

rdiff-backup "$TMPDIR" RDIFF-TEST

restic init -p sha1.checksum --repo RESTIC-TEST
restic -p sha1.checksum -r RESTIC-TEST/ backup "$TMPDIR"

# show backups
# restic -p sha1.checksum -r RESTIC-TEST/ snapshots

# restore
# restic -p sha1.checksum -r RESTIC-TEST/ restore 351a6050 -t ./

# restic -p sha1.checksum -r RESTIC-TEST/ mount restic-mount/

