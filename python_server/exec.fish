#add to crontab -e: @reboot fish /humanhummusdotcom/python_server/exec.fish
source /humanhummusdotcom/python_server/bin/activate.fish
python3 /humanhummusdotcom/python_server/server.py
