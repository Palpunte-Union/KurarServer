@echo off
if not exist "temp\." mkdir temp
cd temp
if not exist "%CD%\src\main\resources\version.json" (
	bitsadmin /transfer download https://github.com/MinecraftForge/MCPConfig/archive/refs/heads/master.zip %CD%\master.zip
	powershell Expand-Archive -Path %CD%\master.zip
	cd master
	call gradlew 1.16.5:projectServerApplyPatches
	cd ..
	xcopy "%CD%\master\versions\release\1.16.5\projects\server" "%CD%\server\"
	xcopy "%CD%\master\versions\release\1.16.5\projects\shared" "%CD%\server\"
	xcopy "%CD%\master\build\versions\1.16.5\server.extra.jar" "%CD%\server-extra.zip"
	powershell Expand-Archive -Path %CD%\server-extra.zip
	cd ..
	mkdir src\main\java src\main\resources
	xcopy "%CD%\temp\server\" "%CD%\src\main\java\"
	xcopy "%CD%\temp\server-extra\log4j2.xml" "%CD%\src\main\resources\log4j2.xml"
	xcopy "%CD%\temp\server-extra\pack.mcmeta" "%CD%\src\main\resources\pack.mcmeta"
	xcopy "%CD%\temp\server-extra\version.json" "%CD%\src\main\resources\version.json"
	xcopy "%CD%\temp\server-extra\assets\" "%CD%\src\main\resources\assets\"
	xcopy "%CD%\temp\server-extra\data\" "%CD%\src\main\resources\data\"

	cd libs\
	bitsadmin /transfer download https://libraries.minecraft.net/com/mojang/patchy/1.1/patchy-1.1.jar %CD%\patchy-1.1.jar
	bitsadmin /transfer download https://libraries.minecraft.net/oshi-project/oshi-core/1.1/oshi-core-1.1.jar %CD%\oshi-core-1.1.jar
	bitsadmin /transfer download https://libraries.minecraft.net/net/java/dev/jna/jna/4.4.0/jna-4.4.0.jar %CD%\jna-4.0.0.jar
	bitsadmin /transfer download https://libraries.minecraft.net/net/java/dev/jna/platform/3.4.0/platform-3.4.0.jar %CD%\platform-3.4.0.jar
	bitsadmin /transfer download https://libraries.minecraft.net/com/mojang/javabridge/1.0.22/javabridge-1.0.22.jar %CD%\javabridge-1.0.22.jar
	bitsadmin /transfer download https://libraries.minecraft.net/net/sf/jopt-simple/jopt-simple/5.0.3/jopt-simple-5.0.3.jar %CD%\jopt-simple-5.0.3.jar
	bitsadmin /transfer download https://libraries.minecraft.net/io/netty/netty-all/4.1.25.Final/netty-all-4.1.25.Final.jar %CD%\netty-all-4.1.25.Final.jar
	bitsadmin /transfer download https://libraries.minecraft.net/com/google/guava/guava/21.0/guava-21.0.jar %CD%\guava-21.0.jar
	bitsadmin /transfer download https://libraries.minecraft.net/org/apache/commons/commons-lang3/3.5/commons-lang3-3.5.jar %CD%\commons-lang3-3.5.jar
	bitsadmin /transfer download https://libraries.minecraft.net/commons-io/commons-io/2.5/commons-io-2.5.jar %CD%\commons-io-2.5.jar
	bitsadmin /transfer download https://libraries.minecraft.net/com/mojang/brigadier/1.0.17/brigadier-1.0.17.jar %CD%\brigadier-1.0.17.jar
	bitsadmin /transfer download https://libraries.minecraft.net/com/mojang/datafixerupper/4.0.26/datafixerupper-4.0.26.jar %CD%\datafixerupper-4.0.26.jar
	bitsadmin /transfer download https://libraries.minecraft.net/com/google/code/gson/gson/2.8.0/gson-2.8.0.jar %CD%\gson-2.8.0.jar
	bitsadmin /transfer download https://libraries.minecraft.net/com/mojang/authlib/2.1.28/authlib-2.1.28.jar %CD%\authlib-2.1.28.jar
	bitsadmin /transfer download https://libraries.minecraft.net/it/unimi/dsi/fastutil/8.2.1/fastutil-8.2.1.jar %CD%\fastutil-8.2.1.jar
	bitsadmin /transfer download https://libraries.minecraft.net/org/apache/logging/log4j/log4j-api/2.8.1/log4j-api-2.8.1.jar %CD%\log4j-api-2.8.1.jar
	bitsadmin /transfer download https://libraries.minecraft.net/org/apache/logging/log4j/log4j-core/2.8.1/log4j-core-2.8.1.jar %CD%\log4j-core-2.8.1.jar
)
cd ..
rd temp

call gradlew shadowJar
pause