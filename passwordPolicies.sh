echo "BEGIN"
#!/bin/bash
users=$(awk -F: '{ print $1}' /etc/passwd)

for value in $users
do 
      echo $value
      chage -l $value
      echo "....."
      echo ""
 done
echo "END"
