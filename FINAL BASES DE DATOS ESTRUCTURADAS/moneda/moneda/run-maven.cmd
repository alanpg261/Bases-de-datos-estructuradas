@echo off
setlocal enabledelayedexpansion

REM Configurar JAVA_HOME para Java 17
set JAVA_HOME=C:\Users\alanp\.jdk\jdk-17
set PATH=%JAVA_HOME%\bin;%PATH%

REM Ejecutar Maven wrapper con Java 17
cd /d "%~dp0"
call mvnw.cmd %*
