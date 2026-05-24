param(
    [string]$Version,
    [switch]$SkipTests,
    [switch]$SkipBuild
)

$ErrorActionPreference = "Stop"

$RepoRoot = Resolve-Path (Join-Path $PSScriptRoot "..")

function Get-CargoVersion {
    $cargoToml = Join-Path $RepoRoot "Cargo.toml"
    $versionLine = Select-String -Path $cargoToml -Pattern '^version\s*=\s*"([^"]+)"' | Select-Object -First 1
    if (-not $versionLine) {
        throw "Could not find package version in Cargo.toml."
    }

    return $versionLine.Matches[0].Groups[1].Value
}

function Invoke-CheckedNativeCommand {
    param(
        [Parameter(Mandatory = $true)]
        [string]$Command,

        [Parameter(ValueFromRemainingArguments = $true)]
        [string[]]$Arguments
    )

    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) {
        throw "Command failed with exit code ${LASTEXITCODE}: $Command $($Arguments -join ' ')"
    }
}

if ([string]::IsNullOrWhiteSpace($Version)) {
    $Version = Get-CargoVersion
}

$ZipName = "winproc-tui-$Version-windows-x64.zip"
$ZipPath = Join-Path $RepoRoot "dist\$ZipName"
$Sha256Path = "$ZipPath.sha256"
$ExePath = Join-Path $RepoRoot "target\release\winproc-tui.exe"
$PackageFiles = @(
    $ExePath,
    (Join-Path $RepoRoot "README.md"),
    (Join-Path $RepoRoot "README.ja.md"),
    (Join-Path $RepoRoot "LICENSE")
)

Push-Location $RepoRoot
try {
    if (-not $SkipTests) {
        Invoke-CheckedNativeCommand cargo test
    }

    if (-not $SkipBuild) {
        Invoke-CheckedNativeCommand cargo build --release
    }

    if (-not (Test-Path $ExePath)) {
        throw "Release executable was not found: $ExePath"
    }

    New-Item -ItemType Directory -Force (Join-Path $RepoRoot "dist") | Out-Null

    Compress-Archive -Force -Path $PackageFiles -DestinationPath $ZipPath

    $hash = Get-FileHash $ZipPath -Algorithm SHA256
    $checksumText = "$($hash.Hash)  $ZipName`n"
    [System.IO.File]::WriteAllText($Sha256Path, $checksumText, [System.Text.UTF8Encoding]::new($false))

    Write-Host "Created package: $ZipPath"
    Write-Host "Created checksum: $Sha256Path"
}
finally {
    Pop-Location
}
