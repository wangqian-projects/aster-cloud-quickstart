#!/bin/bash
# fileName: git-build
# verion: 1.0.0.RELEASE
# author:wangqian
# use build the git projects

function printLog_() {
	echo "$1"
}

printLog_ "                                                                        "
printLog_ "    _______ __     ____        _ __    __                               "
printLog_ "   / ____(_) /_   / __ )__  __(_) /___/ /                               "
printLog_ "  / / __/ / __/  / __  / / / / / / __  /                                "
printLog_ " / /_/ / / /_   / /_/ / /_/ / / / /_/ /                                 "
printLog_ " \____/_/\__/  /_____/\__,_/_/_/\__,_/                                  "
printLog_ " =======================================                                "
printLog_ "  :: Git Build ::      (v1.0.0.RELEASE)                                 "
printLog_ "  Author: WangQian                                                      "
printLog_ "                                                                        "
printLog_ "build start: $(date +%Y-%m-%d\ %H:%M:%S)"

# 更新本项目
git pull

# 创建文件目录函数
function mkdir_(){
	if [ ! -d $1  ];then
		mkdir $1
		printLog_ "mkdir $1 successfully"
	else
		printLog_ "dir $1 is exist"
	fi
}

# clone git 项目函数
failCount=0
tempLog=$(mktemp -u)
function gitClone_(){
	cd $1
	# 执行clone
	$(git clone $2) >"${tempLog}" 2>/dev/null

	# 执行结果
	# if [[ -z $(cat "${tempLog}") ]]; then
    	# echo " Please check the git-projects.txt. "
  	# fi
  	# if [[ $(cat "${tempLog}") =~ "true" ]]; then
    # 	printLog_ "git clone $2 successfully"
  	# else
    # 	printLog_ "git clone $2 failure"
    # 	(( failCount++ ))
 	# fi
	cd ..
}

count=0
for line in $(cat git-projects.txt | sed s/[[:space:]]//g); do
  (( count++ ))
  directory=${line%%.*}
  value=${line#*=}
  # 创建文件目录
  mkdir_ $directory
  # clone git 项目
  gitClone_ $directory $value
done

printLog_ "========================================================================="
printLog_ " Complete build projects,  total-count:$count ,  failure-count:$failCount "
printLog_ "========================================================================="

if [[ ${failCount} -eq 0 ]]; then
  printLog_ " projects build finished. "
else
  printLog_ " Please check the git-projects.txt. "
fi



