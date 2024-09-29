BEGIN{a=0;FS=",";OFS=",";}
NR==1{
    if($NF=="total"){
        a=1;
        print $0;
    }
    else{print $0, "total";}
}
NR>1{
    sum=0
    for(i=3;i<=NF;i++){
        sum=sum+$i;
    }
    if(a==1){
        sum-=$NF;
        for(i=1;i<NF;i++) printf("%s,",$i);
        printf("%.2f\n",sum);
    }
    else{
        for(i=1;i<=NF;i++) printf("%s,",$i);
        printf("%.2f\n",sum);
    }
}