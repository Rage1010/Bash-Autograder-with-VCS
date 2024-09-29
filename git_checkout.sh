#!/bin/bash
commit_number_prefix=$1
    f_list=$(ls)
    for i in ${f_list[@]}
    do
    #echo $i ONLY FOR DEBUGGING
    if [[ -h $i ]]; then #this checks if i is a softlink
        fn=$i
    fi
    done
    if [[ fn == "" ]]; then
        echo "Error: Repository not initialised"
        exit 1
    fi
    link=$(readlink "$fn") #to get the link from the softlink
    cd $link
    output_files=($(ls ${commit_number_prefix}*)) #to get the list of files (notice that my files are named with the id as the name)
    let r=0 #the variable to count the number of such files
    for g in ${output_files[@]}
    do
        if [[ $g =~ .*: ]]; then
            break
        else
            let r=r+1 #increment 
        fi
    done
    if [[ $r -ge 2 ]];then #THE FOLLOWING RUNS ONLY WHEN THERE ARE CONFLICTS
        echo "Conflicts: could be any of the following commits:"
        for h in ${output_files[@]} #This loop outputs all the possibilities
            do
            if [[ -f $h ]]; then
            echo $h
            fi
            done
        exit 1 #No use continuing the program in this case
    elif [[ $r -eq 0 ]]; then # self explanatory
        echo "No such commits exist"
        exit 1
    else    
        for h in ${output_files[@]} # this is a very trivial loop to store the element in our variable of choice
            do
            if [[ -f $h ]]; then
            final_commit=$h
            fi
            done
        #The following code first deletes everything in the project directory and then copies everything. the *.* argument is given so that only files are dealt with.
        cd ~/Desktop/project
        rm *.*
        cd $link
        cd ${final_commit}_folder
        cp -r * ~/Desktop/project
        cd ~/Desktop/project
        echo
    fi