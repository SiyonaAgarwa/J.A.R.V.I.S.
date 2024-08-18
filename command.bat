@echo off
setlocal

REM Set the Python installer URL and filename
set PYTHON_URL=https://www.python.org/ftp/python/3.10.12/python-3.10.12-amd64.exe
set PYTHON_INSTALLER=python-3.10.12-amd64.exe

REM Set the installation directory and Python executable path
set INSTALL_DIR=C:\Python310
set PYTHON_EXE=%INSTALL_DIR%\python.exe

REM Download Python installer
echo Downloading Python 3.10 installer...
powershell -Command "Invoke-WebRequest -Uri %PYTHON_URL% -OutFile %PYTHON_INSTALLER%"

REM Run the installer with silent install options
echo Installing Python 3.10...
start /wait %PYTHON_INSTALLER% /quiet InstallAllUsers=1 PrependPath=1 TargetDir=%INSTALL_DIR%

REM Verify Python installation
if exist "%PYTHON_EXE%" (
    echo Python 3.10 installed successfully.
) else (
    echo Python installation failed.
    exit /b 1
)

REM Install required Python packages
echo Installing required Python packages...
"%PYTHON_EXE%" -m pip install --upgrade pip
"%PYTHON_EXE%" -m pip install pyaudio pyttsx3 SpeechRecognition wikipedia pywhatkit pyjokes PyAutoGUI requests PyQt5 pyqt5-tools

REM Optional: Install Visual Studio Code
REM Uncomment the following lines if you want to install VS Code
REM set VSCODE_URL=https://code.visualstudio.com/sha/download?build=stable&os=win32-x64
REM set VSCODE_INSTALLER=VSCodeSetup-x64.exe
REM echo Downloading Visual Studio Code...
REM powershell -Command "Invoke-WebRequest -Uri %VSCODE_URL% -OutFile %VSCODE_INSTALLER%"
REM echo Installing Visual Studio Code...
REM start /wait %VSCODE_INSTALLER% /silent

echo Installation complete.
pause
endlocal
