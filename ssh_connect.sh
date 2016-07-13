#!/bin/bash

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                                                         #
#                  SSH Connect Script                     #
#                                                         #
#    This script will allow you to quickly connect        #
#      to internal servers through a SSH jumpbox.         #
#                                                         #
#              Written by:  Tyler M Johnson               #
#                         7/11/16                         #
#         https://github.com/yippieskippie24              #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

#*#*#*#*#*#*#*#*#   Setup instructions    #*#*#*#*#*#*#*#*#
# This script is written with the assumption that it      #
# resides in the home folder of the user that runs it.    #
# You will need to set the names of the variables         #
# below to the FQDNs of the servers you want to be        #
# accessible in this script.  You can edit the server     #
# descriptions as needed below.                           #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#

#editable Variables
server1="server1-hostname"
server1_desc="server1-descritpion"

server2="server2-hostname"
server2_desc="server2-description"

server3="server3-hostname"
server3_desc="server3-description"

server4="server4-hostname"
server4_desc="server4-description"

server5="server5-hostname"
server5_desc="server5-description"

server6="server6-hostname"
server6_desc="server6-description"

server7="server7-hostname"
server7_desc="server7-description"


#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
#                                                                    #
#                 Do not edit below this section                     #
#                                                                    #
#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#


#static variables

customServer=""
serverSELECTION=""


#MainMenu

function mainMenu() {
	serverSELECTION=$(whiptail --title "SSH Connect" --menu "Choose Server to connect to:" 20 65 10 \
		$server1 $server1_desc \
		$server2 $server2_desc \
		$server3 $server3_desc \
		$server4 $server4_desc \
		$server5 $server5_desc \
		$server6 $server6_desc \
		$server7 $server7_desc \
		"Custom" "|  Connect to another server" \
		"Advanced" "|  Advanced Menu" \
		"Exit" "| Exit this script" 3>&1 1>&2 2>&3)

	if [ "$serverSELECTION" = "Custom" ]; then
			customServer=$(whiptail --inputbox "What is the FQDN of the server you want to connect to?" 8 78 --title "Custom server" 3>&1 1>&2 2>&3)
			clear
			echo connecting to $customServer...
			ssh $customServer
			~/ssh_connect.sh

		elif [ "$serverSELECTION" = "Advanced" ]; then
			echo advanced Menu
			sleep 10
			~/ssh_connect.sh

		elif [ "$serverSELECTION" = "Exit" ]; then
			clear
			echo exiting SSH Connect
			exit

		else
			echo connecting to $serverSELECTION...
			ssh $serverSELECTION
			~/ssh_connect.sh

	fi
}

#This section actually calls the mainMenu function

clear
mainMenu


#end of script
