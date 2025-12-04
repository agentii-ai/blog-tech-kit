# Data Model: Automated Template Release Generation

**Feature**: Automated template release generation for multiple AI agents
**Branch**: 002-automated-template-releases
**Date**: 2025-12-04

## Overview

This document defines the key entities, their relationships, and validation rules for the automated template release generation system. These entities represent the domain model for generating, validating, and publishing blog-Kit templates across 18 AI agents and 2 script variants.

---

## Core Entities

### Entity: TemplateVariant

**Description**: A unique combination of agent type and script type representing one of the 36 template archives to be generated and released.

**Fields**:
- `agent` (string, required): The AI agent identifier (e.g., "claude", "cursor-agent", "gemini")
- `script` (string, required): The script type ("sh" for bash, "ps" for PowerShell)
- `version` (string, required): Semantic version with 'v' prefix (e.g., "v0.1.0")
- `archive_name` (string, computed): Full ZIP filename (e.g., "spec-kit-template-claude-sh-v0.1.0.zip")
- `size_bytes` (integer, computed): Size of the generated ZIP file
- `sha256` (string, computed): SHA-256 checksum of the ZIP file
- `build_status` (enum): "pending" | "building" | "completed" | "failed"
- `error_message` (string, optional): Error details if build_status is "failed"

**Validation Rules**:
- `agent` MUST be one of: claude, cursor-agent, windsurf, gemini, copilot, qoder, qwen, opencode, codex, kilocode, auggie, codebuddy, amp, shai, q, bob, roo
- `script` MUST be either "sh" or "ps"
- `version` MUST match pattern `^v[0-9]+\.[0-9]+\.[0-9]+$`
- `archive_name` MUST follow pattern `spec-kit-template-{agent}-{script}-{version}.zip`
- `sha256` MUST be exactly 64 hexadecimal characters when computed

**State Transitions**:
```
pending → building → completed
        ↓
        → failed
```

**Example**:
```json
{
  "agent": "claude",
  "script": "sh",
  "version": "v0.1.0",
  "archive_name": "spec-kit-template-claude-sh-v0.1.0.zip",
  "size_bytes": 55400,
  "sha256": "25a65e13d93e74295c9b7dba3dcaf9a28cf5c141a24319a91ef7e7ecc171fbbe",
  "build_status": "completed",
  "error_message": null
}
```

**Relationships**:
- Belongs to one `Release`
- Contains one `TemplateStructure`
- Has multiple `CommandFile` instances
- References one `AgentConfiguration`

---

### Entity: AgentConfiguration

**Description**: Metadata defining how templates are structured for a specific AI agent.

**Fields**:
- `agent_id` (string, required, unique): Agent identifier (e.g., "claude")
- `display_name` (string, required): Human-readable name (e.g., "Claude Code")
- `command_directory` (string, required): Path to commands directory (e.g., ".claude/commands")
- `file_extension` (string, required): Command file extension ("md" | "toml" | "agent.md")
- `argument_format` (string, required): How arguments are passed ("$ARGUMENTS" | "{{args}}")
- `supports_prompts` (boolean): Whether agent supports .prompt.md files (Copilot-specific)
- `requires_vscode_settings` (boolean): Whether to generate .vscode/settings.json (Copilot)

**Validation Rules**:
- `agent_id` MUST be unique across all configurations
- `command_directory` MUST start with a dot (e.g., ".claude/")
- `file_extension` MUST be one of: "md", "toml", "agent.md"
- `argument_format` MUST be either "$ARGUMENTS" or "{{args}}"

**Example**:
```json
{
  "agent_id": "claude",
  "display_name": "Claude Code",
  "command_directory": ".claude/commands",
  "file_extension": "md",
  "argument_format": "$ARGUMENTS",
  "supports_prompts": false,
  "requires_vscode_settings": false
}
```

**Relationships**:
- Has many `TemplateVariant` instances (one per script type)
- Defines structure for `TemplateStructure`

**Constants** (from create-release-packages.sh):
```javascript
ALL_AGENTS = [
  "claude", "gemini", "copilot", "cursor-agent", "qwen", "opencode",
  "windsurf", "codex", "kilocode", "auggie", "roo", "codebuddy",
  "amp", "shai", "q", "bob", "qoder"
]
```

---

### Entity: TemplateStructure

**Description**: The directory and file structure of a generated template variant.

