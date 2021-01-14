## Aster Projects Build
Aster Cloud 世界由这里开始，本项目用于快速构建git项目开发。

### git-build.sh说明
```
操作步骤：
git-build.sh 和 git-project.txt必须在同一个文件夹内；
在git-build.sh文件夹空白处，鼠标右键点击Git Bash Here；
输入命令：sh git-build.sh 或 . git-build.sh；
等待构建完毕；
```

### git-project.txt说明
使用下面的规则，可自己添加要clone的项目

```lua
projects.aster-cloud-build=https://github.com/wangqian-projects/aster-cloud-build.git
KEY第一级：在git-build.sh文件夹内创建目录的变量
KEY第二级：与git项目保持一致
VALUE: git项目地址
```

### host-update.sh说明
用于更新host配置
```
操作步骤：
host-update.sh 和 host.txt必须在同一个文件夹内；
在host-update.sh文件夹空白处，鼠标右键点击Git Bash Here；
输入命令：sh host-update.sh 或 . host-update.sh；
```

### host.txt说明
- 存放项目所需的基本host配置, 本地开发环境使用。
- 遇到系统权限问题脚本执行失败，请手动编辑host配置或执行host-update.sh脚本。