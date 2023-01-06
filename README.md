Benchmark of backup tools
----

[rdiff-backup](https://github.com/rdiff-backup/rdiff-backup)
[backupPC](https://github.com/backuppc/backuppc)
restic

before changed

```text
1011M	RDIFF-TEST
124M	RESTIC-TEST
```

after changed

```text
912M	RDIFF-TEST
128M	RESTIC-TEST
```

show backups

```shell
# rdiff-backup -l RDIFF-TEST/
Found 1 increments:
    increments.2023-01-07T01:38:44+08:00.dir   Sat Jan  7 01:38:44 2023
Current mirror: Sat Jan  7 01:40:39 2023

#restic -p sha1.checksum -r RESTIC-TEST/ snapshots
repository 6d6ece4e opened successfully, password is correct
ID        Time                 Host        Tags        Paths
----------------------------------------------------------------------------------------
351a6050  2023-01-07 01:39:10  ubuntu-nas              /mnt/program/00.temp/DIR-FOR-TEST
57eedfb5  2023-01-07 01:40:47  ubuntu-nas              /mnt/program/00.temp/DIR-FOR-TEST
----------------------------------------------------------------------------------------
2 snapshots
```

show changed files

```shell
#rdiff-backup --compare DIR-FOR-TEST/ RDIFF-TEST/
changed: .
deleted: 100M-for-move-test.bin
deleted: add-file.txt
deleted: changed.txt
new: delete
new: delete/100M-for-delete-test.bin
changed: edit/100M-for-edit-test.bin
changed: move
new: move/100M-for-move-test.bin
new: rename-dir
new: rename-dir/100M-for-rename-dir-test.bin
deleted: rename-dir-2
deleted: rename-dir-2/100M-for-rename-dir-test.bin
changed: rename-file
deleted: rename-file/100M-for-rename-file-test-2.bin
new: rename-file/100M-for-rename-file-test.bin

# restic -p sha1.checksum diff 351a6050 57eedfb5 -r RESTIC-TEST/
repository 6d6ece4e opened successfully, password is correct
comparing snapshot 351a6050 to 57eedfb5:

+    /mnt/program/00.temp/DIR-FOR-TEST/100M-for-move-test.bin
+    /mnt/program/00.temp/DIR-FOR-TEST/add-file.txt
+    /mnt/program/00.temp/DIR-FOR-TEST/changed.txt
-    /mnt/program/00.temp/DIR-FOR-TEST/delete/
-    /mnt/program/00.temp/DIR-FOR-TEST/delete/100M-for-delete-test.bin
M    /mnt/program/00.temp/DIR-FOR-TEST/edit/100M-for-edit-test.bin
-    /mnt/program/00.temp/DIR-FOR-TEST/move/100M-for-move-test.bin
-    /mnt/program/00.temp/DIR-FOR-TEST/rename-dir/
-    /mnt/program/00.temp/DIR-FOR-TEST/rename-dir/100M-for-rename-dir-test.bin
+    /mnt/program/00.temp/DIR-FOR-TEST/rename-dir-2/
+    /mnt/program/00.temp/DIR-FOR-TEST/rename-dir-2/100M-for-rename-dir-test.bin
+    /mnt/program/00.temp/DIR-FOR-TEST/rename-file/100M-for-rename-file-test-2.bin
-    /mnt/program/00.temp/DIR-FOR-TEST/rename-file/100M-for-rename-file-test.bin

Files:           5 new,     4 removed,     1 changed
Dirs:            1 new,     2 removed
Others:          0 new,     0 removed
Data Blobs:      3 new,     2 removed
Tree Blobs:      7 new,     8 removed
  Added:   4.009 MiB
  Removed: 8.009 MiB
```

verify

```shell
#rdiff-backup --verify RDIFF-TEST/
Every file verified successfully.

#restic -p sha1.checksum -r RESTIC-TEST/ check 
using temporary cache in /tmp/restic-check-cache-001259474
repository 6d6ece4e opened successfully, password is correct
created new cache in /tmp/restic-check-cache-001259474
create exclusive lock for repository
load indexes
check all packs
check snapshots, trees and blobs
no errors were found
```

show stats
```shell
#restic -p sha1.checksum stats -r RESTIC-TEST/
repository 6d6ece4e opened successfully, password is correct
scanning...
Stats for all snapshots in restore-size mode:
  Total File Count:   42
        Total Size:   1.875 GiB
```

find file in all backups

```shell
#restic -p sha1.checksum -r RESTIC-TEST/ find *txt
repository 6d6ece4e opened successfully, password is correct
Found matching entries in snapshot 351a6050
/mnt/program/00.temp/DIR-FOR-TEST/string.txt

Found matching entries in snapshot 57eedfb5
/mnt/program/00.temp/DIR-FOR-TEST/add-file.txt
/mnt/program/00.temp/DIR-FOR-TEST/changed.txt
/mnt/program/00.temp/DIR-FOR-TEST/string.txt
```

list all files (and dirs)

```shell
#restic -p sha1.checksum -r RESTIC-TEST/ ls 57eedfb5
repository 6d6ece4e opened successfully, password is correct
snapshot 57eedfb5 of [/mnt/program/00.temp/DIR-FOR-TEST] filtered by [] at 2023-01-07 01:40:47.05596533 +0800 CST):
/mnt
/mnt/program
/mnt/program/00.temp
/mnt/program/00.temp/DIR-FOR-TEST
/mnt/program/00.temp/DIR-FOR-TEST/100M-for-move-test.bin
/mnt/program/00.temp/DIR-FOR-TEST/100M.bin1
/mnt/program/00.temp/DIR-FOR-TEST/100M.bin4
/mnt/program/00.temp/DIR-FOR-TEST/add-file.txt
/mnt/program/00.temp/DIR-FOR-TEST/changed.txt
/mnt/program/00.temp/DIR-FOR-TEST/duplicate
/mnt/program/00.temp/DIR-FOR-TEST/duplicate/100M.bin1
/mnt/program/00.temp/DIR-FOR-TEST/duplicate/100M.bin2
/mnt/program/00.temp/DIR-FOR-TEST/duplicate/100M.bin3
/mnt/program/00.temp/DIR-FOR-TEST/edit
/mnt/program/00.temp/DIR-FOR-TEST/edit/100M-for-edit-test.bin
/mnt/program/00.temp/DIR-FOR-TEST/move
/mnt/program/00.temp/DIR-FOR-TEST/rename-dir-2
/mnt/program/00.temp/DIR-FOR-TEST/rename-dir-2/100M-for-rename-dir-test.bin
/mnt/program/00.temp/DIR-FOR-TEST/rename-file
/mnt/program/00.temp/DIR-FOR-TEST/rename-file/100M-for-rename-file-test-2.bin
/mnt/program/00.temp/DIR-FOR-TEST/string.txt
```

mount as filesystem

```shell
restic -p sha1.checksum -r RESTIC-TEST/ mount restic-mount
```