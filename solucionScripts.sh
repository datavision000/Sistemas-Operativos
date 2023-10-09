#!/bin/bash

for archivo in $(find "/home/admin" -type f -name "*.sh")
do
    sed -i 's/\r$//' "$archivo"
done

find /home/admin -type f -exec dos2unix {} \; > /dev/null 2>&1