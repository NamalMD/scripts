#!/bin/bash

DB_HOST="localhost"
DB_PORT="3306"
DB_USER="root"
DB_PASS="Omnibis.123"
DB_NAME="test_230228"


dummy_data=(
  "here are many variations of passages of Lorem Ipsum available,"
  "but the majority have suffered"
  "alteration in some form"
  "by injected humour"
  "or randomised words which dont look even slightly believable."
  "If you are going to use a passage of Lorem Ipsum"
  "you need to be sure there isnt anything embarrassing"
  "hidden in the middle of text. All the Lorem Ipsum generators on the,"
  "Internet tend to repeat predefined chunks as necessary,"
  "making this the first true generator on the Internet.,"
  "It uses a dictionary of over 200 Latin words, combined with,"
  "a handful of model sentence structures, to generate Lorem Ipsum,"
  "which looks reasonable. The generated Lorem Ipsum is therefore,"
  "always free from repetition, injected humour, or non-characteristic words etc.,"
  "here are many variations of passages of Lorem Ipsum available,"
  "but the majority have suffered,"
  "alteration in some form, by injected humour,"
  "or randomised words which dont look even slightly believable. ,"
  "If you are going to use a passage of Lorem Ipsum,"
)
		 
text_count=${#dummy_data[@]}

getTableSize=$(mysql --host=$DB_HOST --port=$DB_PORT --user=$DB_USER --password=$DB_PASS --database=$DB_NAME --execute="SELECT table_name AS \`Table\`, ROUND((data_length + index_length) /1024 / 1024 / 1024, 2) AS \`Size in GB\` FROM information_schema.TABLES WHERE table_schema = 'test_230228' AND table_name = 'junk_table';"| awk 'NR>1{print $2}'| tr -d '[:alpha:][:space:][:punct:]')

while [[ "$getTableSize" -lt 60 ]]

do
random_text1=$((RANDOM%text_count))
random_text2=$((RANDOM%text_count))
random_text3=$((RANDOM%text_count))
random_text4=$((RANDOM%text_count))
random_text5=$((RANDOM%text_count))
random_text6=$((RANDOM%text_count))

name=${dummy_data[random_text1]}
junk1=${dummy_data[random_text2]}
junk2=${dummy_data[random_text3]}
junk3=${dummy_data[random_text4]}
junk4=${dummy_data[random_text5]}
junk5=${dummy_data[random_text6]}


insertDataQuery="INSERT INTO junk_table (name, junk1, junk2, junk3, junk4, junk5) VALUES ('$name','$junk1','$junk2','$junk3','$junk4','$junk5');"



#getTableSize=$(mysql --host=$DB_HOST --port=$DB_PORT --user=$DB_USER --password=$DB_PASS --database=$DB_NAME --execute="SELECT table_name AS \`Table\`, ROUND((data_length + index_length) /1024 / 1024 / 1024, 2) AS \`Size in GB\` FROM information_schema.TABLES WHERE table_schema = 'test_230228' AND table_name = 'junk_table';"| awk 'NR>1{print $2}'| tr -d '[:alpha:][:space:][:punct:]')

 if [[ "$getTableSize" -lt 60 ]]
	then 
	mysql --host=$DB_HOST --port=$DB_PORT --user=$DB_USER --password=$DB_PASS --database=$DB_NAME --execute="$insertDataQuery;"
	sleep 1
	
	if [[ $getTableSize%10 == 0 || $getTableSize%5 == 0 ]]
	then
	echo "Table_SIZE=$getTableSize"
	fi
 else
	echo "the Table size is 60GB now"
 fi
 
done
