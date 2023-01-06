#!/usr/bin/env bash
# init
TMPDIR="DIR-FOR-TEST"
rm -rf "$TMPDIR"

#generate data for test
mkdir -p "$TMPDIR/duplicate"
dd if=/dev/urandom of="$TMPDIR/duplicate/100M.bin1" bs=1M count=100
#for((i=0; i<104857; i++))
#do
#  echo 'qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM`1234567890-=+_)(*&^%$#@!~[]\|;:",./<>?12345678' >> "$TMPDIR/string.txt"
#done
#for((i=0; i<10; i++))
#do
#  cat "$TMPDIR/string.txt" >> "$TMPDIR/duplicate/100M.bin1"
#done
cp "$TMPDIR/duplicate/100M.bin1" "$TMPDIR/duplicate/100M.bin2"
cp "$TMPDIR/duplicate/100M.bin1" "$TMPDIR/duplicate/100M.bin3"
cp "$TMPDIR/duplicate/100M.bin1" "$TMPDIR/100M.bin1"
cp "$TMPDIR/duplicate/100M.bin1" "$TMPDIR/100M.bin4"

mkdir -p "$TMPDIR/rename-dir/"
cp "$TMPDIR/duplicate/100M.bin1" "$TMPDIR/rename-dir/100M-for-rename-dir-test.bin"
echo "rename-dir-test" >> "$TMPDIR/rename-dir/100M-for-rename-dir-test.bin"

mkdir -p "$TMPDIR/rename-file/"
cp "$TMPDIR/duplicate/100M.bin1" "$TMPDIR/rename-file/100M-for-rename-file-test.bin"
echo "rename-file-test" >> "$TMPDIR/rename-file/100M-for-rename-file-test.bin"

mkdir -p "$TMPDIR/edit/"
cp "$TMPDIR/duplicate/100M.bin1" "$TMPDIR/edit/100M-for-edit-test.bin"
echo "edit-test" >> "$TMPDIR/edit/100M-for-edit-test.bin"

mkdir -p "$TMPDIR/delete/"
cp "$TMPDIR/duplicate/100M.bin1" "$TMPDIR/delete/100M-for-delete-test.bin"
echo "delete-test" >> "$TMPDIR/delete/100M-for-delete-test.bin"

mkdir -p "$TMPDIR/move/"
cp "$TMPDIR/duplicate/100M.bin1" "$TMPDIR/move/100M-for-move-test.bin"
echo "move-test" >> "$TMPDIR/move/100M-for-move-test.bin"

#find "$TMPDIR" -type f -exec sha1sum {} \;|sort > sha1.checksum
sha1sum -c sha1.checksum  > /dev/null
du -sh "$TMPDIR"

# backup first


# show disk usage


# make some change


# backup


# show disk usage
