#! /bin/sh
#set -x
idle=90
cloumn=13
for i in `mpstat -P ALL| awk '{print $$column}'`
do
if [ $i > $idle	]
then
echo $i
fi
done

