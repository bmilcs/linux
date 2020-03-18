# bmilcs: github & visual studio optimization

### SUMMARY

after learning the basics of git, i found commiting changes and pushing them to master, via visual studio code, a tedious process. i created this guide for dummies like myself, simplifying the process of getting content to github with a single hotkey. 

---

### REQUIRED SOFTWARE
- [**visual studio code**](https://code.visualstudio.com/download)
- [**git**](https://git-scm.com/download/win) (default options are fine)

---

### CREATE LOCAL REPO
- open **windows file explorer** 
	- *c:/path/project*
	- right click > **git bash here**

			git init
			git add .
			git commit -m "message"
			git config --global user.name "bmilcs"
			git config --global user.email bmilcs@yahoo.com
			
---

### PASSWORDLESS COMMIT PUSH PULL VIA RSA-SSH

- within **git bash**:

		cd c:/users/bmilcs/
		ssh-keygen -t rsa -b 2048 -C "bmilcs@yahoo.com"
		# enter > enter > enter

- **open windows file explorer**
	- *c:/users/bmilcs/.ssh/*
- right click **id_rsa.pub** 
	- open with > *notepad*
	- select all
	- copy to clipboard
- visit **https://github.com/bmilcs/**
	- click profile icon (top right)
		- settings
	- ssh and gpg keys (left menu) 
		- create new ssh key
		- enter any name
		- paste clipboard
		- save

----

### PUSH LOCAL REPO TO GITHUB
- create a repo on **https://github.com/bmilcs**
- return to git bash:

		# password-less ssh commit/push (recommended)
		git remote add origin git@github.com:bmilcs/REPO
		git push -u origin master
	
				# for non-ssh login (untested)
				# git remote add origin https://github.com/bmilcs/new_repo

----

### VISUAL STUDIO CODE CONFIGURATION

with these tweaks, you can commit & push any changes to github with a single key combo. after revising a script, you can
 follow this workflow:

hotkey | description
---:|:---
ctrl+s| save file
ctrl+alt+enter|commit (with multiple local repos, arrow down to select > enter)
a | message "a" describing commit (unnecessary for my needs)
enter|uploads to github

----

#### SET VISUAL STUDIO HOTKEY

- ctrl+k ctrl+s (or *file > preferences > keyboard shortcuts*)
- search for "git commit all" and set a hotkey (ie: ctrl + alt + enter)

	![commit key](https://i.imgur.com/yAzBook.png)

----

#### VISUAL STUDIO GIT SETTINGS

- ctrl+, (or *file > preferences > settings*)
- expand extensions (list on left side)
- select git & change these settings:

	![code](https://i.imgur.com/jdIwpuI.png)

- make the following changes (yellow line indicates "not default")

	![code](https://i.imgur.com/igUyuyW.png)

	![code](https://i.imgur.com/4V91Kdb.png)

	![code](https://i.imgur.com/KKGBp0D.png)

	![code](https://i.imgur.com/HGnXt7p.png)

	![code](https://i.imgur.com/pMVEcFg.png)
