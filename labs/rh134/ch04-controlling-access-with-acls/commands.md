# ACL Commands Reference

## View ACL
getfacl /opt/acl-lab

## Set Named User ACL
sudo setfacl -m u:kero-user:rwx /opt/acl-lab

## Modify ACL Mask
sudo setfacl -m m::r-x /opt/acl-lab

## Restore Write Permission
sudo setfacl -m m::rwx /opt/acl-lab

## Configure Default ACL
sudo setfacl -m d:u:dev1:r-- /opt/acl-lab

## Verify Inheritance
getfacl /opt/acl-lab/inherited.txt

## Backup ACL
cd /opt
sudo getfacl -R acl-lab > ~/acl-backup.txt

## Remove ACL
sudo setfacl -Rb /opt/acl-lab
sudo setfacl -Rk /opt/acl-lab

## Restore ACL
cd /opt
sudo setfacl --restore="$HOME/acl-backup.txt"
