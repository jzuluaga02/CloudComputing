#! /bin/bash

for i in {1000..20000..5000}
do
   printf "Test with  cpu max prime of $i\n" >> output.txt
   sysbench --test=cpu  --cpu-max-prime=$i run >> output.txt
done


