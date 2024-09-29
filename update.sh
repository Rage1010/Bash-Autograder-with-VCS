
echo "Which exam's marks do you wanna update? Input one of these: "
find *.csv | sed 's/^\(.*\)\.csv$/\1/' | sed '/main/d'
read name
#echo $name
    echo "Whose marks do you wanna change? Enter a roll number:"
    read rollno
first_row=$(head -1 main.csv)
    IFS=','
    read -r -a data <<< $first_row
    let i=-1
    for j in ${data[@]} #runs through the header
    do
    let i=i+1
    #echo $i ONLY FOR DEBUGGING
    if [[ $j == $name ]]; then
        let index=$i #index finds the index in the row which matches the exam name
        break
    fi
    done
    #echo $index ONLY FOR DEBUGGING
    actual_row=($(grep "$rollno" main.csv))
    echo "His marks are currently: "${actual_row[$index]} 
    echo "Enter what you would like to change his marks to:"
    read new_marks
    #the following sed comand replaces the marks in the exam.csv file
    sed -i "s/$rollno,\(.*,\)${actual_row[$index]}\(.*\)/$rollno,\1$new_marks\2/" ${name}.csv
    let index=index+1
    #this sed command replaces in the update.awk file what we need the script to be
    sed -e "s/here_comes_the_number/$index/" -e "s/here_comes_the_marks/$new_marks/" -e "s/here_the_rollno/$rollno/" update.awk > temporary.awk
    awk -f temporary.awk main.csv > new #This is to modify the script according to what we need it to do
    bash sub1.sh total #totals again as the total will now be off
    cat new > main.csv
    rm new
    rm temporary.awk