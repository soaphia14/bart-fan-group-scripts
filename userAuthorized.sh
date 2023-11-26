#!/bin/bash
# ONLY IF THE USER IS AUTHORIZED OR NOT
# NOTHING ABOUT ADDING OR ADMINS!!
AUTHORIZED_USERS="BUFFER_BEGINNING

BUFFER_END" # separate with "/"

IFS='/' read -r -a AUTHORIZED_USERS_ARRAY <<< "$AUTHORIZED_USERS"
mapfile -t CURRENT_USERS  < <(ls /home)

for user in "${CURRENT_USERS[@]}"; do
  echo "USER: $user"
  if [[ " ${AUTHORIZED_USERS_ARRAY[*]} " =~ " ${item} " ]]; then
    echo "YES - should be here"
  else
    echo "NO - shouldn't be here (check, then delete)"
  fi
  echo ""
done
