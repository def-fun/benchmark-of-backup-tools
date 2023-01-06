#!/usr/bin/env bash
TMPDIR="DIR-FOR-TEST"
if [ -f "$TMPDIR/changed.txt" ];then
  echo "exit"
  exit
fi

# add file
echo "add file" > "$TMPDIR/add-file.txt"

# rename dir
mv "$TMPDIR/rename-dir" "$TMPDIR/rename-dir-2"

# rename file
mv "$TMPDIR/rename-file/100M-for-rename-file-test.bin" "$TMPDIR/rename-file/100M-for-rename-file-test-2.bin"

# move file
mv "$TMPDIR/move/100M-for-move-test.bin" "$TMPDIR/100M-for-move-test.bin"

# edit file
echo "edit file" >> "$TMPDIR/edit/100M-for-edit-test.bin"

# delete file
rm -r "$TMPDIR/delete"

# mark done
echo "changed" > "$TMPDIR/changed.txt"
