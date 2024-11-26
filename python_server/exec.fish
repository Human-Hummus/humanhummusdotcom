#add to crontab -e: @reboot fish /humanhummusdotcom/python_server/exec.fish
set DIR (cd (dirname (status -f)); and pwd) 
echo $DIR
cd "$DIR/drungy_selfie/" && make build
cd "$DIR/chat_main/" && make build
source "$DIR/bin/activate.fish" &&
python -m pip install flask &&
python -m pip install tensorflow &&
python3 "$DIR/server.py"
