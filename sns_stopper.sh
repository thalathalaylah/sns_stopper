#!/bin/sh

init () {
  sh dnsmasq/init.sh
}

forbid () {
  sh dnsmasq/forbid.sh
  sh app/forbid.sh
}

permit () {
  sh dnsmasq/permit.sh
  sh app/permit.sh
}

if [ "$UID" -ne 0 ]; then
  echo '[error] sns_stopper requires root privilege.'
  exit 1
fi

if [ $# != 1 -a $# != 2 ]; then
  echo 'Usage  : ./sns_stopper <forbid or permit> [permit minutes]'
  echo 'example: ./sns_stopper permit 10'
  echo 'note   : permit minutes is available when first argument is permit.'
  echo '         permit minutes accepts number or "nolimit"'
  echo '         default permit minutes is 5'
  exit 0
fi

if [ $1 = "forbid" ]; then
  if [ $# != 2 ]; then
    forbid
  else
    echo "[error] forbid can't use permit minutes."
    exit 1
  fi
elif [ $1 = "permit" ]; then
  if [ $# = 1 ]; then
    SEC=`expr 5 \* 60`
  else
    expr $2 + 1 > /dev/null 2>&1
    if [ $? = 0 -o $? = 1 ]; then
      SEC=`expr $2 \* 60`
    elif [ $2 = "nolimit" ]; then
      permit
      exit 0
    else
      echo '[error] permit minutes accepts number or "nolimit"'
      exit 1
    fi
  fi

  permit
  echo "wait ${SEC} sec"
  sleep ${SEC}
  forbid

else
  echo '[error] first argument requires "forbid" or "permit"'
fi
