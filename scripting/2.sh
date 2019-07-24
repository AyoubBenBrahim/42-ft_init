#!/bin/bash

del_user() 
{
	sudo passwd -l $user_name > /dev/null 2>&1
   	is_error=$(echo $?)
	if [ $is_error -eq 1 ]; then
		echo "\033[0;31mThis user doesn't exist !\033[0m"
		exit 0
	fi

	sudo pkill -u $user_name > /dev/null 2>&1
	sudo userdel -rf $user_name > /dev/null 2>&1
	
	if [ $? -eq 1 ]; then
		echo "an error occured !"
		exit 0
	fi
	echo "\033[0;31muser $user_name was deleted successfully.\033[0m"
}

if [ "$1" ]; then
	user_name=$1
else
	echo "Usage : sh $0 user_name"
	exit 0
fi

 printf "are you sure you want to delete $user_name ?: yes/no\n "
 read action

 if [ "$action" = "yes" ]; then
 	del_user
 elif [ "$action" = "no" ]; then
 	exit 0
 else
	echo "make sure u enter yes or no"
 fi


# $? contains the exit status of the previous command  0 = successful 1 = problem

#userdel command will not allow you to remove an account if the user is currently logged in.
#You must kill any running processes which belong to an account that you are deleting,
#Start by locking the user account password so that there is no access for the user to the system. 
#This will prevent a user from running processes on the system.
# passwd -l ayoub
# passwd --status ayoub --> check the locked account status
# to unlock a user passwd -u ayoub
#Next find out all running processes of user account and kill them by determine
# the PIDs (Process IDs) of processes owned by the user 
#You must kill any running processes which belong to an account that you are deleting