**Fields**:
- `root_directory` (string, required): Temporary build directory path
- `specify_directory` (string, required): Path to .specify/ directory
- `agent_directory` (string, required): Path to agent-specific directory (e.g., .claude/)
- `memory_files` (array of strings): List of files in .specify/memory/
- `script_files` (array of strings): List of files in .specify/scripts/{bash|powershell}/
- `template_files` (array of strings): List of files in .specify/templates/
- `command_files` (array of strings): List of command files in agent directory
- `total_files` (integer, computed): Total number of files in structure

**Validation Rules**:
- `specify_directory` MUST contain subdirectories: memory/, scripts/, templates/
- `memory_files` MUST include "constitution.md"
- `template_files` MUST include "spec-template.md", "plan-template.md", "tasks-template.md"
- `command_files` MUST all start with "blogkit." prefix
- `command_files` MUST include at minimum: specify, plan, tasks, implement, clarify, analyze, checklist
- Script files MUST match the variant's script type (bash for sh, powershell for ps)

**Required Files**:
```
.specify/
├── memory/
│   └── constitution.md (REQUIRED)
├── scripts/
│   ├── bash/ (REQUIRED for sh variants)
│   │   ├── common.sh
│   │   ├── create-new-feature.sh
│   │   ├── setup-plan.sh
│   │   ├── update-agent-context.sh
│   │   └── check-prerequisites.sh
│   └── powershell/ (REQUIRED for ps variants)
│       └── (corresponding .ps1 files)
└── templates/
    ├── spec-template.md (REQUIRED)
    ├── plan-template.md (REQUIRED)
    ├── tasks-template.md (REQUIRED)
    ├── checklist-template.md (REQUIRED)
    └── agent-file-template.md (REQUIRED)

.{agent}/
└── commands/ (or prompts/, workflows/)
    ├── blogkit.specify.md (REQUIRED)
    ├── blogkit.plan.md (REQUIRED)
    ├── blogkit.tasks.md (REQUIRED)
    ├── blogkit.implement.md (REQUIRED)
    ├── blogkit.clarify.md (REQUIRED)
    ├── blogkit.analyze.md (REQUIRED)
    ├── blogkit.checklist.md (REQUIRED)
    ├── blogkit.taskstoissues.md (REQUIRED)
    └── blogkit.constitution.md (REQUIRED)
```

**Relationships**:
- Belongs to one `TemplateVariant`
- Contains multiple `CommandFile` instances

---

### Entity: CommandFile

**Description**: A slash command definition file for AI agents with YAML frontmatter and markdown body.

**Fields**:
- `command_name` (string, required): Command identifier (e.g., "specify", "plan", "tasks")
- `file_name` (string, required): Full filename (e.g., "blogkit.specify.md")
- `agent` (string, required): Agent namespace (MUST be "blogkit.{command_name}")
- `description` (string, required): Short description of command purpose
- `script_command` (string, required): Shell command to execute (resolved from template)
- `agent_script_command` (string, optional): Alternative script for agent-specific contexts
- `body` (string, required): Markdown content with instructions for AI agent
- `has_speckit_references` (boolean, computed): Whether body contains "/speckit." references

**Validation Rules**:
- `file_name` MUST match pattern `blogkit.{command_name}.{extension}`
- `agent` MUST match pattern `blogkit.{command_name}` (NOT `speckit.*`)
- `description` MUST be 3-100 characters
- `script_command` MUST be resolved (not contain "{SCRIPT}" placeholder)
- `body` MUST NOT contain "/speckit." references (MUST use "/blogkit.")
- `body` MUST NOT contain unresolved placeholders like "{SCRIPT}", "{ARGS}"

**YAML Frontmatter Structure**:
```yaml
---
agent: blogkit.specify
description: Create or update the feature specification from a natural language feature description.
---
```

