#!/bin/bash

###########################################################
#                                                         #
#                  SSH Connect Script                     #
#                                                         #
#    This script will allow you to quickly connect        #
#      to internal servers through a SSH jumpbox.         #
#                                                         #
#              Written by:  Tyler M Johnson               #
#         https://github.com/yippieskippie24              #
###########################################################



#Variables
server1="webserver"
server2="plex"
server3="server3-hostname"
server4="server4-hostname"
server5="server5-hostname"
server6="server6-hostname"
server7="server7-hostname"
customServer=""
serverSELECTION=""



#MainMenu

function mainMenu() {
	serverSELECTION=$(whiptail --title "SSH Connect" --menu "Choose Server to connect to:" 20 65 10 \
		$server1 "|  server1 description" \
		$server2 "|  server2 description" \
		$server3 "|  server3 description" \
		$server4 "|  server4 description" \
		$server5 "|  server5 description" \
		$server6 "|  server6 description" \
		$server7 "|  server7 description" \
		"Custom" "|  Connect to another server" 3>&1 1>&2 2>&3)
		
	case $serverSELECTION in
		$server1)
			echo connecting to $server1...
			ssh $server1
		;;
		
		$server2)
			echo connecting to $server2...
			ssh $server2
		;;

		$server3)
			echo connecting to $server3...
			ssh $server3
		;;

		$server4)
			echo connecting to $server4...
			ssh $server4
		;;

		$server5)
			echo connecting to $server5...
			ssh $server5
		;;

		$server6)
			echo connecting to $server6...
			ssh $server6
		;;

		$server7)
			echo connecting to $server7...
			ssh $server7
		;;

		Custom)
			customServer=$(whiptail --inputbox "What is the FQDN of the server you want to connect to?" 8 78 --title "Custom server" 3>&1 1>&2 2>&3)
			echo connecting to $customServer...
			ssh $customServer

	esac

}

#call function

mainMenu