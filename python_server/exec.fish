#add to crontab -e: @reboot fish /humanhummusdotcom/python_server/exec.fish
cd /humanhummusdotcom/python_server/drungy_selfie/ && make build
source /humanhummusdotcom/python_server/bin/activate.fish
python3 /humanhummusdotcom/python_server/server.py
