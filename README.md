# The HumanHummus.com website source code!
![Website icon](favicon.jpg)


My personal website, with information, games, demos, and more!

You can view [the source code for the website on GitHub](https://github.com/Human-Hummus/humanhummusdotcom/tree/main) (if you aren't already!).
On these pages, you can view the source code for the games and demos as well.

About me:
- My name is Alex. Hello!
- Social Media & Contact
    - [My GitHub account](https://github.com/Human-Hummus/)
    - [My YouTube channel](https://www.youtube.com/@human_hummus6175)
    - [E-mail me](mailto:michael.a.deross@gmail.com)


### Misc. Tech Info:
- copy etc.nginx to /etc/nginx on the host server
- add autoupdate.sh to run on boot, to keep the server up to date.
    - `chrontab -e` to get to the config file
    - add `@reboot sh /humanhummusdotcom/autoupdate.sh`
- **if building the server from scratch, the /etc/nginx files *will* be invalid; be sure to update them**
- this folder should be at /humanhummusdotcom
- if you want to host this website locally, just cd into the directory and run `python3 -m http.server`

Software used on the server:
- [NGiNX](https://nginx.org/en/)
- [Neovim](https://neovim.io/)
- [Fish](https://fishshell.com/)
- [cron](https://en.wikipedia.org/wiki/Cron)
- [debian](https://www.debian.org/)
- [git](https://git-scm.com/)
- [btop](https://github.com/aristocratos/btop)
