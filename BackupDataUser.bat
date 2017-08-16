CHCP 65001
::###############################################################################################
::###############################################################################################
::###############################################################################################
::##############
::##############                     BackupDataUser.bat
::##############                        Version 1.0
::##############                     sidjack972@gmail.com
::##############                        
::##############
::###############################################################################################
::###############################################################################################
::##############     Version: 
::##############              1.0 21/11/15 Création
::##############
::##############
::##############
::##############
::##############################################################################################
::##############  Définistion: Sauvegarde et restaure les données de l'utilisateur
::##############               Documents Vidéos Images Musique Bureau Favoris Contacts 
::##############  
::##############
::##############################################################################################
::##############################################################################################
::##############################################################################################

:DEBUT
:: Debut script
ECHO OFF
TITLE SAUVEGARDE RESTAURE DONNEES UTILISATEUR  
:: Selection du systeme Windows XP,vista,7,8,8.1
CLS 
SET lecteurBackup=%CD%
ECHO.
ECHO.
ECHO.
COLOR 0E
ECHO        +-----------------------------------------------------+
ECHO        :                                                     :
ECHO        :       Script de Sauvegarde Windows XP a 10          :
ECHO        :                Version 1.0                          :
ECHO        +-----------------------------------------------------+
ECHO.
ECHO.
ECHO.
ECHO.
ECHO        +-----------------------------------------------------+
ECHO        :                                                     :
ECHO        :      Selectinner sauvegarde ou restauration du      :
ECHO        :     s ysteme :                                      :
ECHO        :                                                     :
ECHO        :      1 )  Sauvegarde                                :
ECHO        :      2 )  Restauration                              :
ECHO        :                                                     :
ECHO        :                                                     :
ECHO        +-----------------------------------------------------+
ECHO.
ECHO.
SET /P modeBackup=Taper 1 ou 2: 
IF /I %modeBackup%==1 GOTO SAVE
IF /I %modeBackup%==2 GOTO RESTOR
IF /I NOT %modeBackup%==1 GOTO DEBUT

:SAVE
CLS
ECHO        +-----------------------------------------------------+
ECHO        :                                                     :
ECHO        :     Selectionner le systeme windows a sauvegarder   :
ECHO        :                                                     :
ECHO        :     1 )   Windows XP                                :
ECHO        :     2 )   Windows Vista,Seven,8,8.1 et 10           :
ECHO        :                                                     :
ECHO        +-----------------------------------------------------+
ECHO.	
ECHO.		                                                     
SET /p systemBackup=Selectionner le systeme windows , Taper 1 ou 2: 
ECHO.
IF /I %systemBackup%==1 GOTO WINXP
IF /I %systemBackup%==2 GOTO WIN
IF /I NOT %systemBackup%==1 GOTO SAVE

:: Windows XP
:WINXP
SET appBackup=\Apps\robocopyXP.exe
SET documentsUser=Mes documents
SET bureauUser=Bureau
SET favorisUser=Favoris
GOTO BACKUP

:: Windows Vista 7 8 8.1 10
:WIN
SET appBackup=\Apps\robocopy.exe
SET documentsUser=Documents
SET imagesUser=Pictures
SET bureauUser=Desktop
SET musiqueUser=Music
SET videoUser=Videos
SET favorisUser=Favorites
SET contactsUser=Contacts
GOTO BACKUP
::==========================================================================================================
::====================================== PARTIE BACKUP =====================================================
::==========================================================================================================
:BACKUP  
:: Sauvegarde des donnees utilisateur
:: Creation du dossier BACKUP_Utilisateur
MKDIR "%lecteurBackup%\
SET dossierBackup=%lecteurBackup%:\%USERNAME%\
:: Log de sauvegarde
SET logSave="%lecteurBackup%:\%USERNAME%\Log_Backup.txt"

