#!/bin/bash

 source ./common.sh

 GETUSERDETAILS

echo "Please enter DB password:"
read -s mysql_root_password

# if [ "$USERID" -ne 0 ]
# then
#     echo "Login with root user for perform this action."
#     exit 1  # exit if user is not root user
# else
#     echo "You are root user"
# fi


# install mysql package
dnf install mysql-server -y &>>$LOG_FILE
VALIDATION $? "Installing MYSQL server"

# enabling mysql server
systemctl enable mysqld &>>$LOG_FILE
VALIDATION $? "enabling mysql server" 

#Starting mysql server
systemctl start mysqld &>>$LOG_FILE
VALIDATION $? "Starting mysql server"

#Below code will be useful for idempotent nature
mysql -h db.sivasatya.online -uroot -p${mysql_root_password} -e 'show databases;' &>>$LOG_FILE
if [ $? -ne 0 ]
then
    mysql_secure_installation --set-root-pass ${mysql_root_password} &>>$LOG_FILE
    VALIDATION $? "MySQL Root password Setup"
else
    echo -e "MySQL Root password is already setup...$Y SKIPPING $N"
fi