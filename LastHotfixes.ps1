
########################################################################################################################
# DESCRIPTION:  Returns last hotfixes installed on servers
########################################################################################################################

$ServerListPath = "C:\ServerList.txt" # Path to serverlist file
$LastHotfixes   = "10"                # Number of last hotfixes to list for each server

$Servers = Get-Content $ServerListPath
$Servers | foreach {(Get-HotFix -ComputerName $_) | 
    Where-Object -FilterScript {$_.InstalledOn -like "*00:00:00"} | # Returns only entries where InstalledOn has a value
    Sort-Object -Property InstalledOn |
    Select-Object -last $LastHotfixes # Returns last $LastHotfixes entries, omit this line to list all indstalled hotfixes
    }