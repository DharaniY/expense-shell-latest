#!/bin/bash

USERID=$(id -u)
TIMESTAMP=$(date +%F-%H-%M-%S)
SCRIPT_NAME=$( echo $0 | cut -d'.' -f1)
LOG_FILE=/tmp/$SCRIPT_NAME-$TIMESTAMP.log
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m" 

GETUSERDETAILS(){
    if [ $USERID -ne 0 ]
    then
        echo "Please login with root user to perfom this task."
        exit 1
    else
        echo "You are super user.... please procceed with task" 
    fi       
}

VALIDATION(){
    if [ $1 -ne 0 ]
    then
        echo -e "$2 is $R FAILED $N"
        exit 1 # exit if installation is FAILED
    else
        echo -e "$2 is $G SUCCESS $N"    
    fi    
}