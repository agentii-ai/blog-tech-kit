#!/usr/bin/env bash
set -euo pipefail

VERSION="${1:-v0.1.0}"
GENRELEASES_DIR="${GENRELEASES_DIR:-.genreleases}"
BLOGKIT_SOURCE=".blogkit"

# All supported AI agents
ALL_AGENTS=(
  claude cursor-agent windsurf gemini copilot qoder qwen opencode
  codex kilocode auggie roo codebuddy amp shai q bob
)

mkdir -p "$GENRELEASES_DIR"

# Function to get agent-specific directory
get_agent_dir() {
  local agent=$1
  case "$agent" in
    claude) echo ".claude/commands" ;;
    cursor-agent) echo ".cursor/commands" ;;
    windsurf) echo ".windsurf/workflows" ;;
    gemini) echo ".gemini/commands" ;;
    copilot) echo ".github/agents" ;;
    qoder) echo ".qoder/commands" ;;
    qwen) echo ".qwen/commands" ;;
    opencode) echo ".opencode/command" ;;
    codex) echo ".codex/prompts" ;;
    kilocode) echo ".kilocode/workflows" ;;
    auggie) echo ".augment/commands" ;;
    roo) echo ".roo/commands" ;;
    codebuddy) echo ".codebuddy/commands" ;;
    amp) echo ".agents/commands" ;;
    shai) echo ".shai/commands" ;;
    q) echo ".amazonq/prompts" ;;
    bob) echo ".bob/commands" ;;
    *) echo ".${agent}/commands" ;;
  esac
}

# Function to get file extension for agent
get_file_extension() {
  local agent=$1
  case "$agent" in
    gemini|qwen) echo ".toml" ;;
    copilot) echo ".agent.md" ;;
    *) echo ".md" ;;
  esac
}

# Function to generate commands for a specific agent
generate_commands() {
  local agent=$1
  local script=$2  # sh or ps
  local base_dir=$3
  local agent_dir=$(get_agent_dir "$agent")
  local file_ext=$(get_file_extension "$agent")
  
  mkdir -p "$base_dir/$agent_dir"
  
  # Special handling for copilot (needs both agents and prompts dirs)
  if [[ "$agent" == "copilot" ]]; then
    mkdir -p "$base_dir/.github/prompts"
  fi
  
  # Process each command template
  for template in "$BLOGKIT_SOURCE/templates/commands/blogkit."*.md; do
    [[ -f "$template" ]] || continue
    
    local cmd_name=$(basename "$template" .md)
    local cmd_basename="${cmd_name#blogkit.}"
    local target_file="$base_dir/$agent_dir/blogkit.${cmd_basename}${file_ext}"
    
    # For copilot, also create prompt files
    if [[ "$agent" == "copilot" ]]; then
      local prompt_file="$base_dir/.github/prompts/blogkit.${cmd_basename}.prompt.md"
      # Transform template
      sed "s/__AGENT__/blogkit.${cmd_basename}/g" "$template" | \
      sed "s/{SCRIPT}/${script}/g" | \
      sed "s|\.specify/scripts/bash/|.blogkit/scripts/bash/|g" | \
      sed "s|\.specify/scripts/powershell/|.blogkit/scripts/powershell/|g" > "$prompt_file"
    fi
    
    # Transform template for the main command file
    if [[ "$file_ext" == ".toml" ]]; then
      # TOML format uses {{args}} instead of $ARGUMENTS
      sed "s/__AGENT__/blogkit.${cmd_basename}/g" "$template" | \
      sed "s/{SCRIPT}/${script}/g" | \
      sed 's/\$ARGUMENTS/{{args}}/g' | \
      sed "s|\.specify/scripts/bash/|.blogkit/scripts/bash/|g" | \
      sed "s|\.specify/scripts/powershell/|.blogkit/scripts/powershell/|g" > "$target_file"
    else
      sed "s/__AGENT__/blogkit.${cmd_basename}/g" "$template" | \
      sed "s/{SCRIPT}/${script}/g" | \
      sed "s|\.specify/scripts/bash/|.blogkit/scripts/bash/|g" | \
      sed "s|\.specify/scripts/powershell/|.blogkit/scripts/powershell/|g" > "$target_file"
    fi
  done
}

# Function to build a single variant
build_variant() {
  local agent=$1
  local script=$2  # sh or ps
  local version=$3
  
  local variant_name="blog-tech-kit-template-${agent}-${script}-${version}"
  local base_dir="$GENRELEASES_DIR/$variant_name"
  
  echo "Building $variant_name from $BLOGKIT_SOURCE..."
  
  # Create .blogkit/ working directory structure (Option B)
  mkdir -p "$base_dir/.blogkit/memory"
  mkdir -p "$base_dir/.blogkit/templates"
  mkdir -p "$base_dir/.blogkit/scripts"
  
  # Copy from .blogkit/ source to .blogkit/ target
  cp "$BLOGKIT_SOURCE/memory/constitution.md" "$base_dir/.blogkit/memory/"
  cp -r "$BLOGKIT_SOURCE/templates/"*.md "$base_dir/.blogkit/templates/" 2>/dev/null || true
  
  if [[ "$script" == "sh" ]]; then
    cp -r "$BLOGKIT_SOURCE/scripts/bash" "$base_dir/.blogkit/scripts/"
  else
    cp -r "$BLOGKIT_SOURCE/scripts/powershell" "$base_dir/.blogkit/scripts/"
  fi
  
  # Generate agent-specific commands
  generate_commands "$agent" "$script" "$base_dir"
  
  # Create ZIP
  (cd "$GENRELEASES_DIR" && zip -r "${variant_name}.zip" "$variant_name" > /dev/null)
  
  # Calculate checksum
  local checksum=$(shasum -a 256 "$GENRELEASES_DIR/${variant_name}.zip" | cut -d' ' -f1)
  echo "  Created ${variant_name}.zip (sha256: ${checksum:0:16}...)"
  
  # Cleanup temp directory
  rm -rf "$base_dir"
}

# Main build loop
echo "Building Blog-Tech-Kit templates v$VERSION from $BLOGKIT_SOURCE source..."
echo "Output directory: $GENRELEASES_DIR"
echo "Target structure: .blogkit/ (Option B: Dedicated directory)"
echo ""

total=0
for agent in "${ALL_AGENTS[@]}"; do
  for script in sh ps; do
    build_variant "$agent" "$script" "$VERSION"
    total=$((total + 1))
  done
done

echo ""
echo "✅ Generated $total template variants"
ls -1 "$GENRELEASES_DIR"/*.zip | wc -l | xargs echo "Total ZIP files:"
