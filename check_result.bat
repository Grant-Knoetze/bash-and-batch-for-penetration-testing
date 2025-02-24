@echo off
setlocal

:: Check if response.json exists
if not exist "response.json" (
    echo Error: response.json file not found!
    exit /b 1
)

:: Use PowerShell to parse the JSON and check if the API call was successful
powershell -Command "if (-not (Test-Path 'response.json')) { exit 1 }"
if %ERRORLEVEL% neq 0 (
    echo Error: response.json file not found!
    exit /b 1
)

:: Check if the "choices" field exists in the JSON
powershell -Command "$response = Get-Content 'response.json' | ConvertFrom-Json; if (-not $response.choices) { exit 1 }"
if %ERRORLEVEL% neq 0 (
    echo Error: API call failed or response is malformed!
    exit /b 1
)

:: Extract the response content from the JSON
for /f "delims=" %%i in ('powershell -Command "$response = Get-Content 'response.json' | ConvertFrom-Json; $response.choices[0].message.content"') do set RESPONSE_CONTENT=%%i

:: Check if the response content is empty
if "%RESPONSE_CONTENT%"=="" (
    echo Error: No content found in the response!
    exit /b 1
)

:: Display the response content
echo API Response Content:
echo %RESPONSE_CONTENT%

:: Clean up (optional)
del "Website URL goes here" 2>nul
del response.json 2>nul

echo Check completed successfully.
exit /b 0