while true; do
	now=$(date +"%T")
	echo "Current time : $now \n" >> logs.txt
	python dejavu.py -f ./mp3_1000/ mp3 
	sleep 1900;
done
