# Start new process -hidden
# if serverrunning -> 1 then STOP!
# in it - create serverrunning.txt and set ontents to 1
# start server in another process.
# wait for server to exit
# ser serverrunning.txt contents to 0

if ($args[0] -eq "StartServer") {
    Write-Output "Running in server watching mode. Do not close me."
}
else {
    Start-Process powershell {./ServerManager.ps1 StartServer} -WindowStyle Hidden
    exit
}

if (Test-Path -Path is-server-running.txt) {
    $serverRunningStatus = Get-Content -Path is-server-running.txt
    Write-Output "is-server-running.txt contains: " $serverRunningStatus
}
else {
    Write-Output "is-server-running.txt does not exist. Will create one."
    $serverRunningStatus = 0
}
Write-Output "Checking if server is already running somewhere else..."
if ($serverRunningStatus.StartsWith("1")) {
    Write-Output "SERVER IS ALREADY RUNNING SOMEWHERE! Will not start now. Conflicts may happen."
    $serverRunningStatus = $serverRunningStatus -split ("`n")
    Start-Process cmd -ArgumentList "/C echo SEEMS LIKE SERVER IS ALREADY RUNNING at: $($serverRunningStatus[1]) ... & echo Contact other server guys who are able to run server to make sure its not running. & echo -------- & echo If you think this is an error (which might happen at some point): & echo delete is-server-running.txt file. & echo WARNING if server is running somewhere at the same time, world might get corrupted & echo ------------ & pause" -WindowStyle Normal
    exit
}

Write-Output "Setting server running state, so that no one will run it at same time."
Write-Output "1`n$env:UserName @ $env:ComputerName" > is-server-running.txt
Write-Output "Starting the server... Waiting for it to exit."
Start-Process java -ArgumentList "-Xms1024M", "-Xmx2048M", "-jar", "minecraft_server.1.12.2.jar", "nogui" -WindowStyle Normal -Wait
Write-Output "Resetting server running state."
Write-Output 0 > is-server-running.txt
exit

