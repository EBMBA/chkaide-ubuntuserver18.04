#! /bin/sh
#chkaide.sh - Bob Aiello, modified for FreeBSD by Samuel Dowling, modified for Ubuntu Server by EBMBA
MYDATE=`date +%Y-%m-%d`
MYFILENAME="Aide-"$MYDATE.txt
UPDATE_NAME="aide_update.txt"
MAIL_ADDRESS="yourEmailAddress"
echo "Aide check !! `date`" > /tmp/$MYFILENAME
aide -c /etc/aide/aide.conf -C > /tmp/myAide.txt
cat /tmp/myAide.txt|/usr/bin/grep -v failed >> /tmp/$MYFILENAME
echo "**************************************" >> /tmp/$MYFILENAME
tail -20 /tmp/myAide.txt >> /tmp/$MYFILENAME
echo "****************DONE******************" >> /tmp/$MYFILENAME
mail -s "$MYFILENAME `date`" $MAIL_ADDRESS < /tmp/$MYFILENAME
aide --update >> /tmp/$UPDATE_NAME
mv /var/lib/aide/aide.db /var/lib/aide/archive/aide-$MYDATE.db
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db