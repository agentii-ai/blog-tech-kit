# Common functions and variables for all PowerShell scripts
$ErrorActionPreference = "Stop"

# Get repository root, with fallback for non-git repositories
function Get-RepoRoot {
    try {
        $gitRoot = git rev-parse --show-toplevel 2>$null
        if ($LASTEXITCODE -eq 0) {
            return $gitRoot
        }
    } catch {}
    
    # Fall back to script location for non-git repos
    $scriptDir = Split-Path -Parent $PSCommandPath
    return (Resolve-Path "$scriptDir\..\..\..").Path
}

# Get current branch, with fallback for non-git repositories
function Get-CurrentBranch {
    # First check if SPECIFY_FEATURE environment variable is set
    if ($env:SPECIFY_FEATURE) {
        return $env:SPECIFY_FEATURE
    }
    
    # Then check git if available
    try {
        $branch = git rev-parse --abbrev-ref HEAD 2>$null
        if ($LASTEXITCODE -eq 0) {
            return $branch
        }
    } catch {}
    
    # For non-git repos, try to find the latest feature directory
    $repoRoot = Get-RepoRoot
    $specsDir = Join-Path $repoRoot "specs"
    
    if (Test-Path $specsDir) {
        $latestFeature = ""
        $highest = 0
        
        Get-ChildItem -Path $specsDir -Directory | ForEach-Object {
            if ($_.Name -match '^(\d{3})-') {
                $number = [int]$matches[1]
                if ($number -gt $highest) {
                    $highest = $number
                    $latestFeature = $_.Name
                }
            }
        }
        
        if ($latestFeature) {
            return $latestFeature
        }
    }
    
    return "main"  # Final fallback
}

# Check if we have git available
function Test-Git {
    try {
        git rev-parse --show-toplevel 2>$null | Out-Null
        return $LASTEXITCODE -eq 0
    } catch {
        return $false
    }
}

function Test-FeatureBranch {
    param(
        [string]$Branch,
        [bool]$HasGitRepo
    )
    
    # For non-git repos, we can't enforce branch naming but still provide output
    if (-not $HasGitRepo) {
        Write-Warning "[specify] Warning: Git repository not detected; skipped branch validation"
        return $true
    }
    
    if ($Branch -notmatch '^\d{3}-') {
        Write-Error "ERROR: Not on a feature branch. Current branch: $Branch"
        Write-Error "Feature branches should be named like: 001-feature-name"
        return $false
    }
    
    return $true
}

function Get-FeatureDir {
    param([string]$RepoRoot, [string]$Branch)
    return Join-Path $RepoRoot "specs\$Branch"
}

# Find feature directory by numeric prefix instead of exact branch match
function Find-FeatureDirByPrefix {
    param(
        [string]$RepoRoot,
        [string]$BranchName
    )
    
    $specsDir = Join-Path $RepoRoot "specs"
    
    # Extract numeric prefix from branch (e.g., "004" from "004-whatever")
    if ($BranchName -notmatch '^(\d{3})-') {
        # If branch doesn't have numeric prefix, fall back to exact match
        return Join-Path $specsDir $BranchName
    }
    
    $prefix = $matches[1]
    
    # Search for directories in specs/ that start with this prefix
    $matchedDirs = @()
    if (Test-Path $specsDir) {
        $matchedDirs = Get-ChildItem -Path $specsDir -Directory | 
            Where-Object { $_.Name -like "$prefix-*" } |
            Select-Object -ExpandProperty Name
    }
    
    # Handle results
    if ($matchedDirs.Count -eq 0) {
        # No match found - return the branch name path (will fail later with clear error)
        return Join-Path $specsDir $BranchName
    } elseif ($matchedDirs.Count -eq 1) {
        # Exactly one match - perfect!
        return Join-Path $specsDir $matchedDirs[0]
    } else {
        # Multiple matches - this shouldn't happen with proper naming convention
        Write-Error "ERROR: Multiple spec directories found with prefix '$prefix': $($matchedDirs -join ', ')"
        Write-Error "Please ensure only one spec directory exists per numeric prefix."
        return Join-Path $specsDir $BranchName  # Return something to avoid breaking the script
    }
}

function Get-FeaturePaths {
    $repoRoot = Get-RepoRoot
    $currentBranch = Get-CurrentBranch
    $hasGitRepo = Test-Git
    
    # Use prefix-based lookup to support multiple branches per spec
    $featureDir = Find-FeatureDirByPrefix -RepoRoot $repoRoot -BranchName $currentBranch
    
    return @{
        REPO_ROOT = $repoRoot
        CURRENT_BRANCH = $currentBranch
        HAS_GIT = $hasGitRepo
        FEATURE_DIR = $featureDir
        FEATURE_SPEC = Join-Path $featureDir "spec.md"
        IMPL_PLAN = Join-Path $featureDir "plan.md"
        TASKS = Join-Path $featureDir "tasks.md"
        RESEARCH = Join-Path $featureDir "research.md"
        DATA_MODEL = Join-Path $featureDir "data-model.md"
        QUICKSTART = Join-Path $featureDir "quickstart.md"
        CONTRACTS_DIR = Join-Path $featureDir "contracts"
    }
}

function Test-FileExists {
    param([string]$Path, [string]$Name)
    if (Test-Path $Path -PathType Leaf) {
        Write-Host "  ✓ $Name"
    } else {
        Write-Host "  ✗ $Name"
    }
}

function Test-DirectoryExists {
    param([string]$Path, [string]$Name)
    if ((Test-Path $Path -PathType Container) -and (@(Get-ChildItem $Path).Count -gt 0)) {
        Write-Host "  ✓ $Name"
    } else {
        Write-Host "  ✗ $Name"
    }
}
