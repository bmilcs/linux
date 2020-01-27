# bmilcs: github guide
> #### CREATE *LOCAL* REPO

	cd *
	git init
	git add .
	git commit
		OR git commit -m "x"
	git config --global user.name "bmilcs"
	git config --global user.email bmilcs@yahoo.com
	git push origin master

> #### PUSH LOCAL REPO ONLINE

##### VISIT GITHUB.COM & **CREATE REPO**

	# ssh login
	git remote add origin git@github.com:bmilcs/REPO
	git push -u origin master
	
	# alternative:
	# git remote add origin https://github.com/bmilcs/new_repo

	
