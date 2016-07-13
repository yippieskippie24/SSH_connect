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


#MainMenu

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
		fi
}

function customServer() {
			customSERVER=$(whiptail --inputbox "What is the FQDN of the server you want to connect to?" 8 78 --title "Custom server" 3>&1 1>&2 2>&3)
			portSELECTION=$(whiptail --inputbox "What port do you want to connect on?" 8 78 22 --title "Select Port" 3>&1 1>&2 2>&3)
			userSELECTION=$(whiptail --inputbox "What user do you want to use to connect?" 8 78 $USER --title "Select User" 3>&1 1>&2 2>&3)
		if [ "$portSELECTION" = "22" ]; then
			echo connecting to $customSERVER...
			ssh $customSERVER -l $userSELECTION
			~/ssh_connect.sh
		else
			echo connecting to $customSERVER on port $portSELECTION...
			ssh $customSERVER -p $portSELECTION -l $userSELECTION
			~/ssh_connect.sh
		fi
}

function advanceMenu() {
			echo "advanced Menu - More features will be added here later"
			sleep 2
			~/ssh_connect.sh
}

function EXIT() {
			clear
			echo exiting SSH Connect
			exit
}

function SSH_connect() {
		if [ "$portSELECTION" = "22" ]; then
			echo connecting to $serverSELECTION...
			ssh $serverSELECTION
			~/ssh_connect.sh
		else
			echo connecting to $serverSELECTION on port $portSELECTION...
			ssh $serverSELECTION -p $portSELECTION
			~/ssh_connect.sh
		fi
}


#This section actually calls the mainMenu function

clear
mainMenu


#end of script
