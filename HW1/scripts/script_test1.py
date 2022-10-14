#!/usr/bin/env python3
import os
import random
  
#script five create folders with random number
folder_name = "performance test 1"

for i in range(3):
    number = int(random.randrange(0, 100))
    print("Creating folder {}".format(number))
    os.mkdir(folder_name+" {}".format(number))


