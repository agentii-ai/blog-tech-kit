# blog-Kit Maintainer Guide

This guide explains how to maintain and update blog-Kit templates, add new commands, and manage releases.

## Template Update Workflow

### 1. Local Testing Before CI

Always test changes locally before pushing to main:

```bash
# Build all templates locally
./scripts/build-templates.sh v0.1.1

# Or build specific agents for faster iteration
AGENTS=claude SCRIPTS=sh ./scripts/build-templates.sh v0.1.1

# Validate templates
./scripts/validate-templates.sh dist/templates/

# Extract and inspect
unzip -d /tmp/test-template dist/templates/spec-kit-template-claude-sh-v0.1.1.zip
ls -la /tmp/test-template/.blog/
ls -la /tmp/test-template/.claude/commands/
```

### 2. Template Changes

Changes to these directories trigger automatic release builds on main:
- `memory/` - Constitution and project principles
- `scripts/` - Bash and PowerShell automation scripts
- `templates/` - Workflow templates
- `.github/workflows/` - GitHub Actions workflows

### 3. Push and Release

After merging to main, the GitHub Actions workflow automatically:

```
1. Detects changes and increments version (patch by default)
2. Builds all 36 template variants
3. Validates templates (fails if issues found)
4. Generates release notes with checksums
5. Creates GitHub release with all ZIPs attached
6. Updates pyproject.toml version
```

## Adding New Commands

### Step 1: Create Command Template

Create a new file in `templates/commands/`:

```bash
# Create new command file
cat > templates/commands/mycommand.md << 'EOF'
---
description: Short description of what this command does
scripts:
  sh: bash scripts/bash/my-script.sh --json {ARGS}
  ps: powershell scripts/powershell/my-script.ps1 -Json {ARGS}
---

## User Input

```text
$ARGUMENTS
```

Your command implementation here...
EOF
```

### Step 2: Update Script Files

Create corresponding script files:

```bash
# Bash script
cat > scripts/bash/my-script.sh << 'EOF'
#!/usr/bin/env bash
# Implementation
EOF
chmod +x scripts/bash/my-script.sh

# PowerShell script
cat > scripts/powershell/my-script.ps1 << 'EOF'
# Implementation
EOF
```

### Step 3: Test Template Generation

```bash
# Build templates with new command
./scripts/build-templates.sh v0.1.1

# Verify new command appears in all 36 variants
for zip in dist/templates/*.zip; do
  unzip -l "$zip" | grep "blogkit.mycommand" && echo "✓ Found in $(basename $zip)"
done

# Extract and test a variant
unzip -d /tmp/test dist/templates/spec-kit-template-claude-sh-v0.1.1.zip
grep -A2 "## User Input" /tmp/test/.claude/commands/blogkit.mycommand.md
```

### Step 4: Validate and Commit

```bash
# Validate all templates pass checks
./scripts/validate-templates.sh dist/templates/

# If validation passes:
git add templates/commands/mycommand.md scripts/bash/my-script.sh scripts/powershell/my-script.ps1
git commit -m "feat: Add /blogkit.mycommand slash command"
git push
```

The workflow will automatically build and release with the new command.

## Adding New Agents

### Step 1: Update Build Script

Edit `.github/workflows/scripts/create-release-packages.sh`:

```bash
# Find the ALL_AGENTS array (around line 226)
ALL_AGENTS=(
  "claude" "gemini" "copilot" "cursor-agent" "qwen" "opencode"
  "windsurf" "codex" "kilocode" "auggie" "roo" "codebuddy"
  "amp" "shai" "q" "bob" "qoder" "newagent"  # Add here
)

# Find the build_variant() function and add case block:
newagent)
  mkdir -p "$base_dir/.newagent/commands"
  generate_commands newagent md "\$ARGUMENTS" "$base_dir/.newagent/commands" "$script" ;;
```

### Step 2: Update Validation

Edit `scripts/validate-templates.sh` if agent has special structure:

```bash
# Add to check_directory_structure if needed
if [[ "$variant_name" == *"-newagent-"* ]]; then
  if [[ ! -d "$extract_dir/.newagent/commands" ]]; then
    print_fail "Missing .newagent/commands directory"
    return 1
  fi
fi
```

### Step 3: Test New Agent

```bash
# Build only the new agent
AGENTS=newagent ./scripts/build-templates.sh v0.1.1

# Validate
./scripts/validate-templates.sh dist/templates/

# Verify both script variants
unzip -l dist/templates/spec-kit-template-newagent-sh-v0.1.1.zip | grep blogkit
unzip -l dist/templates/spec-kit-template-newagent-ps-v0.1.1.zip | grep blogkit
```

### Step 4: Update Documentation

Update `docs/templates.md` and `README.md`:

