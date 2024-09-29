#!/bin/bash
#ignore this file. This is an incomplete modification to make combine efficient. To see, partial progress you can run this script.
file_list_strings=$(ls *.csv)
l=()
file_list=($file_list_strings);
for file_name in "${file_list[@]}"
do
if [[ $file_name != "main.csv" ]]; then
    l+=($file_name)
fi
done
touch comb
for file in "${l[@]}"
do
sed "s/$/,$file/" $file >> comb
done
cat comb | sort | head -n -3 > processing
echo