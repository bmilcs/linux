## NEW REPO, EXISTING/NEW FOLDER

	#--- local changes -------------------------------------#
	cd *
	git init
	git add .
	git commit
		OR git commit -m "x"
	git config --global user.name "bmilcs"
	git config --global user.email bmilcs@yahoo.com
	git push origin master

## PUSH TO GITHUB.COM
1. login github.com & **create repo**

	#--- upload to github ---------------------------------#
	# ssh login - passwordless
	git remote add origin git@github.com:bmilcs/REPO 
	git push -u origin master
	
	# alternative:
	# git remote add origin https://github.com/bmilcs/new_repo

	
