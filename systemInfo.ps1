<#
.NOTES
Nom du fichier 		: systemInfo.ps1
Prérequis 		    : PowerShell 7.4.0
Version du script 	: 1.0
Auteur 			    : Velickovic Mateja
Date de creation 	: 08.12.2023
Lieu 			    : ETML, Sébeillon
Changement 		    : Aucun
 
.SYNOPSIS
Affichage d'un menu qui propose différentes actions à l'utilisateur

.DESCRIPTION
L'utilisateur a le choix entre afficher le nom des services, aficher la liste des
utilisateurs locaux, afficher la quantité de RAM du PC ou bien quitter le programme.

.INPUTS
-
 
.OUTPUTS
-
 
.EXAMPLE
PS> .\systemInfo.ps1

Que voulez-vous faire ?
 a) Afficher les services actifs
 b) Afficher la liste des utilisateurs locaux
 c) Afficher la quantité de RAM du PC
 x) Fin
a

AppIDSvc                         Appinfo                         AudioEndpointBuilder            Audiosrv
BFE                              BrokerInfrastructure            camsvc                          cbdhsvc_25762
CDPSvc                           CDPUserSvc_25762                CoreMessagingRegistrar          CryptSvc
DcomLaunch                       DevicesFlowUserSvc_25762        Dhcp                            DispBrokerDesktopSvc
DisplayEnhancementService        Dnscache                        DPS                             DsSvc
DusmSvc                          EventLog                        EventSystem                     FontCache
gpsvc                            InstallService                  InventorySvc                    iphlpsvc
KeyIso                           LanmanServer                    LanmanWorkstation               lfsvc
LicenseManager                   lmhosts                         LSM                             mpssvc
NcbService                       netprofm                        NPSMSvc_25762                   nsi
OneSyncSvc_25762                 PcaSvc                          PimIndexMaintenanceSvc_25762    PlugPlay
Power                            ProfSvc                         RasMan                          RmSvc
RpcEptMapper                     RpcSs                           SamSs                           Schedule
SecurityHealthService            SENS                            ShellHWDetection                Spooler
SSDPSRV                          SstpSvc                         StateRepository                 StorSvc
SysMain                          SystemEventsBroker              TextInputManagementService      Themes
TimeBrokerSvc                    TokenBroker                     TrkWks                          UdkUserSvc_25762
UnistoreSvc_25762                UserDataSvc_25762               UserManager                     UsoSvc
VaultSvc                         VBoxService                     W32Time                         Wcmsvc
WdNisSvc                         webthreatdefsvc                 webthreatdefusersvc_25762       WinDefend
WinHttpAutoProxySvc              Winmgmt                         WpnService                      WpnUserService_25762
wscsvc                           WSearch                         XblAuthManager

.EXAMPLE
PS> .\systemInfo.ps1

Que voulez-vous faire ?
 a) Afficher les services actifs
 b) Afficher la liste des utilisateurs locaux
 c) Afficher la quantité de RAM du PC
 x) Fin
b

Administrateur
DefaultAccount
EtmlPowershell
Invité
WDAGUtilityAccount

.EXAMPLE
PS> .\systemInfo.ps1

Que voulez-vous faire ?
 a) Afficher les services actifs
 b) Afficher la liste des utilisateurs locaux
 c) Afficher la quantité de RAM du PC
 x) Fin
c

8576,413696

.EXAMPLE
PS> .\systemInfo.ps1

Que voulez-vous faire ?
 a) Afficher les services actifs
 b) Afficher la liste des utilisateurs locaux
 c) Afficher la quantité de RAM du PC
 x) Fin
x

PS C:\Users\EtmlPowershell\Desktop\TF1>

.LINK
-
#>

# Consigne
$list =
@("Que voulez-vous faire ?"),
@(" a) Afficher les services actifs"),
@(" b) Afficher la liste des utilisateurs locaux"),
@(" c) Afficher la quantité de RAM du PC"),
@(" x) Fin")

# Variable qui contient les 4 lettres que l'utilisateur peut entrer
$validLetters = 
@('a', 'b', 'c', 'x')

do {
# Affichage de la consigne
Write-Output $list

# On demande la touche à l'utilisateur tant que cette dernière ne correspond pas à la liste
do {
    
    # L'utilisateur entre une touche
    $action = Read-Host

    # Message d'erreur si la touche entrée ne correspond pas à la liste de touches $validLetters
    if ($validLetters -notcontains $action) {
        Write-Host "Valeur non-reconnue, veuillez réessayer" -ForegroundColor Red
    }

} while (!($validLetters -like $action))

switch ($action) {

    # Choix numéro 1 (a)
    $validLetters[0] { 
        $runningServices = Get-Service | Where-Object { $_.Status -eq "Running" } | Select-Object Name | Format-Wide -Column 4
        $runningServices
    }

    # Choix numéro 2 (b)
    $validLetters[1] { 
        Get-LocalUser | Select-Object Name 
    }

    # Choix numéro 3 (c)
    $validLetters[2] { 
        $ramB = Get-CimInstance Win32_ComputerSystem 
        $ramGIB = $ramB.TotalPhysicalMemory / 1000000
        $ramGIB
    }
    # Choix numéro 4 (x), sortie du programme
    $validLetters[3] { 
        Exit
    }

}
}while ($action -notlike $validLetters[3])

