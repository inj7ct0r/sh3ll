# sh3ll
sh3ll


主要检查市面上留下的pam和openssh后门

pam和openssh后门主要以读写模式打开的

分析所有的WR操作,后门写入密码动作就可以追踪到后门记录文件地址

只检查，没有做查找动作

有的ssh后门可能没有发送密码的操作

在这里说明下,有人说pam后门没安装之前执行rpm检查命令是空白的。

其实不然，只有在所有的包都安装正确的情况下才是没内容的。也就是空白

经过多次测试发现。安装了pam后门都会出现pam_unix.so

写得很粗糙。下一版本争取出个一键发现和查找的!
