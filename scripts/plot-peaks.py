#!/usr/env/python

#This script pulls x,y and elevation from a csv file and plots the 
#position of peaks the proximity between peaks

import pylab
import csv

proxlimit=10
#offset for text (x,y)
textoffset=(150,-75)

#parse the csv file with northing,easting,elevation
reader = csv.reader(open('Book1.csv'), delimiter=',')

#create empty lists
x=[]
y=[]
z=[]
x2=[]
y2=[]

#read in values from csv into lists
for row in reader:
    x.append(float(row[0]))
    y.append(float(row[1]))
    z.append(float(row[2]))

#set paramaters for the plot
params = {
          'axes.labelsize': 8,
          'text.fontsize': 8,
          'legend.fontsize': 8,
          'xtick.labelsize': 8,
          'ytick.labelsize': 8,
          'figure.figsize': (6,15)
          }
pylab.rcParams.update(params)
pylab.axis('equal')


#SHOWS ALL PEAKS
#~ count = 0
#~ for i in range(len(z)):
    #~ if count == 20:
        #~ x2.append(x[i])
        #~ y2.append(y[i])
        #~ P.text(x[i]+15,y[i],str(int(z[i])), fontsize=2)
        #~ count = 0
    #~ else:
        #~ count = count + 1

#SHOWS PEAKS >proxlimit APART
peaks = []
#get all peaks by comparing each value to the previous and next
for (index,value) in list(enumerate(z)):
    try:
        if (value > z[index + 1]) and (value > z[index - 1]):
            peaks.append(index)
    except IndexError:
        pass

final=[]
#the position is the the index of the original z value for that peak)
for (index,position) in list(enumerate(peaks)):
    try:
        #get the positions of the previous and next peak
        prev = peaks[index-1]
        next = peaks[index+1]
    except IndexError:
        pass

    #if > proxlimit from previous and next point
    if ((position - prev) >= proxlimit) and ((next - position) >= proxlimit):
        #append to find peaks
        final.append(position)
    else:
        #in proxlimit of prev
        if ((position - prev) < proxlimit):
            #taller than prev
            if (z[position] > z[prev]):
                #within proxlimit of next
                if ((next - position) < proxlimit):
                    #taller than next
                    if (z[position] > z[next]):
                        final.append(position)
                else:
                    final.append(position)
        else: #within proxlimit of next
            #taller than next
            if (z[position] > z[next]):
                final.append(position)

#get the position of the peak markers and add text for those markers
for index in final:
    x2.append(x[index])
    y2.append(y[index])
    pointlabel = str(int(z[index]))+','+str(x[index])+','+str(y[index])
    pylab.text(x[index]+textoffset[0],y[index]+textoffset[1],pointlabel,fontsize=4)

#plot values or all points on a line and markers for peaks
pylab.plot(x,y,'-',x2,y2,'ro')
pylab.xlabel('Easting')
pylab.ylabel('Northing')
pylab.savefig(r'C:\Documents and Settings\Ryan.Haigh.INTECH\Desktop\fig.png', dpi=300, )