:: Sauvegarde Des Fichiers 
ECHO ###### DEBUT DE SAUVEGARDE ######>>%logSave%
ECHO %DATE% %TIME%>>%logSave%
REM =========== MES DOCUMENTS ===============
ECHO ########## DEBUT SAVE MES DOCUMENTS ####### %DATE% %TIME% #####>>%logSave% 
%appBackup% "%USERPROFILE%\%documentsUser%" "%dossierBackup%Documents" /E /XO /r:2 /w:10 /TEE /LOG+:%logSave%
ECHO ====== FIN SAVE MES DOCUMENTS ===== %DATE% %TIME% ====>>%logSave% 

REM ============= BUREAU =================
ECHO ########## DEBUT SAVE BUREAU ########### %DATE% %TIME% ######>>%logSave%
%appBackup% "%USERPROFILE%\%bureauUser%" "%dossierBackup%Bureau" /E /XO /r:2 /w:10 /TEE /LOG+:%logSave%
ECHO ====== FIN SAVE BUREAU ===== %DATE% %TIME% ====>>%logSave% 

REM ============= FAVORIS =================
ECHO ########## DEBUT SAVE FAVORIS ########### %DATE% %TIME% ######>>%logSave%
%appBackup% "%USERPROFILE%\%favorisUser%" "%dossierBackup%Favoris" /E /XO /r:2 /w:10 /TEE /LOG+:%logSave%
ECHO ====== FIN SAVE FAVORIS ===== %DATE% %TIME% ====>>%logSave% 

REM Si OS est Windows XP alors saute a partir d'ici
IF %systemBackup%==1 GOTO FINSAVE

REM ============= IMAGES =================
ECHO ########## DEBUT SAVE IMAGES ########### %DATE% %TIME% ######>>%logSave%
%appBackup% "%USERPROFILE%\%imagesUser%" "%dossierBackup%Images" /E /XO /r:2 /w:10 /TEE /LOG+:%logSave%
ECHO ######## FIN SAVE IMAGES ####### %DATE% %TIME% #####>>%logSave%

REM ============= VIDEOS =================
ECHO ########## DEBUT SAVE VIDEOS ########### %DATE% %TIME% ######>>%logSave%
%appBackup% "%USERPROFILE%\%videoUser%" "%dossierBackup%Videos" /E /XO /r:2 /w:10 /TEE /LOG+:%logSave%
ECHO ====== FIN SAVE VIDEOS ===== %DATE% %TIME% ====>>%logSave% 

REM ============= MUSIQUE =================
ECHO ########## DEBUT SAVE MUSIQUE ########### %DATE% %TIME% ######>>%logSave%
%appBackup% "%USERPROFILE%\%musiqueUser%" "%dossierBackup%Musiques" /E /XO /r:2 /w:10 /TEE /LOG+:%logSave%
ECHO ====== FIN SAVE MUSIQUE ===== %DATE% %TIME% ====>>%logSave% 

REM ============= CONTACTS =================
ECHO ########## DEBUT SAVE CONTACTS ########### %DATE% %TIME% ######>>%logSave%
%appBackup% "%USERPROFILE%\%contactsUser%" "%dossierBackup%Contacts" /E /XO /r:2 /w:10 /TEE /LOG+:%logSave%
ECHO ====== FIN SAVE CONTACTS ===== %DATE% %TIME% ====>>%logSave% 

:FINSAVE
ECHO ############## FIN DES SAUVEGARDES ##########>>%logSave%
GOTO FIN

::===================================================================================
::============================= PARTIE RESTAURATIONS ================================
::===================================================================================
:RESTOR
:: Menu de restauration
CLS
ECHO.
ECHO.
ECHO.
ECHO.
ECHO          +--------------------------------------------------------------+
ECHO          :                                                              :
ECHO          :                   Menu de restauration                       :
ECHO          :                                                              :
ECHO          :     1)    USB Backup Win XP vers Win vista 7,8,8.1 et 10     :
ECHO          :     2)    USB Backup Win vista 7,8,8.1 et 10 vers HDD        :
ECHO          :     3)    USB Backup Win XP vers Win XP                      :
ECHO          :                                                              :
ECHO          :    info : !!  Windows XP n'a plus de support depuis          :
ECHO          :            8 avril 2014  !!                                  :
ECHO          :                                                              :
ECHO          +--------------------------------------------------------------+
ECHO.
ECHO.
ECHO.
ECHO.
ECHO.
SET /P modeRestor= Taper 1, 2 ou 3: 
IF /I %modeRestor%==1 GOTO WINXP_WIN7
IF /I %modeRestor%==2 GOTO USB_HDD
IF /I %modeRestor%==3 GOTO WINXP_WINXP
IF NOT %modeRestor%==1 GOTO RESTOR

