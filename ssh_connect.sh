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

#Variables
server1="server1-hostname"
server2="server2-hostname"
server3="server3-hostname"
server4="server4-hostname"
server5="server5-hostname"
server6="server6-hostname"
server7="server7-hostname"
customServer=""
serverSELECTION=""


#MainMenu
					#edit the server description below as needed to match the name of the servers

function mainMenu() {
	serverSELECTION=$(whiptail --title "SSH Connect" --menu "Choose Server to connect to:" 20 65 10 \
		$server1 "|  server1 description" \
		$server2 "|  server2 description" \
		$server3 "|  server3 description" \
		$server4 "|  server4 description" \
		$server5 "|  server5 description" \
		$server6 "|  server6 description" \
		$server7 "|  server7 description" \
		"Custom" "|  Connect to another server" \
		"Exit" "| Exit this script" 3>&1 1>&2 2>&3)

#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*##*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#*#
		
	case $serverSELECTION in
		$server1)
			clear
			echo connecting to $server1...
			ssh $server1
			~/ssh_connect.sh
		;;
		
		$server2)
			clear
			echo connecting to $server2...
			ssh $server2
			~/ssh_connect.sh
		;;

		$server3)
			clear
			echo connecting to $server3...
			ssh $server3
			~/ssh_connect.sh
		;;

		$server4)
			clear
			echo connecting to $server4...
			ssh $server4
			~/ssh_connect.sh
		;;

		$server5)
			clear
			echo connecting to $server5...
			ssh $server5
			~/ssh_connect.sh
		;;

		$server6)
			clear
			echo connecting to $server6...
			ssh $server6
			~/ssh_connect.sh
		;;

		$server7)
			clear
			echo connecting to $server7...
			ssh $server7
			~/ssh_connect.sh
		;;

		Custom)
			customServer=$(whiptail --inputbox "What is the FQDN of the server you want to connect to?" 8 78 --title "Custom server" 3>&1 1>&2 2>&3)
			clear
			echo connecting to $customServer...
			ssh $customServer
			~/ssh_connect.sh
		;;
		
		Exit)
		clear
		echo exiting SSH Connect
		exit
			
	esac

}

#This section actually calls the mainMenu function

clear
mainMenu


#end of script
