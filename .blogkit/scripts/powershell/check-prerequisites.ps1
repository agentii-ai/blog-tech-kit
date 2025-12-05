# Check prerequisites script for PowerShell
param(
    [switch]$Json,
    [switch]$RequireTasks,
    [switch]$IncludeTasks
)

$ErrorActionPreference = "Stop"

# Load common functions
. "$PSScriptRoot\common.ps1"

# Get all paths
$paths = Get-FeaturePaths

# Check if feature directory exists
if (-not (Test-Path $paths.FEATURE_DIR)) {
    Write-Error "Feature directory not found: $($paths.FEATURE_DIR)"
    exit 1
}

# Build available docs list
$availableDocs = @()
@("spec.md", "plan.md", "tasks.md", "research.md", "data-model.md", "quickstart.md") | ForEach-Object {
    $filePath = Join-Path $paths.FEATURE_DIR $_
    if (Test-Path $filePath) {
        $availableDocs += $_
    }
}

# Check for tasks.md if required
if ($RequireTasks -and -not (Test-Path $paths.TASKS)) {
    Write-Error "tasks.md is required but not found"
    exit 1
}

# Output results
if ($Json) {
    $output = @{
        FEATURE_DIR = $paths.FEATURE_DIR
        AVAILABLE_DOCS = $availableDocs
    } | ConvertTo-Json -Compress
    Write-Output $output
} else {
    Write-Host "FEATURE_DIR: $($paths.FEATURE_DIR)"
    Write-Host "AVAILABLE_DOCS: $($availableDocs -join ', ')"
}
