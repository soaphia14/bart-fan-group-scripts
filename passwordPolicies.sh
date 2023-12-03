echo "BEGIN"
#!/bin/bash
users=$(awk -F: '{ print $1}' /etc/passwd)

for value in $users
do 
      echo $value
      chage -M 60 -m 5 -W 7 $value # max days 60, min days 5, warn age 7
      chage -l $value
      echo "....."
      echo ""
 done
echo "END"
