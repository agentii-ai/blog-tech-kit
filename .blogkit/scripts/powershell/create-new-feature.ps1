# Create new feature script for PowerShell
param(
    [Parameter(Mandatory=$true)]
    [string]$FeatureName
)

$ErrorActionPreference = "Stop"

# Load common functions
. "$PSScriptRoot\common.ps1"

$paths = Get-FeaturePaths

# Create feature directory
$featureDir = $paths.FEATURE_DIR
if (-not (Test-Path $featureDir)) {
    New-Item -ItemType Directory -Path $featureDir -Force | Out-Null
    Write-Host "Created feature directory: $featureDir"
}

# Copy spec template
$specTemplate = Join-Path $paths.REPO_ROOT ".blogkit\templates\spec-template.md"
if (Test-Path $specTemplate) {
    Copy-Item $specTemplate (Join-Path $featureDir "spec.md") -Force
    Write-Host "Created spec.md"
}

Write-Host "Feature $FeatureName created successfully!"
