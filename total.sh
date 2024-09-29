#!/bin/bash
header=$(head -1 main.csv 2>/dev/null) #gets the header
asdf=0 #0 if total has been enabled
if [[ $header =~ .*,total.* ]]; then
    asdf=1 #one if it hasn't
fi
file_list_strings=$(ls *.csv) #just gets all the csv files
#To get all the files
file_list=($file_list_strings);
#To make an array out of them
declare -a rolls #declare an array in which the roll numbers shall be stored
for file_name in "${file_list[@]}"
do
if [[ $file_name != "main.csv" ]]; then #the next two lines are an old code snippet when I had not enables searching for files by *.csv
if [[ $file_name != "submission.sh" ]]; then
if [[ $file_name != "sub1.sh" ]]; then
    IFS=$'\n'
i=1
for row in $(cat $file_name)
do
if [[ i -ne 1 ]]; then
    IFS=','
    read -r -a data <<< $row
    rolls+=(${data[0]}) #adding data to the rollnumbers array
fi
i=2
done
fi
fi
fi
done
uniques=($(for v in "${rolls[@]}"; do echo "$v";done| sort| uniq| xargs)) #this code snippet makes the elements of the array unique
#now the unique roll numbers exist in the array uniques
declare -a prefixes
for file_name in "${file_list[@]}"
do
if [[ $file_name != "main.csv" ]]; then
if [[ $file_name != "submission.sh" ]]; then
if [[ $file_name != "sub1.sh" ]]; then
    n=$((${#file_name}-4))
    file_prefix=${file_name:0:$n}
    prefixes+=($file_prefix)    #this is the array of the file prefixes which will be used as column names
fi
fi
fi
done
first="Roll_Number,Name" #this string will contain the string of the first row
for str in "${prefixes[@]}"
do
first+=","
first+=$str
done
echo "$first" > main.csv
declare -A names #this creates an associative array in which names are indexed by rollnos
for file_name in "${file_list[@]}"
do
if [[ $file_name != "main.csv" ]]; then
if [[ $file_name != "submission.sh" ]]; then
if [[ $file_name != "sub1.sh" ]]; then
   IFS=$'\n'
   a=0
    for row in $(cat $file_name)
        do
        if [[ a -ne 0 ]]; then 
            IFS=','
            read -r -a data <<< $row
            names[${data[0]}]=${data[1]} #adds the data
        fi
        a=1
        done
fi
fi
fi
done
IFS=' '
uni=($uniques)
#echo "${names[@]}"# This was to ensure the correct construction of the mapping between roll numbers and names
for roll in "${uni[@]}"
do
#echo $roll 
#echo $row
r=$roll #this will be the string of the row
r+=","
r+=${names[$roll]}
#echo $row
for file_name in "${file_list[@]}" #goes through the files
do
a=0 #this tells (if it is 1, the student was present)
if [[ $file_name != "main.csv" ]]; then #once again, the following two lines are old code snippets, back when I needed these
if [[ $file_name != "submission.sh" ]]; then
if [[ $file_name != "sub1.sh" ]]; then
   IFS=$'\n'
   #row+=(${names[$roll]}) this is wrong
    for ro in $(cat $file_name) #goes through the files, if finds roll number match, acts upon it
    do
        IFS=','
        read -r -a data <<< $ro
        if [[ ${data[0]} == $roll ]]; then #roll number matcher
            a=1
            r+=","
            r+=${data[2]} #appends the data
        fi
    done 
    if [[ a -eq 0 ]]; then
        r+=",a" #if absent
    fi
fi
fi
fi
done
echo "$r" >> main.csv
done
#sed 's/ /,/g' main > main.csv
if [[ asdf -eq 1 ]]; then
    bash sub1.sh total #if it was already totalled, totals again/
fi