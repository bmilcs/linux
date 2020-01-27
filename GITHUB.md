# bmilcs: github & vscode on windows 

### REQUIRED SOFTWARE
- [**visual studio code**](https://code.visualstudio.com/download)
- [**git**](https://git-scm.com/download/win) (default options are fine)

### CREATE LOCAL REPO
	# mkdir C:/path/project (if you don't have one with existing content already)
	# goto C:/path/project within file explorer
	#	right click > "GIT BASH HERE"
	# or open git bash software and:

	cd C:/path/project
	git init
	git add .
	git commit -m "message"
	git config --global user.name "bmilcs"
	git config --global user.email bmilcs@yahoo.com
	git push origin master

### RSA-SSH KEY PASSWORDLESS LOGIN (WINDOWS)
	cd c:/users/bmilcs/
	ssh-keygen -t rsa -b 2048 -C "bmilcs@yahoo.com"
	# hit enter 3x

	copy contents of id_rsa.pub
	# file explorer > c:/users/bmilcs/.ssh/id_rsa.pub
	# right click > open with > notepad > select all > copy 
	
	visit github.com/bmilcs/ and save my pub key.
	# profile icon (top right) > settings
	# ssh and gpg keys (left menu) 
	# create new ssh key, paste & save

#### PUSH LOCAL REPO TO GITHUB
 	1. goto github.com
	2. create repo 

	# password-less ssh commit/push (recommended)
	git remote add origin git@github.com:bmilcs/REPO
	git push -u origin master
	
	#### non-ssh login (untested)
	#### git remote add origin https://github.com/bmilcs/new_repo

#### VS CODE SETUP
with these settings, you can commit & push any changes to github with a single key combo.

for example, i make changes to a file and then follow this workflow:

	ctrl+s 					# save file to disk
	ctrl+alt+enter			# commit all
							# with multiple repos, i arrow down to correct one & hit enter
	a 						# message describing commit (unnecessary for what i use github for)
	enter					# done. visit my page to view changes.

#1 **create hotkey**
- ctrl+k ctrl+s (or *file > preferences > keyboard shortcuts*)
- search for "git commit all" and set a hotkey (ie: ctrl + alt + enter)

	![commit key](https://i.imgur.com/yAzBook.png)

#2 **make commit/push easier:**
- ctrl+, (or *file > preferences > settings*
- expand extensions (list on left side)
- select git & change these settings:

	![code](https://i.imgur.com/jdIwpuI.png)

- make the following changes (yellow line indicates "not default")

	![code](https://i.imgur.com/igUyuyW.png)

	![code](https://i.imgur.com/4V91Kdb.png)

	![code](https://i.imgur.com/KKGBp0D.png)

	![code](https://i.imgur.com/HGnXt7p.png)
	
	![code](https://i.imgur.com/pMVEcFg.png)
