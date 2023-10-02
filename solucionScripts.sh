#!/bin/bash

for archivo in $(find "/home/admin" -type f -name "*.sh")
do
    sed -i 's/\r$//' "$archivo"
done