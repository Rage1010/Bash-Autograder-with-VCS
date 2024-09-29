#!/bin/bash
fn="" #This is supposed to store the name of the symlink
    files_list=$(ls *.*)
    f_list=$(ls)
    for i in ${f_list[@]}
    do
    #echo $i ONLY FOR DEBUGGING
    if [[ -h $i ]]; then #this checks if it is a symlink
        fn=$i #this then stores it in this variable
    fi
    done
    #echo $fn FOR DEBUGGING
    if [[ fn == "" ]]; then
        echo "Error: Repository not initialised" #in case no symlink can be found
        exit 1
    fi
    link=$(readlink "$fn") #reading the link
    id=""
    for i in '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' #just the first method that came into my mind to loop 16 times.
    do
        let rand=$RANDOM/3277 #generating a random number
        id+="$rand" #appending it to the string
    done
    while [ -f "$id" ]; do #in the OFF chance it does collide with some other commit this code works to give you another commit id
        for i in '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' '1' #just the first method that came into my mind to loop 16 times.
    do
        let rand=$RANDOM/3277
        id+="$rand"
    done
    done
    touch $link/$id # I will create a text file which has the commit information
    mkdir $link/${id}_folder #this will have the contents
    for i in ${files_list[@]}
    do 
    cp $i $link/${id}_folder/$i > waste #This copies all the files into our newly committed folder. Also the "waste" thing is so that it does not show the messages on screen
    rm waste
    done
    if [[ -s $link/.git_log ]]; then #checks whether it is non empty only then runs it
        last_line=$(tail -1 $link/.git_log) #gets the last line
        the_two=($last_line) #splits it
        number="${the_two[0]}"
        #echo $number This was purely for debugging
        link_prev=$link/${number}_folder #oldfolder
        link_curr=$link/${id}_folder #newfolder
        files_list_prev=$(ls $link_prev)
        #The following arrays are self explanatory
        declare -a deleted
        declare -a added
        declare -a changed
        declare -a unchanged
        deleted=()
        added=()
        changed=()
        unchanged=()
        #echo ${files_list_prev[@]} this is for debugging as well
        #echo ${files_list[@]}
        for filen in ${files_list_prev[@]}
        do
        if [[ -f $filen ]]; then #the following code snippet checks whether they are changed or unchanged by the diff command
            diff $filen $link_prev/$filen > temp
                if [[ -s temp ]]; then
                    changed+=($filen)
                else
                    unchanged+=($filen)
                fi
            rm temp
        else #if it does not find it, it is added in deleted
            deleted+=($filen)
        fi
        done
        cd $link_prev
        for f in ${files_list[@]}
        do
            if [[ ! -f $f ]]; then #this checks what files are new
                added+=($f)
            fi
        done
        cd ~/Desktop/project
    #echo "$1" DEBUGGING
    echo "Committed with message: $1" >> $link/$id
    echo "The ID for this commit is: "$id >> $link/$id
    if [ ! ${#added[@]} -eq 0 ]; then
    echo "The files added in this commit are:" "${added[@]}" >> $link/$id
    fi
    if [ ! ${#changed[@]} -eq 0 ]; then
    echo "The files changed in this commit are:" "${changed[@]}" >> $link/$id
    fi
    if [ ! ${#unchanged[@]} -eq 0 ]; then
    echo "The files unchanged in this commit are:" "${unchanged[@]}" >> $link/$id
    fi
    if [ ! ${#deleted[@]} -eq 0 ]; then
    echo "The files deleted in this commit are:" "${deleted[@]}" >> $link/$id
    fi
    else 
        echo "Commited with message: "$1 >> $link/$id
        echo "The ID for this commit is: "$id >> $link/$id
    fi
    echo $id >> $link/.git_log #this stores the ID numbers in the .git_log file
    cat $link/$id