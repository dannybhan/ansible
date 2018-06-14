#!/bin/sh
 
# emtpy the old scanlog and do a virus scan
sudo rm -R /home/clamav/clamav-scan.log
sudo touch /home/clamav/clamav-scan.log
# scan /home via clamdscan (requires clamav-daemon installed) or change to clamscan 
#clamdscan /home/ /etc/ /opt/ --fdpass --log=/home/clamav/clamav-scan.log --infected --multiscan
sudo nice -n 19 clamscan -r /home/ --log=/home/clamav/clamav-scan.log --infected --max-dir-recursion=25
 
### Send the email
sed -i '/Not supported file type/d' /home/clamav/clamav-scan.log
if grep -rl 'Infected files: 0' /home/clamav/clamav-scan.log
then echo "No virus found inside `hostname`."
else cat /home/clamav/clamav-scan.log | mail -s "Virus warning inside `hostname`" it-support@xsb.com 
fi
