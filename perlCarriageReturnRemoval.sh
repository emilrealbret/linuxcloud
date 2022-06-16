#!/bin/bash

#userinput for variable filename
echo "What file do you want to remove carriage returns from? \n :"
read filename

#removes carriage returns from file
perl -p -i -e "s/\r//g" $filename
