@echo off
setlocal

REM Set the Python installer URL and filename
set PYTHON_URL=https://www.python.org/ftp/python/3.10.3/python-3.10.3-amd64.exe
set PYTHON_INSTALLER=python-3.10.3-amd64.exe

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
REM Use a direct download link for Visual Studio Code
set VSCODE_URL=https://update.code.visualstudio.com/latest/win32-x64/stable
set VSCODE_INSTALLER=VSCodeSetup-x64.exe
echo Downloading Visual Studio Code...
powershell -Command "Invoke-WebRequest -Uri %VSCODE_URL% -OutFile %VSCODE_INSTALLER%"

REM Check if the installer was downloaded successfully
if exist "%VSCODE_INSTALLER%" (
    echo Installing Visual Studio Code...
    start /wait %VSCODE_INSTALLER% /silent
) else (
    echo Visual Studio Code download failed.
    exit /b 1
)

echo Installation complete.
pause
endlocal
