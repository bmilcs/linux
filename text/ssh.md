# ssh

## generate & add passkey

	ssh-keygen -t rsa -b 4096 -f ~/.ssh/id_X

## copy public key to target

	ssh-copy-id -i ~/.ssh/id_X user@host

## add private key to ssh-agent

	eval `ssh-agent`
  ssh-add -l
	
	
