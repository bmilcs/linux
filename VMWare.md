#vCenter Server Appliance

## Certificate Generation w/ Private.key
  /usr/lib/vmware-vmca/bin/certool --initcsr --privkey=priv.key --pubkey=pub.key --csrfile=csr.csr --config=/usr/lib/vmware-vmca/share/config/certool.cfg
