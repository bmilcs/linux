# bmilcs: raspbian

## sudo user, no pw
**login as root**

	usermod -aG sudo bmilcs
	sudo vi /etc/sudoers.d/010_pi-nopasswd
	bmilcs ALL=(ALL) PASSWD: ALL

## unattended upgrades
**edit 50unattended-upgrades**

most important

	"origin=Raspbian,codename=${distro_codename},label=Raspbian";
	"origin=Raspberry Pi Foundation,codename=${distro_codename},label=Raspberry Pi Foundation";


	Unattended-Upgrade::Origins-Pattern {
			// Codename based matching:
			// This will follow the migration of a release through different
			// archives (e.g. from testing to stable and later oldstable).
	//      "o=Raspbian,n=jessie";
	//      "o=Raspbian,n=jessie-updates";
	//      "o=Raspbian,n=jessie-proposed-updates";
	//      "o=Raspbian,n=jessie,l=Raspbian";

			// Archive or Suite based matching:
			// Note that this will silently match a different release after
			// migration to the specified archive (e.g. testing becomes the
			// new stable).
	//      "o=Raspbian,a=stable";
	//      "o=Raspbian,a=testing";
			"origin=Raspbian,codename=${distro_codename},label=Raspbian";

			// Additionally, for those running Raspbian on a Raspberry Pi,
			// match packages from the Raspberry Pi Foundation as well.
			"origin=Raspberry Pi Foundation,codename=${distro_codename},label=Raspberry Pi Foundation";
	};
