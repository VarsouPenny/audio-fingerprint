number=$1

rm -rf ./results_${number} ./temp_audio_${number}

python run_tests.py \
	-sec 5 \
	--temp ./temp_audio_${number} \
	--log-file ./results_${number}/dejavu-test.log \
	--padding 5 \
	--seed 42 \
	--results ./results_${number} \
	./mp3_${number}_test

