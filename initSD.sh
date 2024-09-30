#!/usr/bin/env bash
cat << HERE
Installs Anaconda2 2.4.1
 
     -b           run install in batch mode (without manual intervention),
                  it is expected the license terms are agreed upon
     -f           no error if install prefix already exists
     -h           print this help message and exit
     -p PREFIX    install prefix, defaults to $PREFIX
HERE

SDCARD_PATH=/media/user/bootfs
CONFIG_TXT=config.txt
CMDLINE_TXT=cmdline.txt

# sd카드를 인식한다
function detectSD(){
	#while true;do 
		if [ -d "${SDCARD_PATH}" ];then
			echo "SD카드가 인식되었습니다."	
		fi
		sleep 1
	#done
}
echo before detectSD
detectSD
echo after detectSD
# 파일을 찾는다

# find config.txt, cmdline.txt
function detectCMDLINE(){
	sleep 1
	if [ -f "${SDCARD_PATH}/${CMDLINE_TXT}" ];then
		#echo "cmdline.txt가 발견 되었습니다."	
		echo 0 # find
	else 
		echo 1 # not found
	fi
}

echo "cmdline.txt : `detectCMDLINE`"
IPADDR=192.168.111.1
# cmdline.txt. 파일을 찾는다 
isCMDLINE=`detectCMDLINE`
echo ${isCMDLINE}
if [ $isCMDLINE -eq 0 ];then
	# find 192.168.111.1 & modify
	sed -i "s/111.111.111.111/${IPADDR}/" "${SDCARD_PATH}/${CMDLINE_TXT}"
	if [ $? -eq 0 ];then
		echo "${CMDLINE_TXT} 문서가 수정되었습니다."
	else 
		echo "${CMDLINE_TXT} 문서를 수정하지 못했습니다."
	fi
fi

# 수정완료 log 출력 

#unmount /media/user/bootfs
umount ${SDCARD_PATH}
echo "SDcard is unmounted!"