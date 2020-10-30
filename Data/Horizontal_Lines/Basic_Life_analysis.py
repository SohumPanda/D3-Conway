""" 
Made by Tanjim Chowdhury
29/10/2020

Edited by Sohum Panda 
29/10/2020

Used to analyse line seed data from Conway's Life
"""

import numpy as np
import scipy as sp
import matplotlib.pyplot as plt
import pandas as pd

datas_arr = []                                                            # list containing lists that have numpy arrays at index 1

for x in [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46,47,48,49,50,55,60,65,70,75,80,85,90,95,100]:   # these numbers are the files ur reading in
    data = pd.read_csv(f"h{str(x)}.csv", header = None)                   # change the string so it looks like your file names
    datas_arr.append([x, np.array(data)])                                 # eg for x = 7 --> [7, array containing data] is put into datas_arr


#plt.figure("Graph") 

x = []
y = []

for data_set in datas_arr:
    x.append(data_set[0])
    y.append(np.max(data_set[1],axis = 0)[0])

plt.scatter(x, y, marker = '+')