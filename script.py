import random
import os


for j in range(2,21):
	for i in range(1,10):
		y=random.randint(1,43);
		x=random.randint(0,5);
		z=random.randint(1,i);
		s="octave course_recommender.m "+str(x)+" "+str(y)+" "+str(j);
		os.system(s);
		pass
	pass	
