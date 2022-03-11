param (
    [Parameter(Mandatory=$true)]
        [string]$Path,
    [Parameter(Mandatory=$true)]
        [string]$CsvDir
)

$DateNow = Get-Date
$Path = (Resolve-Path $Path).Path
$PathSplit = $Path.Split('\')
$CsvName = ("Export-{0}-{1}.csv" -f $PathSplit[1], $PathSplit[2])
$Children = (Get-ChildItem -Path $Path -Recurse | Select-Object -Property LastAccessTime,LastWriteTime,FullName,PSIsContainer)

$(Foreach ($Child in $Children) {
    $SplitName = $Child.FullName.Split('\')

    $ExportTable = [ordered]@{
        "6MonthWrite" = $false;
        "6MonthAccess" = $false;
        "LastWriteTime" = $Child.LastWriteTime;
        "LastAccessTime" = $Child.LastAccessTime;
        "IsDirectory" = $Child.PSIsContainer;
        "FullName" = $Child.FullName;
    }

    # Check last 6 months
    If ($Child.LastAccessTime -gt $DateNow.AddMonths(-6)) {
        $ExportTable["6MonthAccess"] = $true;
    }
    If ($Child.LastWriteTime -gt $DateNow.AddMonths(-6)) {
        $ExportTable["6MonthWrite"] = $true;
    }

    # Add each name portion as a new column
    For ($p = 0; $p -lt $SplitName.Length + 1; $p++) {
        $ExportTable.Add("Path$p", $SplitName[$p])
    }

    New-Object psobject -Property $ExportTable
}) | Export-Csv -Path "${CsvDir}\${CsvName}" -NoTypeInformation
