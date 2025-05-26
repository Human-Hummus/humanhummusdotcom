
### This is my website, with info, games, demos, and more! Welcome!

## About me:

- I'm Alex! Hellowo.
- Social Media:
	- [GitHub](https://github.com/Human-Hummus/)
	- [YouTube](https://www.youtube.com/@human\_hummus6175)
	- [E-mail me!](mailto:michael.a.deross@gmail.com)
	
	


## About This Site:


www.HumanHummus.com is meant to be my personal website (generally) where I host projects, ideas and my portfolio, and talk about my life. One thing you should probably know about this website is that while I make ALL of the code (unless explicitly stated otherwise), most of the assets currently present are not mine; They're made by my (best UwU) friend, [SoundHaptics](https://www.instagram.com/soun.dhaptics/) You can view [the source code for the website on GitHub](https://github.com/Human-Hummus/humanhummusdotcom/tree/main) (if you aren't already!). Also visit [The HumanHummus Wiki](https://sites.google.com/view/official-humanhummus-wiki/home), created by SoundHaptics.


# Misc. tech info:

## Software used on the server

- [NGiNX](https://nginx.org/en/)
- [Neovim](https://neovim.io/)
- [Fish Shell](https://fishshell.com/)
- [cron](https://en.wikipedia.org/wiki/Cron)
- [Arch Linux](https://archlinux.org/)
- [git](https://git-scm.com/)
- [btop](https://github.com/aristocratos/btop)
- [Python](https://www.python.org/)
- [certbot](https://certbot.eff.org/)
- [FFmpeg](https://ffmpeg.org/)
- [espeak-ng](https://github.com/espeak-ng/espeak-ng/)


## Installing/running the server

- Copy etc.nginx to /etc/nginx on the hosting server. If starting from scratch, these files will need to be updated with certbot.
- Set autoupdate.py to run on boot, to keep the server up to date.
	- Run crontab -e to get to the config file for cron
	- Add @reboot python3 /humanhummusdotcom/autoupdate.py
	- and @reboot sleep 10s && fish /humanhummusdotcom/python\_server/exec.fish
	
	
- If you're building the server from scratch, git clone this git repo in the root dir.
- Run python autoupdate.py cl (cl meaning change locally) to update the changelog and re-compile files locally



If you're reading this on GitHub, and think it's strange I'd show my social media here, remember that this readme is shown on the main page of the site.

