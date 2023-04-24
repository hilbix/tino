# GNOME

Gnome (or more correctly Ubuntu) does not allow you to easily change things as you want.

Here I note what to change and what to do for me.


## Settings

	gsettings set org.gnome.desktop.session idle-delay $[3600 * 4]

- I like the screen idle timeout to be a bit longer, as 15 minutes is way too short.

### Additional notes

	gsettings set org.gnome.desktop.screensaver lock-delay 60
	gsettings set org.gnome.desktop.screensaver lock-enabled true

- Lock screen 60 seconds after it has been blanked

