# bmilcs: github guide
>#### CREATE *LOCAL* REPO
	cd *
	git init
	git add .
	git commit
		OR git commit -m "x"
	git config --global user.name "bmilcs"
	git config --global user.email bmilcs@yahoo.com
	git push origin master

>#### PUSH LOCAL REPO ONLINE

	# 1. GOTO GITHUB.COM
	# 2. CREATE REPO 

	# ssh login
	git remote add origin git@github.com:bmilcs/REPO
	git push -u origin master
	
		# non-ssh login
		# git remote add origin https://github.com/bmilcs/new_repo

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

> #### VS CODE:

**create hotkey**
- ctrl+k ctrl+s (*file > preferences > keyboard shortcuts*)
- create hotkey  for "git commit all" (ie: ctrl + alt + enter)
	![commit key](https://i.imgur.com/yAzBook.png)

**make commit/push easier:**

changing the following settings allows you to commit & push in seconds:

	ctrl + alt + enter
	select repo (if  mulitple present)
	type note describing commit (ie: "did stuff")
	enter


![code](https://i.imgur.com/KKGBp0D.png)
![code](https://i.imgur.com/HGnXt7p.png)
![code](https://i.imgur.com/igUyuyW.png)
![code](https://i.imgur.com/4V91Kdb.png)
![code](https://i.imgur.com/pMVEcFg.png)