**Example** (blogkit.specify.md):
```markdown
---
agent: blogkit.specify
description: Create or update the feature specification from a natural language feature description.
---

## User Input

```text
{user's input}
```

You **MUST** consider the user input before proceeding.

[... rest of command body ...]
```

**Relationships**:
- Belongs to one `TemplateStructure`
- References one `AgentConfiguration` (for formatting)
- Derived from one `CommandTemplate`

---

### Entity: CommandTemplate

**Description**: Source template file used to generate agent-specific command files.

**Fields**:
- `template_name` (string, required): Base template name (e.g., "specify", "plan")
- `source_path` (string, required): Path to template file (e.g., "templates/commands/specify.md")
- `description` (string, required): Command description from frontmatter
- `bash_script` (string, required): Script command for bash variants (from `scripts.sh` in frontmatter)
- `powershell_script` (string, required): Script command for PowerShell variants (from `scripts.ps` in frontmatter)
- `bash_agent_script` (string, optional): Alternative bash script (from `agent_scripts.sh` in frontmatter)
- `powershell_agent_script` (string, optional): Alternative PowerShell script (from `agent_scripts.ps`)
- `body_template` (string, required): Markdown body with placeholders

**Validation Rules**:
- `source_path` MUST exist in repository
- Frontmatter MUST contain `description` field
- Frontmatter MUST contain `scripts.sh` and `scripts.ps` fields
- `body_template` MAY contain placeholders: {SCRIPT}, {AGENT_SCRIPT}, {ARGS}, __AGENT__
- Template MUST NOT contain hardcoded agent names (use __AGENT__ placeholder)

**Frontmatter Structure**:
```yaml
---
description: Command description here
scripts:
  sh: bash /path/to/script.sh --json $ARGUMENTS
  ps: powershell /path/to/script.ps1 -Json $ARGUMENTS
agent_scripts:
  sh: bash /path/to/agent-script.sh $ARGUMENTS
  ps: powershell /path/to/agent-script.ps1 $ARGUMENTS
---
```

**Transformation Process**:
1. Extract frontmatter and body from source template
2. Select script command based on variant's script type (sh/ps)
3. Replace `{SCRIPT}` placeholder with selected script command
4. Replace `{AGENT_SCRIPT}` with agent script if present
5. Replace `{ARGS}` with agent-specific argument format
6. Replace `__AGENT__` with agent ID
7. Rewrite paths (memory/ → .specify/memory/, scripts/ → .specify/scripts/, templates/ → .specify/templates/)
8. Remove `scripts:` and `agent_scripts:` sections from frontmatter
9. Write to agent-specific directory with blogkit prefix

**Relationships**:
- Generates multiple `CommandFile` instances (one per agent × script combination)

---

### Entity: Release

**Description**: A GitHub release containing all 36 template variant archives for a specific version.

**Fields**:
- `version` (string, required, unique): Semantic version with 'v' prefix (e.g., "v0.1.0")
- `tag_name` (string, required): Git tag name (same as version)
- `release_name` (string, required): Display name (e.g., "blog Kit Templates - 0.1.0")
- `created_at` (datetime, computed): Release creation timestamp
- `published_at` (datetime, computed): Release publication timestamp
- `release_notes` (string, required): Markdown-formatted release notes
- `changelog` (array of strings): List of commit messages since last release
- `asset_count` (integer, computed): Number of attached ZIP files (should be 36)
- `total_size_bytes` (integer, computed): Sum of all asset sizes
- `release_url` (string, computed): GitHub release page URL
- `previous_version` (string, optional): Previous release version for changelog generation

**Validation Rules**:
- `version` MUST be unique (no duplicate releases)
- `version` MUST be semantic versioning format with 'v' prefix
- `asset_count` SHOULD equal 36 (18 agents × 2 scripts)
- All assets MUST have corresponding SHA-256 checksums in release notes
- `release_notes` MUST contain changelog section
- `release_notes` MUST list all 36 template variants with checksums

**Release Notes Format**:
```markdown
This is the latest set of releases that you can use with your agent of choice.
We recommend using the blog CLI to scaffold your projects, however you can
download these independently and manage them yourself.

## Changelog

- commit message 1
- commit message 2
...

## Assets

36 template variants:

spec-kit-template-amp-ps-v0.1.0.zip
sha256:ab45d3232885256660a359ff1e8fa5f9ffad6e44a9b8527dab06b984bf84270e
53.7 KB

spec-kit-template-amp-sh-v0.1.0.zip
sha256:218ecdd4e2dbad8c0380dfe61e0f45ec569a1f41ae3b02b0cde89f5acd9940c9
55.4 KB

[... 34 more variants ...]
```

**State Transitions**:
```
draft → generating_assets → uploading_assets → published
```

**Relationships**:
- Has many `TemplateVariant` instances (36 total)
- Has many `ReleaseAsset` instances (36 ZIPs)
- May reference previous `Release` for changelog

---

### Entity: ReleaseAsset

**Description**: A single ZIP file attached to a GitHub release.

**Fields**:
- `asset_id` (string, required): GitHub asset ID (assigned by API)
- `file_name` (string, required): ZIP filename (e.g., "spec-kit-template-claude-sh-v0.1.0.zip")
- `file_path` (string, required): Local path to ZIP file before upload
- `size_bytes` (integer, required): File size in bytes
- `sha256` (string, required): SHA-256 checksum
- `content_type` (string): MIME type ("application/zip")
- `download_url` (string, computed): GitHub CDN download URL
- `upload_status` (enum): "pending" | "uploading" | "completed" | "failed"
- `download_count` (integer, computed): Number of times downloaded (from GitHub API)

**Validation Rules**:
- `file_name` MUST match pattern `spec-kit-template-{agent}-{script}-v{version}.zip`
- `size_bytes` MUST be > 0 and < 2GB (GitHub limit)
- `sha256` MUST be 64 hexadecimal characters
- `content_type` MUST be "application/zip"
- ZIP file MUST extract without errors
- ZIP file MUST contain valid `TemplateStructure`

**Relationships**:
- Belongs to one `Release`
- Represents one `TemplateVariant`

---

### Entity: BuildManifest

**Description**: A JSON document recording metadata about all templates generated in a build.

**Fields**:
- `build_id` (string, required): Unique build identifier (timestamp-based)
- `version` (string, required): Version being built
- `build_started_at` (datetime, required): Build start time
- `build_completed_at` (datetime, optional): Build completion time
- `build_duration_seconds` (integer, computed): Time to build all variants
- `variants` (array of TemplateVariant): All 36 variants with metadata
- `total_size_bytes` (integer, computed): Sum of all variant sizes
- `failed_variants` (array of strings): List of variants that failed to build
- `environment` (object): Build environment info (OS, bash version, git commit)

**Validation Rules**:
- `variants` array MUST contain 36 elements (or match AGENTS × SCRIPTS count)
- All variants MUST have `build_status` of "completed" or "failed"
- `build_completed_at` MUST be after `build_started_at`
- `failed_variants` MUST be empty for successful release

**Example**:
```json
{
  "build_id": "20251204-153045",
  "version": "v0.1.0",
  "build_started_at": "2025-12-04T15:30:45Z",
  "build_completed_at": "2025-12-04T15:33:12Z",
  "build_duration_seconds": 147,
  "variants": [
    {
      "agent": "claude",
      "script": "sh",
      "archive_name": "spec-kit-template-claude-sh-v0.1.0.zip",
      "size_bytes": 55400,
      "sha256": "25a65e13...",
      "build_status": "completed"
    },
    // ... 35 more variants
  ],
  "total_size_bytes": 1987654,
  "failed_variants": [],
  "environment": {
    "os": "ubuntu-latest",
    "bash_version": "5.1.16",
    "git_commit": "c527ae7"
  }
}
```

**Relationships**:
- References one `Release`
- Contains metadata for all `TemplateVariant` instances in that release

---

### Entity: ValidationReport

**Description**: Results of validating a template variant against quality rules.

**Fields**:
- `variant_id` (string, required): Agent-script combination (e.g., "claude-sh")
- `version` (string, required): Version being validated
- `validation_passed` (boolean, required): Overall pass/fail status
- `checks` (array of ValidationCheck): Individual validation checks performed
- `errors` (array of strings): List of error messages
- `warnings` (array of strings): List of warning messages
- `validated_at` (datetime, required): When validation ran

**ValidationCheck Structure**:
```json
{
  "check_name": "frontmatter_namespace",
  "description": "Verify all commands use blogkit.* namespace",
  "passed": true,
  "details": "All 9 command files have correct agent: blogkit.* frontmatter"
}
```

**Validation Checks** (from spec FR-018 to FR-022):
1. **Frontmatter Namespace**: All command files use `agent: blogkit.*` (not `speckit.*`)
2. **Required Files Present**: Constitution, templates, scripts, commands all exist
3. **No Spec-Kit References**: Body content contains no `/speckit.` references
4. **Directory Structure**: .specify/ and agent directories correctly structured
5. **Constitution Version**: Includes blog-Kit constitution v1.0.0
6. **Command Completeness**: All 9 required commands present (specify, plan, tasks, implement, clarify, analyze, checklist, taskstoissues, constitution)
7. **Script Consistency**: Bash variants only contain bash/, PowerShell variants only contain powershell/
8. **Path References**: All paths use .specify/ prefix (not relative paths)
9. **ZIP Integrity**: Archive extracts without errors

**Validation Rules**:
- `validation_passed` MUST be false if any errors exist
- `checks` array MUST contain at least 9 validation checks
- Errors MUST block release, warnings SHOULD be addressed but don't block

**Relationships**:
- Validates one `TemplateVariant`
- Generated during CI build process

---

## Entity Relationships Diagram

```
Release (1) ----< (36) TemplateVariant
                        |
                        | (1)
                        v
                  TemplateStructure
                        |
                        | (*)
                        v
                  CommandFile
                        ^
                        | derives from
                        |
                  CommandTemplate

Release (1) ----< (36) ReleaseAsset

TemplateVariant (1) --- (1) AgentConfiguration

BuildManifest (1) --- (*) TemplateVariant metadata

ValidationReport (*) --- (1) TemplateVariant
```

**Cardinalities**:
- One Release → 36 TemplateVariants
- One Release → 36 ReleaseAssets
- One TemplateVariant → 1 TemplateStructure
- One TemplateStructure → 9+ CommandFiles
- One CommandTemplate → 36 CommandFiles (18 agents × 2 scripts)
- One TemplateVariant → 1 AgentConfiguration (many-to-one)

---

## Data Flow

### Build Process Flow

```
1. CommandTemplate (source)
   ↓ [read templates/commands/*.md]
2. AgentConfiguration (metadata)
   ↓ [select agent-specific settings]
3. TemplateStructure (created)
   ↓ [copy memory/, scripts/, templates/]
4. CommandFile (generated)
   ↓ [apply transformations]
5. TemplateVariant (archived)
   ↓ [zip structure]
6. ReleaseAsset (uploaded)
   ↓ [attach to GitHub release]
7. Release (published)
```

### Validation Flow

```
1. TemplateVariant (built)
   ↓ [extract ZIP]
2. TemplateStructure (inspected)
   ↓ [check directories and files]
3. CommandFile (scanned)
   ↓ [validate frontmatter and content]
4. ValidationReport (generated)
   ↓ [aggregate results]
5. Decision (pass/fail)
   → Pass: Continue to upload
   → Fail: Abort release
```

---

## Computed Fields & Algorithms

### SHA-256 Checksum Calculation

```bash
# For ReleaseAsset.sha256 and TemplateVariant.sha256
sha256=$(shasum -a 256 "${zip_file}" | cut -d' ' -f1)
```

### Archive Name Generation

```bash
# For TemplateVariant.archive_name
archive_name="spec-kit-template-${agent}-${script}-${version}.zip"
```

### Version Detection

```bash
# For Release.version (auto-increment)
latest_tag=$(git describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
if [[ $latest_tag =~ ^v([0-9]+)\.([0-9]+)\.([0-9]+)$ ]]; then
  patch=$((${BASH_REMATCH[3]} + 1))
  new_version="v${BASH_REMATCH[1]}.${BASH_REMATCH[2]}.${patch}"
else
  new_version="v0.0.1"
fi
```

### Path Rewriting

```bash
# For CommandFile.body transformation
body=$(echo "$body" | sed -E \
  -e 's@(/?)memory/@.specify/memory/@g' \
  -e 's@(/?)scripts/@.specify/scripts/@g' \
  -e 's@(/?)templates/@.specify/templates/@g')
```

---

## Invariants

### System-Wide Invariants

1. **Complete Release**: Every Release MUST have exactly 36 ReleaseAssets
2. **Unique Versions**: No two Releases can have the same version string
3. **Namespace Consistency**: All CommandFiles MUST use "blogkit.*" namespace
4. **Constitution Presence**: Every TemplateStructure MUST include constitution.md v1.0.0
5. **Archive Naming**: All ReleaseAssets MUST follow `spec-kit-template-{agent}-{script}-{version}.zip` pattern
6. **Checksum Integrity**: Every ReleaseAsset MUST have valid SHA-256 checksum in release notes

### Per-Variant Invariants

1. **Script Consistency**: sh variants contain only bash/, ps variants contain only powershell/
2. **Command Completeness**: All variants contain the same 9 command files
3. **Required Templates**: All variants include spec-template.md, plan-template.md, tasks-template.md
4. **Agent Directory**: Each variant has exactly one agent-specific directory (e.g., .claude/ or .cursor/)

---

## Extension Points

### Adding New Agents

To add a new agent (e.g., "newagent"):

1. Add to `ALL_AGENTS` array in create-release-packages.sh
2. Create `AgentConfiguration` entry with directory structure
3. Add case block in `build_variant()` function
4. Update validation to include new agent
5. Expect 38 variants (19 agents × 2 scripts)

### Adding New Commands

To add a new command (e.g., "blogkit.review"):

1. Create `templates/commands/review.md` with frontmatter
2. Include `scripts.sh` and `scripts.ps` in frontmatter
3. Build process auto-generates for all agents
4. Update `TemplateStructure` required files list
5. Update validation to check for new command

### Adding New Script Types

To add new script type (e.g., "py" for Python):

1. Add to `ALL_SCRIPTS` array
2. Create `scripts/python/` directory
3. Update `generate_commands()` to handle "py" variant
4. Update `build_variant()` to copy python scripts
5. Expect 54 variants (18 agents × 3 scripts)

---

**Data Model Complete**: All entities, relationships, and validation rules defined.
