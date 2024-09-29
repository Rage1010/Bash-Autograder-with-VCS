from difflib import SequenceMatcher #this library has the functions which tells you how similar two strings are
import sys
args=sys.argv[:]
name=args[1] #getting the name in the variable "name"
import pandas as pd
def similar(a, b): #the function which returns how similar two strings are?
    return SequenceMatcher(None, a, b).ratio()
def actualsim(a,b):
    brra=b.split() #split it into the first and last names
    arra=a.split()
    sum=0
    for i in brra:
        sum+=max([similar(j,i) for j in arra]) #I am evaluating the max match of one name agaist all the names in the other name, and adding them.
    sum/=len(brra) #average it so there is no unfair advantage due to number of words in the name
    return sum
#print(similar("raghav","raghav"))
df = pd.read_csv("main.csv")
#print(len(df))
l=[i for i in range(len(df))]
def keys(i):
    return actualsim(df.iloc[i,1],name)
l.sort(key=keys) #this is to sort on the basis of similarity
#The following code returns the best three matches
print(df.iloc[l[-1],:2].to_string(index=False))
print(df.iloc[l[-2],:2].to_string(index=False))
print(df.iloc[l[-3],:2].to_string(index=False))
#print(actualsim("Malay Kedia","Kedia Malay"))