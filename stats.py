import numpy as np
import pandas as pd
import sys
import matplotlib.pyplot as plt
name=sys.argv[1]
#the following code snippet stores in the name the file it has to access
if name=="total":
    #print(1) FOR DEBUGGING
    name="main"
name+=".csv"
#reading that file
df=pd.read_csv(name)
l=[]
a=-1
column_names_list = df.columns.tolist()
if name=="main.csv" and column_names_list[-1]=="grade": #just to ensure this works even if we have graded
    a=-2
for i in range(len(df)):
    l.append(int(df.iloc[i,a]))
array=np.array(l) #this stores the marks in an array that we just talked about
print("Median of the data is: ", np.median(array)) #pretty self explanatory
print("Mean of the data is: ", np.mean(array))
print("Std Dev of the data is: ", np.std(array))
if name=="midsem.csv":
    c=10 #the number of bins for useful data that i expiremented myself
else:
    c=13 #same
hist, bins = np.histogram(array, bins=c)
# LA HISTOGRAM
plt.hist(array, bins=bins, color='skyblue', edgecolor='black')
plt.show()
