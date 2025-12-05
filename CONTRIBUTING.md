# Contributing to Blog-Tech-Kit

Thank you for your interest in contributing to blog-tech-kit! This guide explains how to contribute and how to create new kit variants using the same framework.

## Code of Conduct

This project is forked from spec-kit and maintains the same ethical standards:
- Treat all community members with respect
- Provide constructive feedback
- Focus on ideas and improvements, not personalities
- Help create an inclusive community

## Types of Contributions

### 1. Bug Reports

Found an issue? Please report it!

**What to include**:
- How to reproduce the issue
- Expected behavior vs. actual behavior
- Your environment (OS, Python version, uv version)
- Error messages or logs

### 2. Feature Requests

Have an idea for improvement?

**Provide**:
- Clear description of the feature
- Use cases and why it's valuable
- How it fits into blog-tech-kit workflow
- Any constraints or edge cases

### 3. Documentation Improvements

Help improve guides, templates, and examples!

**Areas needing help**:
- Clearer examples for each blog type
- Troubleshooting guide expansion
- Case studies from real blogs
- Video tutorials
- Non-English translations

### 4. Code Contributions

Contribute new features or improvements!

### 5. Template & Command Improvements

Enhance the slash commands or templates:
- Improve content generation logic
- Add new checklist items
- Optimize validation gates
- Expand reference documentation

## Development Setup

### Prerequisites

```bash
# Python 3.11+
python3 --version

# uv package manager
curl -LsSf https://astral.sh/uv/install.sh | sh

# Git
git --version
```

### Getting Started

```bash
# 1. Clone the repository
git clone https://github.com/[org]/blog-tech-kit.git
cd blog-tech-kit

# 2. Create feature branch
git checkout -b feature/your-feature-name

# 3. Activate Python environment
python3 -m venv venv
source venv/bin/activate

# 4. Install development dependencies
uv sync

# 5. Run tests (if any)
pytest

# 6. Make your changes

# 7. Test locally
uv tool install -e .

# 8. Submit pull request
```

## Directory Structure

```
blog-tech-kit/
├── src/blog_cli/              # Main CLI package
│   ├── __init__.py
│   ├── cli.py                 # Command definitions
│   ├── config.py              # Configuration management
│   └── utils.py               # Utilities
├── .blogkit/                  # Blog-tech-kit specific files
│   ├── memory/
│   │   └── constitution.md    # Governance principles
│   ├── scripts/
│   │   └── bash/              # Utility scripts
│   ├── templates/             # Template files
│   │   ├── spec-template.md
│   │   ├── plan-template.md
│   │   ├── tasks-template.md
│   │   ├── blog-post-template.md
│   │   └── commands/          # Slash command templates
│   └── execution-state.md     # Progress tracking
├── refs/                      # Reference documentation
├── specs/                     # Feature specifications
└── tests/                     # Test files
```

## Making Changes

### 1. Follow Code Style

```python
# Use type hints
def create_blog_post(title: str, content: str) -> dict:
    """Create a new blog post."""
    pass

# Use docstrings
class BlogPost:
    """Represents a blog post with metadata."""
    pass
```

### 2. Update Documentation

- Update README.md if behavior changes
- Add examples to template comments
- Document any new principles in constitution.md
- Update refs/ guides if creating new content

### 3. Test Your Changes

```bash
# Test locally
uv tool install . --force

# Test your command
blog --help
blog init test-project

# Run any automated tests
pytest
```

### 4. Commit With Clear Messages

```bash
# Format: [TYPE] Brief description
# Types: feature, fix, docs, refactor, test

git commit -m "feature: Add new blog type for technical tutorials"
git commit -m "fix: Resolve ContentFirst validation bug"
git commit -m "docs: Expand CONTRIBUTING guide with examples"
```

## Creating New Kit Variants

Blog-tech-kit demonstrates a **namespace strategy** that enables multiple kit variants:

### Strategy Overview

