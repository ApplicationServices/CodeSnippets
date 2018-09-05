
########################################################################################################################
# DESCRIPTION:  Returns top using processes on server, using performance counters
########################################################################################################################

$ServerListPath = "C:\ServerList.txt" # Path to serverlist file
$ServerList      = Get-Content -Path $ServerListPath

$ProcCounterList = ("\Process(*)\Working Set - Private","\Process(*)\% Processor Time")

echo ""
Write-host "Checking Performance Counters" -ForegroundColor Yellow
Write-Host "Process Memory Usage   - (\Process(*)\Working Set - Private)" -ForegroundColor Yellow
Write-Host "Process CPU usage in % - (\Process(*)\% Processor Time)" -ForegroundColor Yellow

foreach ($Server in $ServerList){

    Echo ""
    Write-host "Process Counters on $Server" -ForegroundColor Yellow

    foreach ($ProcCounter in $ProcCounterList){

        $ProcCounterData = Get-Counter -ComputerName $Server $ProcCounter -Verbose
        $ProcCounterProperties = @(
        @{n='Counter';e={$_.Path.Split('\')[-1]}},
        @{n='Instance';e={$_.Path.Split('\')[-2]}},
        @{n='Value';e={[math]::Round($_.CookedValue)}}
        )
        $ProcCounterData.CounterSamples | Select-Object -Property $ProcCounterProperties | Sort-Object -Property Value -Descending | Select-Object -First 5 
    }
}

########################################################################################################################
# DESCRIPTION:  Returns Current Memory Available, CPU Usage in % and free disk space in %, using performance counters
########################################################################################################################

$ServerListPath = "C:\ServerList.txt" # Path to serverlist file
$ServerList      = Get-Content -Path $ServerListPath

$CounterList     = ("\Memory\Available MBytes", "\Processor(_Total)\% Processor Time", "\LogicalDisk(_Total)\% Free Space" )

echo ""
Write-host "Checking Performance Counters" -ForegroundColor Yellow
Write-Host "Available memory MB   - (\Memory\Available MBytes)" -ForegroundColor Yellow
Write-Host "CPU Usage in %        - (\Processor(_Total)\% Processor Time)" -ForegroundColor Yellow
Write-Host "Free disk space in %  - (\LogicalDisk(_Total)\% Free Space)" -ForegroundColor Yellow

foreach ($Server in $ServerList){
    
    Echo ""
    Write-host "System Performance Counters on $Server" -ForegroundColor Yellow

    foreach ($Counter in $CounterList){
        
        $CounterData = Get-Counter -ComputerName $Server $Counter
        $CounterProperties = @(
        @{n='Counter';e={$_.Path.Split('\')[-1]}},
        @{n='Value';e={[math]::Round($_.CookedValue)}}
        )
        $CounterData.CounterSamples | Select-Object -Property $CounterProperties
    }

}