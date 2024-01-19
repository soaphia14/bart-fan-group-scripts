#!/bin/bash
# Include admins in authorized users
# SEPARATE BY /
AUTHORIZED_USERS=""
ADMINS=""

IFS='/' read -r -a AUTHORIZED_USERS_ARRAY <<< "$AUTHORIZED_USERS/$ADMINS"
mapfile -t CURRENT_USERS  < <(ls /home)

echo ""
echo "=== DELETE USERS ==="
for user in "${CURRENT_USERS[@]}"; do
  if [[ " ${AUTHORIZED_USERS_ARRAY[*]} " =~ " ${user} " ]]; then
    continue
  else
    echo "DELETING USER: $user"
    sudo deluser $user
  fi
done

echo ""
echo "=== ADD USERS ==="
for user in "${AUTHORIZED_USERS_ARRAY[@]}"; do
  echo "$user"
  if [[ " ${CURRENT_USERS[*]} " =~ " ${user} " ]]; then
    continue
  else
    echo "ADDING USER: $user"
    sudo adduser $user
  fi
done
echo ""
apfile -t CURRENT_ADMINS < <(getent group sudo | awk -F: '{print $4}')
IFS="," read -r -a CURR_ADMINS_ARRAY <<< "$CURRENT_ADMINS"
IFS='/' read -r -a ADMINS_ARRAY <<< "$ADMINS"

echo ""
echo "=== DELETE ADMINS ==="
for user in "${CURR_ADMINS_ARRAY[@]}"; do
  if [[ " ${ADMINS_ARRAY[*]} " =~ " ${user} " ]]; then
    continue
  else
    echo "DELETING FROM ADMIN: $user"
    sudo gpasswd -d $user sudo
  fi
done

echo ""
echo "=== ADD ADMINS ==="
for user in "${ADMINS_ARRAY[@]}"; do
  if [[ " ${CURR_ADMINS_ARRAY[*]} " =~ " ${user} " ]]; then
    continue
  else
    echo "ADDING TO ADMIN: $user"
    sudo usermod -aG sudo $user
  fi
done
echo ""
