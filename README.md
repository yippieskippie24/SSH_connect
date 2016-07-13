#SSH_connect

SSH_connect is a bash script that I've designed to assist you in quickly opening up SSH connections from a jumpbox to internal servers.


YOU --->  JUMPBOX ---> INTERNAL SERVERS


The idea is you can quickly log into any server via SSH by first logging into your jumpbox.  Once there it's a quick selection to any number of servers you have configured in the script.  Currently the base script is up and functional with the following features:

* Setup static servers to connect to
* Ability to specify a custom port to connect via SSH
* In addition to static server entries you have the option to connect to a custom server (including port selection)


The following features are planned:

* If running as root, recommend to not be root
* Check if script is started automatically by new bash prompt, prompt to add if it's not
* Add option to run from every new bash shell or only from SSH connected bash shell
* Aheck if SSH is installed, prompt to install if it's not
* Areate a first run function that does a few checks and prompts to setup script. Can be re-run from advanced menu
* Auto prompt to add SSH key to destination server if enabled
* Add logging. Specifically to log timestamps for connections made. Also error logging.


Script by:  Tyler M Johnson
https://github.com/yippieskippie24