Each kit variant gets:
1. **Dedicated CLI command** - `blog`, `specify`, `pm`, `design`, etc.
2. **Dedicated directory** - `.blogkit/`, `.specify/`, `.pmkit/`, `.designkit/`, etc.
3. **Dedicated slash commands** - `/blogkit.*`, `/speckit.*`, `/pmkit.*`, etc.
4. **Dedicated templates** - In `[kit]kit/templates/`
5. **Dedicated constitution** - In `[kit]kit/memory/constitution.md`

### How to Create a New Kit Variant

**Example: Creating PM-Kit for Project Management**

#### Step 1: Fork or Create Base

```bash
# Option A: Fork from spec-kit
git clone https://github.com/[org]/spec-kit.git pm-kit

# Option B: Fork from blog-tech-kit to reuse namespace strategy
git clone https://github.com/[org]/blog-tech-kit.git pm-kit
```

#### Step 2: Update Namespace

```bash
# Rename .blogkit/ to .pmkit/
mv .blogkit/ .pmkit/

# Update all references in src/pm_cli/cli.py:
# - Change "blog" → "pm"
# - Change ".blogkit/" → ".pmkit/"
# - Change "/blogkit." → "/pmkit."

# Update pyproject.toml:
# - Package name: "pm-cli"
# - Command: "pm"
# - Description: "Project management kit variant"
```

#### Step 3: Adapt Templates & Commands

```bash
# Adapt templates for PM use case:
# - Remove blog-specific sections
# - Add project management sections
# - Create PM-specific checklists
# - Define PM governance principles

# Update .pmkit/memory/constitution.md with PM principles
```

#### Step 4: Define PM-Specific Commands

Create new slash commands in `.pmkit/templates/commands/`:
- `/pmkit.specify` - Project requirements specification
- `/pmkit.plan` - Project implementation plan
- `/pmkit.tasks` - Task breakdown with dependencies
- `[etc]`

#### Step 5: Test Multi-Kit Coexistence

```bash
# Install both blog-tech-kit and pm-kit
uv tool install blog-cli --from ./blog-tech-kit
uv tool install pm-cli --from ./pm-kit

# Verify both CLI commands work
blog --help
pm --help

# Create projects with each
blog init my-blog
pm init my-project

# Verify namespace isolation
ls -la my-blog/.blogkit/
ls -la my-project/.pmkit/
```

### Namespace Strategy Benefits

✅ **No CLI conflicts** - Each kit has unique command
✅ **No directory conflicts** - `.blogkit/`, `.pmkit/`, `.designkit/`, etc.
✅ **No slash command conflicts** - `/blogkit.*`, `/pmkit.*`, `/designkit.*`
✅ **Easy switching** - `blog init --here --force` or `pm init --here --force`
✅ **Scalable** - Can add unlimited kit variants
✅ **Multi-kit teams** - Use multiple kits for different projects

### Kit Variant Checklist

When creating a new kit variant:

- [ ] Rename `.blogkit/` → `.{{ kit }}kit/`
- [ ] Update CLI command in `src/{{ kit }}_cli/cli.py`
- [ ] Update package name in `pyproject.toml`
- [ ] Update all template paths to use new directory
- [ ] Create {{ kit }}-specific constitution.md
- [ ] Adapt all templates (spec, plan, tasks)
- [ ] Create {{ kit }}-specific slash commands
- [ ] Update README.md with kit-specific examples
- [ ] Test CLI installation and multi-kit coexistence
- [ ] Document in CONTRIBUTING.md

## Pull Request Process

1. **Fork the repository** and create a feature branch
2. **Make your changes** with clear commits
3. **Update documentation** (README.md, CONTRIBUTING.md)
4. **Test locally** to ensure everything works
5. **Submit PR** with:
   - Clear description of changes
   - Related issue numbers (if any)
   - Evidence of testing
   - Screenshots (if UI-related)

## Review Process

- At least one maintainer review required
- Check for code quality, style, and completeness
- Verify documentation is updated
- Ensure multi-kit coexistence still works
- Provide feedback and iterate

## Questions?

- **Documentation**: Check README.md, refs/ directory
- **Examples**: See specs/000-blog-tech-kit-foundation/ folder
- **Issues**: Open a GitHub issue for discussion

---

**Thank you for contributing to blog-tech-kit!**

Together we're building tools that make it easier to create high-quality, strategic blogs and documentation.
