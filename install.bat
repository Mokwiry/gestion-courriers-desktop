@echo off
REM ============================================================================
REM GESTION PRO v3.0 - Installation Automatisée
REM Script pour Windows - Installation complète + Lancement
REM ============================================================================

setlocal enabledelayedexpansion

REM Couleurs
set "GREEN=[92m"
set "YELLOW=[93m"
set "RED=[91m"
set "RESET=[0m"

echo.
echo ============================================================================
echo  🚀 GESTION PRO v3.0 - Installation Automatisée
echo ============================================================================
echo.

REM Vérifier si Node.js est installé
echo %YELLOW%[1/4] Vérification de Node.js...%RESET%
node --version >nul 2>&1
if errorlevel 1 (
    echo %RED%❌ Node.js n'est pas installé!%RESET%
    echo.
    echo Téléchargez Node.js depuis: https://nodejs.org/
    echo Puis réexécutez ce script.
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('node --version') do set NODE_VERSION=%%i
echo %GREEN%✅ Node.js détecté: %NODE_VERSION%%RESET%
echo.

REM Vérifier si npm est installé
echo %YELLOW%[2/4] Vérification de npm...%RESET%
npm --version >nul 2>&1
if errorlevel 1 (
    echo %RED%❌ npm n'est pas installé!%RESET%
    pause
    exit /b 1
)
for /f "tokens=*" %%i in ('npm --version') do set NPM_VERSION=%%i
echo %GREEN%✅ npm détecté: %NPM_VERSION%%RESET%
echo.

REM Installer les dépendances
echo %YELLOW%[3/4] Installation des dépendances npm...%RESET%
echo.
call npm install
if errorlevel 1 (
    echo %RED%❌ Erreur lors de l'installation des dépendances!%RESET%
    pause
    exit /b 1
)
echo.
echo %GREEN%✅ Dépendances installées avec succès!%RESET%
echo.

REM Afficher les options
echo ============================================================================
echo  📋 Que voulez-vous faire?
echo ============================================================================
echo.
echo  1 = Lancer en mode DÉVELOPPEMENT (avec DevTools)
echo  2 = Builder l'application (NSIS Installer + Portable)
echo  3 = Builder en version Portable uniquement
echo  4 = Quitter
echo.

set /p CHOICE="Entrez votre choix (1-4): "

if "%CHOICE%"=="1" (
    echo.
    echo %YELLOW%Lancement en mode développement...%RESET%
    echo.
    call npm run dev
    exit /b 0
) else if "%CHOICE%"=="2" (
    echo.
    echo %YELLOW%Construction de l'application (NSIS + Portable)...%RESET%
    echo.
    call npm run build
    if errorlevel 1 (
        echo %RED%❌ Erreur lors du build!%RESET%
        pause
        exit /b 1
    )
    echo.
    echo %GREEN%✅ Build réussi! Les fichiers se trouvent dans le dossier 'dist/'%RESET%
    echo.
    pause
    exit /b 0
) else if "%CHOICE%"=="3" (
    echo.
    echo %YELLOW%Construction de la version Portable...%RESET%
    echo.
    call npm run build-portable
    if errorlevel 1 (
        echo %RED%❌ Erreur lors du build portable!%RESET%
        pause
        exit /b 1
    )
    echo.
    echo %GREEN%✅ Build portable réussi! Le fichier se trouve dans 'dist/'%RESET%
    echo.
    pause
    exit /b 0
) else if "%CHOICE%"=="4" (
    echo.
    echo Au revoir!
    exit /b 0
) else (
    echo.
    echo %RED%❌ Choix invalide!%RESET%
    timeout /t 2 >nul
    exit /b 1
)

pause
