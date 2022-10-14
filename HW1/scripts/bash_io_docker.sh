#! /bin/bash

for i in {1..5}
do
  sysbench --test=fileio --file-test-mode=seqwr run >> output2.txt
  sysbench --test=fileio --file-test-mode=seqwr --file-num=5 --file-block-size=64
  sysbench --test=fileio --file_test-mode=rndwr --file-num=10 --file-block-size=128 --file-io-mode=async
  sysbench --test=fileio --file_test-mode=seqrd --file-num=40 --file-block-size=512 --file-test-mode=sync
  sysbench --test=fileio --file-test-mode=seqrewr --file-num=45 --file-block-size=1024 --file-io-mode=async
done



