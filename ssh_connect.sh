#!/bin/bash

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                                                         #
#                  SSH Connect Script                     #
#                                                         #
#    This script will allow you to quickly connect        #
#      to internal servers through a SSH jumpbox.         #
#                                                         #
#              Written by:  Tyler M Johnson               #
#           https://github.com/yippieskippie24            #
#                                                         #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

#*#*#*#*#*#*#*#*#   Setup instructions    #*#*#*#*#*#*#*#*#
# This script is written with the assumption that it      #
# resides in the home folder of the user that runs it.    #
# You will need to set the names of the variables         #
# below to the FQDNs and descriptions of the servers you  #
# want to be accessible in this script. You can also      #
# change the ports as needed.                             #
#                                                         #
# If you want fewer server options listed just remove the #
# content of the variable. For instance:                  #
#                  server10=                              #
#                  server10_desc=                         #
#                  server10_port=                         #
#                                                         #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

#editable Variables
server1="server1-hostname"
server1_desc="server1-description"
server1_port="22"

server2="server2-hostname"
server2_desc="server2-description"
server2_port="22"

server3="server3-hostname"
server3_desc="server3-description"
server3_port="22"

server4="server4-hostname"
server4_desc="server4-description"
server4_port="22"

server5="server5-hostname"
server5_desc="server5-description"
server5_port="22"

server6="server6-hostname"
server6_desc="server6-description"
server6_port="22"

server7="server7-hostname"
server7_desc="server7-description"
server7_port="22"

server8="server8-hostname"
server8_desc="server8-description"
server8_port="22"

server9="server9-hostname"
server9_desc="server9-description"
server9_port="22"

server10=
server10_desc=
server10_port=

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                                                                    #
#                 Do not edit below this section                     #
#                                                                    #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#


#static variables

customSERVER=""
serverSELECTION=""
portSELECTION=""
userSELECTION=""
advanceMenu_selection=""


#Servers + descriptions Array
servers=(\
$server1 $server1_desc \
$server2 $server2_desc \
$server3 $server3_desc \
$server4 $server4_desc \
$server5 $server5_desc \
$server6 $server6_desc \
$server7 $server7_desc \
$server8 $server8_desc \
$server9 $server9_desc \
$server10 $server10_desc \
)


#Default menu Array
defaultmenu=(\
Custom "Connect to another server" \
Advanced "Advanced Menu" \
Exit "Exit this script" \
)

#combine Servers + descriptions Array with Default menu Array
mainMenuARRAY=("${servers[@]}" "${defaultmenu[@]}")


#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                         Main Menu Function                         #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

function mainMenu() {
	serverSELECTION=$(whiptail --title "SSH Connect" --nocancel --menu "Choose Server to connect to:" 30 65 20 \
		"${mainMenuARRAY[@]}" 3>&1 1>&2 2>&3)

			SSH_port_picker


		if [ "$serverSELECTION" = "Custom" ]; then
			customServer
		elif [ "$serverSELECTION" = "Advanced" ]; then
			advanceMenu
		elif [ "$serverSELECTION" = "Exit" ]; then
			EXIT
		else
			SSH_connect
		fi
}

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                       SSH Port Picker Function                     #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

function SSH_port_picker() {
		if [ "$serverSELECTION" = "$server1" ]; then
			portSELECTION=$server1_port
		elif [ "$serverSELECTION" = "$server2" ]; then
			portSELECTION=$server2_port
		elif [ "$serverSELECTION" = "$server3" ]; then
			portSELECTION=$server3_port
		elif [ "$serverSELECTION" = "$server4" ]; then
			portSELECTION=$server4_port
		elif [ "$serverSELECTION" = "$server5" ]; then
			portSELECTION=$server5_port
		elif [ "$serverSELECTION" = "$server6" ]; then
			portSELECTION=$server6_port
		elif [ "$serverSELECTION" = "$server7" ]; then
			portSELECTION=$server7_port
		elif [ "$serverSELECTION" = "$server8" ]; then
			portSELECTION=$server8_port
		elif [ "$serverSELECTION" = "$server9" ]; then
			portSELECTION=$server9_port
		elif [ "$serverSELECTION" = "$server10" ]; then
			portSELECTION=$server10_port
		fi
}

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                        Custom Server Function                      #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

