#!/bin/bash
echo "Do you want to enter the roll number or the name of the student? Enter r and n respectively."
read signal
if [[ $signal == "r" ]]; then
    read roll_no
    awk "NR==1{print;}/$roll_no/{print;}" main.csv #just to print out the data, a very simple awk code
fi
if [[ $signal == "n" ]]; then
    read name
    echo "Which of these is the name you want?"
    python3 fetch_name.py $name
    echo "Now enter the roll no you want:"
    read roll_no
    awk "NR==1{print;}/$roll_no/{print;}" main.csv
fi