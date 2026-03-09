@echo off
cd /d "%~dp0"
:: This tells Git to ignore the line-ending warnings
git config core.autocrlf true
git pull origin main
git add .
git commit -m "Daily Vault Update: %date% %time%"
git push origin main