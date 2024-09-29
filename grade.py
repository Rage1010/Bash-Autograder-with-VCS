import pandas as pd
import matplotlib.pyplot as plt
df=pd.read_csv("main.csv")
length=len(df)
#as an aid to grading, I shall be presenting the percentile versus marks graph
xaxis=[(i+1)*100/len(df) for i in range(185)]
#print(xaxis)
marks=[]
for i in range(length):
    marks.append(df.iloc[i,-1])
marks.sort() #we need to sort the marks array to get the percentile versus marks mapping
#print(marks)
plt.plot(xaxis,marks)
plt.grid(True, which='both')
xt=[5*(i+1) for i in range(19)]
plt.xticks(xt) #adding better labels
plt.xlabel("Percentile")  # Add x-axis label
plt.ylabel("Marks")  # Add y-axis label
plt.savefig("graph.jpg")
plt.clf() #Getting it ready to save another figure
plt.hist(marks,bins=12)
for i in range(20):
    if i==0:
        continue
    i*=5
    print("Approximate marks for the", i, "th percentile is:", marks[int(i*length/100)])
plt.savefig('plot.jpg')
#THE user is supposed to look at the two images as data help, and decide cutoffs for grades, the following is just very obvious user interface stuff
AP=input("Based on this data, what do you want the marks cutoff for AP? ")
AA=input("Cutoff for AA? ")
AB=input("Cutoff for AB? ")
BB=input("Cutoff for BB? ")
BC=input("Cutoff for BC? ")
CC=input("Cutoff for CC? ")
CD=input("Cutoff for CD? ")
DD=input("Cutoff for DD? ")
print("Rest shall be awarded FR ")
grades=[]
for i in range(length):
    #print(df.iloc[i,-1]) only for debugging
    #The following code snippet very easily adds another column. Note that grade has to be used at the END.
    mark=float(df.iloc[i,-1])
    if mark >= float(AP):
        grades.append("AP")
    elif mark >= float(AA):
        grades.append("AA")
    elif mark >= float(AB):
        grades.append("AB")
    elif mark >= float(BB):
        grades.append("BB")
    elif mark >= float(BC):
        grades.append("BC")
    elif mark >= float(CC):
        grades.append("CC")
    elif mark >= float(CD):
        grades.append("CD")
    elif mark >= float(DD):
        grades.append("DD")
    else :
        grades.append("FR")
df['grade']=grades
df.to_csv("main.csv")