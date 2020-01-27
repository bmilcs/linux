# bmilcs: github & vscode on windows 

>#### INSTALL SOFTWARE
- [**visual studio code**](https://code.visualstudio.com/download)
- [**git**](https://git-scm.com/download/win) (default options are fine)

>#### CREATE LOCAL REPO
	# mkdir C:/path/project (if you don't have one with existing content already)
	# goto C:/path/project within File Explorer
	# 	right click > open git bash in project folder 
	# OR open git bash software AND:
	
	cd C:/path/project
	git init
	git add .
	git commit -m "message"
	git config --global user.name "bmilcs"
	git config --global user.email bmilcs@yahoo.com
	git push origin master

> #### RSA-SSH KEY PASSWORDLESS LOGIN (WINDOWS)
	cd c:/users/bmilcs/
	ssh-keygen -t rsa -b 2048 -C "bmilcs@yahoo.com"
	# enter 3x

	# id_rsa.pub > notepad > copy code

	# github.com/bmilcs/
		# profile icon (top right)
		# settings
		# ssh and gpg keys (left menu)
		# create new ssh key, paste & save

>#### PUSH LOCAL REPO ONLINE
 	# 1. goto github.com
	# 2. create repo 

	# ssh password-less login
	git remote add origin git@github.com:bmilcs/REPO
	git push -u origin master
	
		# non-ssh login
		# git remote add origin https://github.com/bmilcs/new_repo

> #### VS CODE SETUP

**create hotkey**
- ctrl+k ctrl+s (*file > preferences > keyboard shortcuts*)
- search for "git commit all" and set a hotkey (ie: ctrl + alt + enter)

	![commit key](https://i.imgur.com/yAzBook.png)

**make commit/push easier:**

changing the following settings allows you to commit & push in seconds:

	ctrl + alt + enter
		* if multiple repos present, arrow down to select it & hit enter
	input message (ie: "did stuff")
	enter

![code](https://i.imgur.com/KKGBp0D.png)
![code](https://i.imgur.com/HGnXt7p.png)
![code](https://i.imgur.com/igUyuyW.png)
![code](https://i.imgur.com/4V91Kdb.png)
![code](https://i.imgur.com/pMVEcFg.png)
