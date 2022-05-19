#	$BASE style.c,v 0.0 2021/07/07 03:50:30 moatx Exp $		

#!/bin/sh

FILESIZE="$(wc -c < "$1" | tr -d "")"

[ "$FILESIZE" -eq 509 ] && {
  echo "limit reached: $FILESIZE bytes" 
  exit
}

printf %$((FILESIZE - 510))s | tr " " "\0" >> "$1"
printf "\x55\xAA" >> "$1"

echo "SIZE: $FILESIZE (limit 509) "
