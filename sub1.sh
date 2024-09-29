#!/bin/bash
#Most of the code just reads the command line argument and offloads the job to the respective files, except git_log
if [[ $# -eq 2 ]]; then
    if [[ $1 == "upload" ]]; then
        mv $2 ~/Desktop/project
    fi
fi
if [[ $1 == "combine" ]]; then
    bash total.sh
fi
if [[ $1 == "total" ]]; then
        #echo "totalling"
        cp main.csv raghav
        awk -f ~/Desktop/project/com.awk raghav > main.csv
        rm raghav 
fi
if [[ $1 == "git_init" ]]; then
    address=$2
    ln -s $address ~/Desktop/project
    touch $address/.git_log
fi
if [[ $1 == "git_commit" ]]; then
    bash git_commit.sh $3
    #echo $3
fi
if [[ $1 == "git_checkout" ]]; then
    bash git_checkout.sh $2
fi
if [[ $1 == "update" ]]; then
    bash update.sh
fi
if [[ $1 == "fetch" ]]; then
    bash fetch.sh
fi
if [[ $1 == "grade" ]]; then
    python3 grade.py
fi
if [[ $1 == "efficient_combine" ]]; then
    bash combo.sh
fi
if [[ $1 == "statistics" ]]; then
    echo "Enter the name of the exam, or if you wish to see the statistics of the cumulative marks, enter total: "
    read input
    python3 stats.py $input
fi
if [[ $1 == "git_log" ]]; then
    #the following code snippet finds the symlink
    f_list=$(ls)
    for i in ${f_list[@]}
    do
    #echo $i ONLY FOR DEBUGGING
    if [[ -h $i ]]; then
        fn=$i
    fi
    done
    link=$(readlink "$fn")
    #this reads the commit IDs in reverse order
    tac $link/.git_log > temp
    while read line; do  
		#Reading each line  
  		echo #empty line
        cat $link/$line #prints the commit contents as stored in those files
        echo #empty line
	done < temp
    rm temp  
fi
#THE bash completion file you can see helps autocomplete the possible commands on unix terminal