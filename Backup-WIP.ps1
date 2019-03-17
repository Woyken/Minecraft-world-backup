# check if not running.
# if running wait till done.
# checkout "this" branch.
# git add .
# git commit
# git push

function IsServerRunning {
    if (!(Test-Path -Path is-server-running.txt)) {
        return $false
    }
    $serverRunningStatus = Get-Content -Path is-server-running.txt
    return $serverRunningStatus.StartsWith("1")
}

while (IsServerRunning) {
    Start-Process cmd -ArgumentList "/C echo Server is still running... & timeout 10" -WindowStyle Normal -Wait
}

& git checkout "1102A-Ed-Kl-Ka-2019"
& git pull
& git add .
$Date = Get-Date
& git commit -m $Date.ToString("yyyy-MM-dd")
& git push



