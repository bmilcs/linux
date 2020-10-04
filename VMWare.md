## VMware ESXI

### Updating ESXI Hypervisor via SSH

  # update esxi 1-liner
  esxcli software vib update -d https://hostupdate.vmware.com/software/VUM/PRODUCTION/main/vmw-depot-index.xml


### ISCSI Datastore Missing After Reboot

 esxcli storage vmfs snapshot list
 esxcfg-volume -M 


## vCenter Server Appliance

### Certificate Generation w/ Private.key
  
  /usr/lib/vmware-vmca/bin/certool --initcsr --privkey=priv.key --pubkey=pub.key --csrfile=csr.csr --config=/usr/lib/vmware-vmca/share/config/certool.cfg

