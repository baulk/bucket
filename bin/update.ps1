#!/usr/bin/env pwsh


$ScoopMain = "https://github.com/ScoopInstaller/Main.git"
$ScoopMainRoot = Join-Path $env:TEMP -ChildPath "scoop_main"
$ScoopMainBucket = Join-Path $ScoopMainRoot -ChildPath "bucket"
$BaulkRoot = Split-Path -Path $PSScriptRoot
$BaulkBucket = Join-Path -Path $BaulkRoot -ChildPath "bucket"

# $ps = Start-Process -FilePath "git" -ArgumentList "clone $ScoopMain --depth=1 `"$ScoopMainRoot`"" -Wait -NoNewWindow -PassThru
# if ($ps.ExitCode -ne 0) {
#     exit 1
# }

Get-ChildItem -Path "$ScoopMainBucket/*.json" -File | ForEach-Object {
    $BaseName = $_.BaseName
    $FullName = $_.FullName
    $Ours = "$BaulkBucket\$BaseName.json"
    if (!(Test-Path $Ours)) {
        return ;
    }
    $theirs = Get-Content $FullName | ConvertFrom-Json
    Write-Host "$BaseName ported to baulk: $($theirs.version)"
}