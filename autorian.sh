#!/bin/bash
function qq {
"$sqlite" "$db" <<!
.mode csv
.output "$dname/$2.txt"
$1
!
}

csv=$1
users="users.txt"
fname=$2
headers=$(head -n 1 $csv)
echo $headers

sqlite="./sqlite3"
dname="$fname ($(date +%Y%m%d%H%M))"
db="$dname/$fname.db"

mkdir -p "$dname"

"$sqlite" "$db" <<!
drop table videos;
create virtual table videos using fts4($headers);
!

"$sqlite" "$db" <<!
.mode csv
.separator ,
.import $csv videos
!

query="select * from videos where"

shift
shift

for var in "$@"
do
  if [ "$var" != "" ]
  then
  query="$query $var and"
  fi
done

echo "Running queries on users..."
while read line
do
  if [ "$line" != "" ]
  then
  q="$query username match '$line';"
  echo "$q"
  qq "$q" "$line"
  fi
done < $users

"$sqlite" "$db" <<!
drop table videos;
!

cat "$dname"/*.txt > "$dname/merged.csv"
