nullnull
- I'm Alex! Hellowo.
- Social Media:
	- null
	- null
	- null
	
	

nullnull
- Copy etc.nginx to /etc/nginx on the hosting server. If starting from scratch, these files will need to be updated with certbot.
- Set autoupdate.py to run on boot, to keep the server up to date.
	- Run crontab -e to get to the config file for cron
	- Add @reboot python3 /humanhummusdotcom/autoupdate.py
	- and @reboot sleep 10s && fish /humanhummusdotcom/python_server/exec.fish
	
	
- If you're building the server from scratch, git clone this git repo in the root dir.
- Run python autoupdate.py cl (cl meaning change locally) to update the changelog and re-compile files locally

null
- null
- null
- null
- null
- null
- null
- null
- null
- null
- null
- null

null