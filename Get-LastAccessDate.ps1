param (
    [Parameter(Mandatory=$true)]
        [string]$Path,
    [Parameter(Mandatory=$true)]
        [string]$CsvExportPath
)

$Children = (Get-ChildItem -Path $Path -Recurse | Select-Object -Property LastAccessTime,LastWriteTime,FullName,PSIsContainer)

$(Foreach ($Child in $Children) {
    $SplitName = $Child.FullName.Split('\')

    [ordered]$ExportTable = @{
        "LastAccessTime" = $Child.LastAccessTime;
        "LastWriteTime" = $Child.LastWriteTime;
        "FullName" = $Child.FullName;
        "IsDirectory" = $Child.PSIsContainer;
    }

    # Add each name portion as a new column
    $NDir = 0
    Foreach ($NamePortion in $SplitName) {
        $ExportTable.Add("Path-$NDir", $NamePortion)
        $NDir += 1;
    }

    New-Object psobject -Property $ExportTable
}) | Export-Csv -Path $CsvExportPath