:: Backup USB win 7, 8, 8.1 et 10 vers disque dur
:USB_HDD
:: Variables
SET appBackup=\Apps\robocopy.exe
SET documentsUser=Documents
SET imagesUser=Pictures
SET bureauUser=Desktop
SET musiqueUser=Music
SET videoUser=Videos
SET favorisUser=Favorites
SET contactsUser=Contacts

GOTO DEBUTRESTOR

:WINXP_WINXP
CLS
COLOR 0C
ECHO.
ECHO.
ECHO.                        
ECHO !!!!!!!!   ATTENTION WINDOWS XP N'A PLUS DE SUPPORT DEPUIS 8 AVRIL 2014 !!!!!!!!
ECHO.
ECHO.
ECHO.
COLOR 0e
TIMEOUT /t 10
COLOR OE
:: Variables
SET appBackup=\Apps\robocopyXP.exe
SET dossierUsers=Documents and Settings
SET documentsUser=Mes documents
SET bureauUser=Bureau
SET favorisUser=Favoris
GOTO DEBUTRESTOR

:DEBUTRESTOR
:: Restauration des donnees utilisateur
SET dossierBackup=%lecteurBackup%\%USERNAME%\
:: Log de restauration
SET logRestor=%lecteurBackup%\%USERNAME%\Log_Restor.txt

:: Restauration Des Fichiers 
ECHO ###### DEBUT DES RESTAURATIONS ######>>%logRestor%
ECHO %DATE% %TIME%>>%logRestor%
REM =========== MES DOCUMENTS ===============
ECHO ########## DEBUT RESTOR MES DOCUMENTS ####### %DATE% %TIME% #####>>%logRestor% 
%appBackup% "%dossierBackup%Documents" "%USERPROFILE%\%documentsUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ====== FIN RSTOR MES DOCUMENTS ===== %DATE% %TIME% ====>>%logRestor% 

REM ============= BUREAU =================
ECHO ########## DEBUT SAVE BUREAU ########### %DATE% %TIME% ######>>%logRestor%
%appBackup% "%dossierBackup%Bureau" "%USERPROFILE%\%bureauUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ====== FIN DEBUT BUREAU ===== %DATE% %TIME% ====>>%logRestor% 

REM ============= FAVORIS =================
ECHO ########## DEBUT RESTOR FAVORIS ########### %DATE% %TIME% ######>>%logRestor%
%appBackup% "%dossierBackup%Favoris" "%USERPROFILE%\%favorisUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ====== FIN RESTOR FAVORIS ===== %DATE% %TIME% ====>>%logRestor% 

REM Si OS est Windows XP alors saute a partir d'ici
IF %modeRestor%==3 GOTO FINRESTOR

REM ============= IMAGES =================
ECHO ########## DEBUT RESTOR IMAGES ########### %DATE% %TIME% ######>>%logRestor%
%appBackup% "%dossierBackup%Images" "%USERPROFILE%\%imagesUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ######## FIN RESTOR IMAGES ####### %DATE% %TIME% #####>>%logRestor%

REM ============= VIDEOS =================
ECHO ########## DEBUT VIDEOS ########### %DATE% %TIME% ######>>%logRestor%
%appBackup% "%dossierBackup%Videos" "%USERPROFILE%\%videoUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ####### FIN RESTOR VIDEOS ===== %DATE% %TIME% ====>>%logRestor% 

