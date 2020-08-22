@echo off

::设置密码pw
set pw=abc123

::获取当前日期时间regfile
set hour=%time:~,2%
if "%time:~,1%"==" " set hour=0%time:~1,1%
set regfile=%date:~0,4%-%date:~5,2%-%date:~8,2% %hour%：%time:~3,2%：%time:~6,2%

::获取当前文件夹名称dd
set dd=%cd%
:a
if not "%dd:\=%"=="%dd%" set dd=%dd:*\=%&goto a

@echo on

::压缩当前文件夹中除7z文件外的其他文件到“备份”文件夹（32位操作系统）（和下面的命令只有其一能执行。）
@"C:\Program Files\7-Zip\7z.exe" a ".\备份\%dd% %regfile%.7z" -x!*.7z -x!备份 -p%pw%
::               7z命令位置                 添加      目标文件名            排除7z文件 排除文件夹 添加密码

::压缩当前文件夹中除7z文件外的其他文件到“备份”文件夹（64位操作系统）（和上面的命令只有其一能执行。）
@"C:\Program Files (x86)\7-Zip\7z.exe" a ".\备份\%dd% %regfile%.7z" -x!*.7z -x!备份 -p%pw%
::                7z命令位置                        添加      目标文件名           排除7z文件 排除文件夹 添加密码

::备份当前目录中“备份”文件夹中的内容到指定目录中，只备份不重复的文件。
xcopy .\备份\*.* D:\备份\ /D /S 

exit