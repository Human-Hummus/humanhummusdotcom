#add to crontab -e: @reboot fish /humanhummusdotcom/python_server/exec.fish
set DIR (cd (dirname (status -f)); and pwd) 
cd "$DIR/drungy_selfie/" && make build
cd "$DIR/chat_main/" && make build
source "$DIR/bin/activate.fish" &&
pip install flask &&
pip install tensorflow &&
python3 "$DIR/server.py"
