#! /bin/sh
#chkaide.sh - Bob Aiello, modified for FreeBSD by Samuel Dowling, modified for Ubuntu Server by EBMBA
MYDATE=`date +%Y-%m-%d`
MYFILENAME="Aide-"$MYDATE.txt
MYFILENAMEERROR="Aide-Error"$MYDATE.txt
UPDATE_NAME="aide_update.txt"
MAIL_ADDRESS="yourEmailAddress"
echo "Aide check !! `date`" > /tmp/$MYFILENAME
echo "Errors of Aide check !! `date`" > /tmp/$MYFILENAMEERROR
aide -c /etc/aide/aide.conf -C > /tmp/myAide.txt
cat /tmp/myAide.txt|grep failed >> /tmp/$MYFILENAMEERROR
cat /tmp/myAide.txt|grep --invert-match failed >> /tmp/$MYFILENAME
echo "**************************************" >> /tmp/$MYFILENAME
echo "**************************************" >> /tmp/$MYFILENAMEERROR
tail -20 /tmp/myAide.txt >> /tmp/$MYFILENAME
tail -20 /tmp/myAide.txt >> /tmp/$MYFILENAMEERROR
echo "****************DONE******************" >> /tmp/$MYFILENAME
echo "****************DONE******************" >> /tmp/$MYFILENAMEERROR
mail -s "$MYFILENAME `date`" $MAIL_ADDRESS < /tmp/$MYFILENAME
mail -s "$MYFILENAMEERROR `date`" $MAIL_ADDRESS < /tmp/$MYFILENAMEERROR
aide --update >> /tmp/$UPDATE_NAME
mv /var/lib/aide/aide.db /var/lib/aide/archive/aide-$MYDATE.db
mv /var/lib/aide/aide.db.new /var/lib/aide/aide.db
