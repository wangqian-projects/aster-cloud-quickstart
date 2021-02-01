## Aster Cloud Quickstart
Aster Cloud 世界由这里开始，快速构建 aster cloud 项目开发。

### 目录说明
```lua
aster-cloud-quickstart
├── conf
     ├── aster-nacos -- nacos 配置
     ├── aster-seata -- seata 配置
     ├── aster-xxl-job -- xxl-job 配置
     └── host -- hos t配置
├── git-build.sh -- 构建 Aster Cloud 项目
└── git-projects.txt -- 定义要 clone 的项目
```

### 快速开始
#### 步骤1: 克隆 Aster Cloud Quickstart 项目
```
git clone https://github.com/wangqian-projects/aster-cloud-quickstart.git
```

#### 步骤2: 构建 Aster Cloud 项目
```
使用 git-build.sh 脚本快速构建。
Linux: sh git-build.sh 或 . git-build.sh。
Windows: 安装 Git Bash 双击即可。
注意：
 - git-build.sh 和 git-project.txt 必须在同一个文件夹内。
 - git-project.txt 用于定义要clone的项目。
    - KEY第一级：在git-build.sh文件夹内创建目录的变量，
    - KEY第二级：与git项目保持一致
    - VALUE: git项目地址
```
