![Website icon](favicon.jpg)

My website, with information, games, demos, and more!

You can view [the source code for the website on GitHub](https://github.com/Human-Hummus/humanhummusdotcom/tree/main) (if you aren't already!).
On these pages, you can view the source code for the games and demos too.

About me:

-   My name is Alex. Hello!
-   Social Media & Contact
    -   [My GitHub account](https://github.com/Human-Hummus/)
    -   [My YouTube channel](https://www.youtube.com/@human_hummus6175)
    -   [E-mail me](mailto:michael.a.deross@gmail.com)

### Misc. Tech Info:

-   copy etc.nginx to /etc/nginx on the host server
-   add autoupdate.sh to run on boot, to keep the server up to date.
    -   `crontab -e` to get to the config file and add 
        - `@reboot python3 /humanhummusdotcom/autoupdate.py`
        - `@reboot python3 /humanhummusdotcom/python_server/server.py`
-   **if building the server from scratch, the /etc/nginx files _will_ be invalid; be sure to update them**
-   this folder should be at /humanhummusdotcom
-   if you want to host this website locally, just cd into the directory and run `python3 -m http.server`
-   Run `python3 autoupdate.py cl` to update the changelog locally.

Software used on the server:

-   [NGiNX](https://nginx.org/en/)
-   [Neovim](https://neovim.io/)
-   [Fish](https://fishshell.com/)
-   [cron](https://en.wikipedia.org/wiki/Cron)
-   [Debian](https://www.debian.org/)
-   [git](https://git-scm.com/)
-   [btop](https://github.com/aristocratos/btop)
-   [Python](https://www.python.org/)
-   [certbot](https://certbot.eff.org/)

If you're reading this on GitHub, and think it's strange I'd show my social media here, remember that this readme is shown on the main page of the site.
