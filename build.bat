@echo off
REM ============================================================================
REM GESTION PRO v3.0 - Build Application
REM Crée les fichiers .exe pour distribution
REM ============================================================================

setlocal enabledelayedexpansion

cls
echo.
echo ============================================================================
echo  📦 Construction de GESTION PRO v3.0
echo ============================================================================
echo.

REM Vérifier que nous sommes dans le bon répertoire
if not exist "package.json" (
    echo ❌ ERREUR: package.json non trouvé!
    echo.
    pause
    exit /b 1
)

REM Vérifier si node_modules existe
if not exist "node_modules\" (
    echo ⚠️  node_modules non trouvé!
    echo Installation des dépendances...
    echo.
    call npm install
    if errorlevel 1 (
        echo ❌ Erreur lors de l'installation!
        pause
        exit /b 1
    )
    echo.
)

echo.
echo ============================================================================
echo  📋 Sélectionnez le type de build
echo ============================================================================
echo.
echo  1 = NSIS Installer + Portable (Recommandé - 2 fichiers)
echo  2 = Portable uniquement (Petit fichier - Pas d'installation)
echo  3 = NSIS Installer uniquement (Installation complète)
echo  4 = Quitter
echo.

set /p BUILD_TYPE="Votre choix (1-4): "

if "%BUILD_TYPE%"=="1" (
    echo.
    echo Construction complète en cours... (cela peut prendre 2-3 minutes)
    echo.
    call npm run build
    if errorlevel 1 (
        echo.
        echo ❌ Erreur lors du build!
        pause
        exit /b 1
    )
    echo.
    echo ✅ Build réussi!
    echo.
    echo 📁 Les fichiers se trouvent dans: dist\
    echo.
    echo   - Gestion-Pro-3.0.0.exe (Portable - Lancer directement)
    echo   - Gestion Pro Setup.exe (NSIS - Installation recommandée)
    echo.
    pause
    exit /b 0
) else if "%BUILD_TYPE%"=="2" (
    echo.
    echo Construction portable en cours...
    echo.
    call npm run build-portable
    if errorlevel 1 (
        echo.
        echo ❌ Erreur lors du build portable!
        pause
        exit /b 1
    )
    echo.
    echo ✅ Build portable réussi!
    echo.
    echo 📁 Le fichier se trouve dans: dist\
    echo.
    echo   - Gestion-Pro-3.0.0.exe (Portable - Prêt à distribuer)
    echo.
    pause
    exit /b 0
) else if "%BUILD_TYPE%"=="3" (
    echo.
    echo Construction NSIS en cours...
    echo.
    call npm run build
    if errorlevel 1 (
        echo.
        echo ❌ Erreur lors du build!
        pause
        exit /b 1
    )
    echo.
    echo ✅ Build réussi!
    echo.
    echo 📁 Le fichier se trouve dans: dist\
    echo.
    echo   - Gestion Pro Setup.exe (NSIS - Installeur)
    echo.
    pause
    exit /b 0
) else if "%BUILD_TYPE%"=="4" (
    echo.
    echo Au revoir!
    exit /b 0
) else (
    echo.
    echo ❌ Choix invalide!
    timeout /t 2 >nul
    exit /b 1
)

pause