function customServer() {
			customSERVER=$(whiptail --inputbox "What is the FQDN of the server you want to connect to?" 8 78 --title "Custom server" 3>&1 1>&2 2>&3)
			portSELECTION=$(whiptail --inputbox "What port do you want to connect on?" 8 78 22 --title "Select Port" 3>&1 1>&2 2>&3)
			userSELECTION=$(whiptail --inputbox "What user do you want to use to connect?" 8 78 $USER --title "Select User" 3>&1 1>&2 2>&3)
		if [ "$portSELECTION" = "22" ]; then
			echo connecting to $customSERVER...
			ssh $customSERVER -l $userSELECTION
			mainMenu
		else
			echo connecting to $customSERVER on port $portSELECTION...
			ssh $customSERVER -p $portSELECTION -l $userSELECTION
			mainMenu
		fi
}

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                        SSH_connect Function                        #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

function SSH_connect() {
		if [ "$portSELECTION" = "22" ]; then
			echo connecting to $serverSELECTION...
			ssh $serverSELECTION
			mainMenu
		else
			echo connecting to $serverSELECTION on port $portSELECTION...
			ssh $serverSELECTION -p $portSELECTION
			mainMenu
		fi
}

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                            Advance Menu                            #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

function advanceMenu() {
advanceMenu_selection=$(whiptail --title "Advance Menu" --fb --menu "Advanced Options:" 30 78 20\
			"Auto Start" "Configure SSH Connect to start automatically" \
			"Exit" "Exit Advance Menu" 3>&1 1>&2 2>&3)
		if [ "$advanceMenu_selection" = "Auto Start" ]; then
			AUTOSTART
		elif [ "$advanceMenu_selection" = "Exit" ]; then
			mainMenu	
		fi



}


#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                Configure SSH Connect to autostart                  #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

function AUTOSTART() {
	if grep -Fxq "#_**_#" .bashrc; then
		whiptail --title "Auto Start setup" --fb --msgbox "SSH Connect is already configured for Auto Start." 10 78
		advanceMenu
	else
		echo "" >> ~/.bashrc
		echo "" >> ~/.bashrc
		echo "" >> ~/.bashrc
		echo "#_**_#" >> ~/.bashrc
		echo "#^^ that tag is used by the ssh_connect.sh script.  It should be located in your home directory" >> ~/.bashrc
		echo "#Start ssh_connect.sh when a new shell starts" >> ~/.bashrc
		echo "~/ssh_connect.sh" >> ~/.bashrc
		whiptail --title "Auto Start setup" --fb --msgbox "SSH Connect will now start with every new bash Shell." 10 78
		advanceMenu
	fi
}

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                This section moves the script to the home           #
#                     folder of the current user                     #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

function runningINhome() {
MY_PATH="`dirname \"$0\"`"              # relative
MY_PATH="`( cd \"$MY_PATH\" && pwd )`"  # absolutized and normalized
if [ -z "$MY_PATH" ] ; then
  # error; for some reason, the path is not accessible
  # to the script (e.g. permissions re-evaled after suid)
  exit 1  # fail
fi
if [ $HOME != $MY_PATH ]; then
        moveTOhome
fi

}
#This sill move the script to the home folder of the current user.
function moveTOhome() {
        if (whiptail --title "Move script?" --fb --yesno "The script is designed to be run from your home directory.  Would you like to automatically move it there?" --no-button Exit 11 60 3>&1 1>&2 2>&3); then
        mv $MY_PATH/ssh_connect.sh $HOME
        whiptail --title "Re-Run Script" --fb --msgbox "The script is now located in your home directory:  $HOME" 10 78
        EXIT
        else
        EXIT
fi
}

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                            Exit function                           #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

function EXIT() {
			clear
			echo exiting SSH Connect
			exit
}

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                           Start Function                           #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

function START() {
		## ROOT CHECK ##
		if [[ $EUID -eq 0 ]];then
    		whiptail --title "Running as root" --fb --msgbox "There's no need to run this script as root." --ok-button Exit 10 78
			EXIT
    	fi

    	runningINhome

}



#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                      Initial function calls                        #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

clear
START
mainMenu


#end of script