```markdown
# In README.md, add to template agents list:
- NewAgent

# In docs/templates.md, add to Command Reference:
### NewAgent
- **Directory**: `.newagent/commands/`
- **Format**: Markdown with YAML frontmatter
- **Invocation**: `/blogkit.specify "your request"`
```

### Step 5: Commit and Release

```bash
git add -A
git commit -m "feat: Add NewAgent support to blog-Kit templates"
git push
```

The workflow will build 2 new variants (38 total), validate, and release.

## Version Numbering

### Semantic Versioning

- **MAJOR (X.0.0)**: Breaking changes to template structure or constitution principles removed
  - Example: Change directory structure from `.blog/` to `.spec/`
  - Requires manual version bump

- **MINOR (0.X.0)**: New commands, new agents, new constitution principles
  - Example: Add `/blogkit.review` command or support for 19th agent
  - Manual version bump in release notes

- **PATCH (0.0.X)**: Bug fixes, documentation updates, script improvements
  - Example: Fix typo in command description, improve shell script
  - Auto-incremented by build workflow

### Manual Version Bumps

For MAJOR or MINOR releases, update version manually:

```bash
# Edit the version in release notes before committing
# Example: In .github/workflows/scripts/generate-release-notes.sh
# Change: v0.1.0 → v0.2.0 (for new features)

# Or manually set when creating release
gh release create v1.0.0 dist/templates/*.zip \
  --title "blog Kit v1.0.0 - Major Release" \
  --notes-file release_notes.md
```

## Troubleshooting

### Build Fails for Specific Agent

Check the build logs:

```bash
# Run verbose build
AGENTS=problemagent SCRIPTS=sh bash -x ./scripts/build-templates.sh v0.1.1 2>&1 | tail -50

# Check if command files exist
ls templates/commands/

# Verify agent case block in create-release-packages.sh
grep -A2 "problemagent)" .github/workflows/scripts/create-release-packages.sh
```

### Validation Fails with "No agent directory"

The template extraction might be empty. Check:

```bash
# Test build directly
AGENTS=claude SCRIPTS=sh ./.github/workflows/scripts/create-release-packages.sh v0.1.1

# List what was generated
ls -la .genreleases/

# Inspect the structure
unzip -l .genreleases/spec-kit-template-claude-sh-v0.1.1.zip | head -20
```

### CI Workflow Fails

Check GitHub Actions logs:

```bash
# View workflow runs
gh run list

# Check specific run
gh run view <RUN_ID> --log

# Rerun failed workflow
gh run rerun <RUN_ID>
```

### Templates Still Using Spec-Kit References

Use grep to find and fix:

```bash
# Find all speckit references
grep -r "speckit" templates/

# Fix with sed
sed -i 's/speckit/blogkit/g' templates/commands/*.md

# Validate changes
./scripts/validate-templates.sh dist/templates/
```

## Release Checklist

Before creating a production release:

- [ ] All template changes tested locally
- [ ] `./scripts/validate-templates.sh dist/templates/` passes
- [ ] No speckit references in templates
- [ ] All 9 required commands present
- [ ] Constitution is blog-Kit v1.0.0
- [ ] Documentation updated (README.md, docs/templates.md)
- [ ] CONTRIBUTING.md reflects current process
- [ ] Changelog documented
- [ ] Version number appropriate (major/minor/patch)

## Local Development Setup

### Prerequisites

```bash
# macOS
brew install bash gnu-sed zip jq

# Linux
sudo apt-get install bash sed zip jq

# Verify versions
bash --version      # 4.0+
zip -h              # Works
shasum -a 256 /dev/null  # Works
```

### Quick Start

```bash
# Clone and enter directory
git clone https://github.com/agentii-ai/blog-kit.git
cd blog-kit

# Create feature branch
git checkout -b add-new-command

# Make your changes
# ...

# Test locally
./scripts/build-templates.sh v0.1.1
./scripts/validate-templates.sh dist/templates/

# Commit and push
git add -A
git commit -m "feat: Add new blog-Kit feature"
git push origin add-new-command
```

## Getting Help

- **Questions**: [GitHub Discussions](https://github.com/agentii-ai/blog-kit/discussions)
- **Issues**: [GitHub Issues](https://github.com/agentii-ai/blog-kit/issues)
- **Code**: [View on GitHub](https://github.com/agentii-ai/blog-kit)
- **Constitution**: See [`memory/constitution.md`](../memory/constitution.md)

## Additional Resources

- **Build Script**: `.github/workflows/scripts/create-release-packages.sh`
- **Validation Script**: `scripts/validate-templates.sh`
- **Release Workflow**: `.github/workflows/release.yml`
- **Template Structure**: `docs/templates.md`
