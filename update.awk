BEGIN{
    FS=","    
    OFS=","
}
NR==1 {
    a=0;
    if ($NF == "total") a=1;
}
/here_the_rollno/{
    ind = here_comes_the_number;
    old_marks = $ind
    $ind = here_comes_the_marks;
    if (a==1){
        $NF = $NF + here_comes_the_marks - old_marks;
    }
}
{
    print;
}