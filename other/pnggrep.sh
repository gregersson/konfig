#!/bin/sh

# create temp files 
touch tmp_grepresults.txt
touch tmp_pngfilelist.txt
touch tmp_filestogrep.txt

find . -regex ".*\.[mh]" > tmp_filestogrep.txt
find . -regex ".*\.xib" >> tmp_filestogrep.txt
# find . -regex ".*Resources.*\.xib" >> tmp_grepresults.txt

# do a grep in each of the files
for i in $(cat tmp_filestogrep.txt); do 
    grep -i ".png" $i >> tmp_grepresults.txt
done;

# Remove false positives
sed -i '' -e 's|.*image/png.*||g' tmp_grepresults.txt
sed -i '' -e 's|.*UIImagePNGRepresentation(.*||g' tmp_grepresults.txt
sed -i '' -e 's|.*string key="objectName".*||g' tmp_grepresults.txt

# Trim everything until the last " before the filename and 
# everything after .png
sed -i '' -e 's|.*"\(.*\.png\).*|\1|g' tmp_grepresults.txt

# Trim xml tags
sed -i '' -e 's|^>||g' tmp_grepresults.txt
sed -i '' -e 's| *<string>||g' tmp_grepresults.txt
sed -i '' -e 's|</string>||g' tmp_grepresults.txt

# Trim leading whitespace and tabs
sed -i '' -e 's|^[ 	]*||g' tmp_grepresults.txt

# For some reason, a newline appears at beginning of grepresults, so we add one
# to the filelist for symmetric reasons :)
echo "" > tmp_pngfilelist.txt

# create a file listing all png files
find . -iname "*.png" >> tmp_pngfilelist.txt

# strip path from png file name list
sed -i '' -e 's|.*/||g' tmp_pngfilelist.txt

# strip files with @2x.png suffix, these should not appear in the grepresults 
# and will always result in a file difference
sed -i '' -e 's|.*@2x.png||g' tmp_pngfilelist.txt

# Sort the files while ignoring leading blanks, case and duplicates.
sort -b -f -u tmp_grepresults.txt > png_grep_results.txt
sort -b -f -u tmp_pngfilelist.txt > png_files.txt

# Remove temp files
rm tmp_grepresults.txt
rm tmp_pngfilelist.txt
rm tmp_filestogrep.txt

echo "----"
echo "The png files found -->  The png file references found"
echo "opendiff png_files.txt png_grep_results.txt"
echo "or"
echo "The png file references found ----> The png files found"
echo "opendiff png_grep_results.txt png_files.txt"
echo "----"