REM ============= MUSIQUE =================
ECHO ########## DEBUT MUSIQUE ########### %DATE% %TIME% ######>>%logRestor%
%appBackup% "%dossierBackup%Musiques" "%USERPROFILE%\%musiqueUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ######### FIN RESTOR MUSIQUE ===== %DATE% %TIME% ====>>%logRestor% 

REM ============= CONTACTS =================
ECHO ########## DEBUT CONTACTS ########### %DATE% %TIME% ######>>%logRestor%
%appBackup% "%dossierBackup%Contacts" "%USERPROFILE%\%contactsUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ########## FIN RESTOR CONTACTS ===== %DATE% %TIME% ====>>%logRestor% 


:FINRESTOR
ECHO ############## FIN DES RESTAURATIONS ################################ %DATE% ######### %TIME% ######>>%logRestor%
GOTO FIN


:: Backup Windows XP vers Windows 7, 8, 8.1 et 10
:WINXP_WIN7
:: Restauration des donnees utilisateur
SET dossierBackup=%lecteurBackup%\%USERNAME%\
:: Log de restauration
SET logRestor="%lecteurBackup%\%USERNAME%\Restor.txt"
:: Variables 
SET appBackup=\Apps\robocopy.exe
SET documentsUser=Documents
SET imagesUser=Pictures
SET bureauUser=Desktop
SET musiqueUser=Music
SET videoUser=Videos
SET favorisUser=Favorites
SET contactsUser=Contacts 
ECHO.
:: Restauration des donnees utilisateur
ECHO ########## DEBUT DES RESTAURATIONS ############ %DATE% %TIME% ######>>%logRestor%
REM ============= DOCUMENTS ===========
ECHO ########## DEBUT RESTOR MES DOCUMENTS ####### %DATE% %TIME% #####>>%logRestor% 
%appBackup% "%dossierBackup%Documents" "%USERPROFILE%\%documentsUser%" /E /XO /r:2 /w:10 /TEE /XD "%dossierBackup%Documents\Mes images" /XD "%dossierBackup%Documents\Ma musique"  /LOG+:%logRestor%
ECHO ====== FIN RSTOR MES DOCUMENTS ===== %DATE% %TIME% ====>>%logRestor% 
REM ============= BUREAU ==============
ECHO ########## DEBUT SAVE BUREAU ########### %DATE% %TIME% ######>>%logRestor%
%appBackup% "%dossierBackup%Bureau" "%USERPROFILE%\%bureauUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ====== FIN DEBUT BUREAU ===== %DATE% %TIME% ====>>%logRestor% 
REM ============= FAVORIS =================
ECHO ########## DEBUT RESTOR FAVORIS ########### %DATE% %TIME% ######>>%logRestor%
%appBackup% "%dossierBackup%Favoris" "%USERPROFILE%\%favorisUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ====== FIN RESTOR FAVORIS ===== %DATE% %TIME% ====>>%logRestor%
REM ============= IMAGES =================
ECHO ########## DEBUT RESTOR IMAGES ########### %DATE% %TIME% ######>>%logRestor%
%appBackup% "%dossierBackup%Documents\Mes images" "%USERPROFILE%\%imagesUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ######## FIN RESTOR IMAGES ####### %DATE% %TIME% #####>>%logRestor%
REM ============= MUSIQUE =================
ECHO ########## DEBUT MUSIQUE ########### %DATE% %TIME% ######>>%logRestor%
%appBackup% "%dossierBackup%Documents\Ma musique" "%USERPROFILE%\%musiqueUser%" /E /XO /r:2 /w:10 /TEE /LOG+:%logRestor%
ECHO ######### FIN RESTOR MUSIQUE ===== %DATE% %TIME% ====>>%logRestor% 

:: Fin de la restauration 
ECHO ############### FIN DES RESTAURATIONS ################################ %DATE% ######### %TIME% ######>>%logRestor%
GOTO FIN

:FIN
:: FIN 
PAUSE

EXIT