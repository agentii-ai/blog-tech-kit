# blog-Kit Templates

## Overview

blog-Kit templates provide a structured starting point for product-market-fit discovery projects using AI coding agents. Templates are automatically downloaded when you run `blog init`, but can also be downloaded manually from [GitHub Releases](https://github.com/agentii-ai/blog-kit/releases).

## Template Contents

Each template includes:

```
project-root/
├── .blog/                      # Shared toolkit files
│   ├── memory/
│   │   └── constitution.md       # blog-Kit constitution v1.0.0
│   ├── scripts/
│   │   ├── bash/                 # Bash automation scripts
│   │   └── powershell/           # PowerShell automation scripts
│   └── templates/
│       ├── spec-template.md      # Feature specification template
│       ├── plan-template.md      # Implementation planning template
│       └── tasks-template.md     # Task breakdown template
└── .{agent}/                      # Agent-specific directory
    ├── commands/                  # Slash command files (agent varies)
    │   ├── blogkit.specify.md     # /blogkit.specify command
    │   ├── blogkit.plan.md        # /blogkit.plan command
    │   ├── blogkit.tasks.md       # /blogkit.tasks command
    │   ├── blogkit.implement.md   # /blogkit.implement command
    │   ├── blogkit.clarify.md     # /blogkit.clarify command
    │   ├── blogkit.analyze.md     # /blogkit.analyze command
    │   ├── blogkit.checklist.md   # /blogkit.checklist command
    │   ├── blogkit.taskstoissues.md # /blogkit.taskstoissues command
    │   └── blogkit.constitution.md  # /blogkit.constitution command
    └── (other agent-specific files as needed)
```

## Command Reference

### /blogkit.specify

**Purpose**: Create or update your blog specification from a natural language description

**Usage**: `/blogkit.specify "Add user authentication to the SaaS dashboard"`

**Generates**:
- Target personas with skills and environment
- Top 3 jobs-to-be-done (customer problems)
- 1-2 hero workflows (end-to-end flows)
- Success metrics (activation, engagement, business)
- Key constraints and risks

### /blogkit.clarify

**Purpose**: Identify and resolve ambiguities in your specification

**Usage**: `/blogkit.clarify` (in a conversation with your specification)

**Resolves**:
- Unclear persona definitions
- Vague success criteria
- Missing validation criteria
- Unstated assumptions

### /blogkit.plan

**Purpose**: Create a detailed research and execution plan

**Usage**: `/blogkit.plan` (in a conversation with your specification)

**Generates**:
- Research methodology
- Sample sizes and recruitment strategy
- Data collection instruments
- Analysis approach
- Validation checkpoints

### /blogkit.tasks

**Purpose**: Break your plan into actionable research tasks

**Usage**: `/blogkit.tasks` (in a conversation with your plan)

**Generates**:
- Recruit participants
- Conduct interviews and research
- Analyze results
- Validate hypotheses
- Document learnings

### /blogkit.implement

**Purpose**: Execute your research tasks with AI assistance

**Usage**: `/blogkit.implement` (ready to execute your tasks)

**Provides**:
- Step-by-step execution guidance
- Evidence collection templates
- Analysis frameworks
- Decision-making support

### /blogkit.analyze

**Purpose**: Cross-validate your specification, plan, and tasks for consistency

**Usage**: `/blogkit.analyze`

**Checks**:
- Spec completeness and clarity
- Plan feasibility
- Task dependency ordering
- Evidence collection alignment

### /blogkit.clarify (Targeted)

**Purpose**: Ask specific clarification questions about underspecified areas

**Usage**: `/blogkit.clarify` (in a specification context)

**Generates**:
- Up to 5 targeted questions
- Question categories (customer, market, technical, business)
- Suggested answer formats

### /blogkit.checklist

**Purpose**: Create a custom checklist for your discovery project

**Usage**: `/blogkit.checklist "customer interviews"` or `/blogkit.checklist`

**Generates**:
- Custom checklist based on your needs
- Actionable items
- Success criteria for each item

### /blogkit.taskstoissues

**Purpose**: Convert your research tasks into GitHub issues

**Usage**: `/blogkit.taskstoissues`

**Creates**:
- One GitHub issue per task
- Proper dependency ordering
- Labels for priority and category
- Links to related documentation

### /blogkit.constitution

**Purpose**: Manage project-specific principles and governance

**Usage**: `/blogkit.constitution` or `/blogkit.constitution "add principle"`

**Enables**:
- View base blog-Kit constitution
- Add project-specific principles
- Define team decision-making rules
- Document governance

## Agent-Specific Information

### Claude Code
- **Directory**: `.claude/commands/`
- **Format**: Markdown with YAML frontmatter
- **Invocation**: `/blogkit.specify "your request"`

### GitHub Copilot
- **Directory**: `.github/agents/` and `.github/prompts/`
- **Format**: Special `.agent.md` and `.prompt.md` files
- **Configuration**: `.vscode/settings.json`

### Google Gemini / Qwen
- **Directory**: `.gemini/commands/` or `.qwen/commands/`
- **Format**: TOML configuration files
- **Argument syntax**: `{{args}}` instead of `$ARGUMENTS`

### Other Agents
Each agent has a specific directory structure and command format. Refer to the agent's documentation within your template for details.

## Release History

### v0.1.0 (First Release)

**Initial Release**: blog-Kit v0.1.0 introduces automated template generation for 18 AI agents (36 variants total).

**Includes**:
- blog-Kit Constitution v1.0.0
- 9 core slash commands
- Templates for spec, plan, and tasks
- Support for bash and PowerShell

**Download**: [blog-Kit v0.1.0 Release](https://github.com/agentii-ai/blog-kit/releases/tag/v0.1.0)

## Manual Template Download

If you prefer to manually manage templates:

1. Go to [GitHub Releases](https://github.com/agentii-ai/blog-kit/releases)
2. Find your desired agent version (e.g., `spec-kit-template-claude-sh-v0.1.0.zip`)
3. Download the ZIP file
4. Extract to your project root
5. All commands will be available in your AI agent

Each ZIP file includes SHA-256 checksums for verification.

## Template Customization

All templates can be customized for your specific needs:

- Modify `/specify/memory/constitution.md` to add project-specific principles
- Edit template files in `/specify/templates/` for your workflow
- Customize command files in `.{agent}/commands/` for agent-specific tweaks
- Add new commands by copying and modifying existing templates

## Support

For issues, questions, or contributions:
- **Issues**: [GitHub Issues](https://github.com/agentii-ai/blog-kit/issues)
- **Discussions**: [GitHub Discussions](https://github.com/agentii-ai/blog-kit/discussions)
- **Documentation**: [blog-Kit Docs](https://github.com/agentii-ai/blog-kit#-reference-documentation)

## Contributing

We welcome contributions to improve blog-Kit templates:

1. Fork the repository
2. Create a feature branch: `git checkout -b improve-templates`
3. Make your changes to `templates/commands/` or documentation
4. Test locally: `./scripts/validate-templates.sh dist/templates/`
5. Submit a pull request

See [CONTRIBUTING.md](../CONTRIBUTING.md) for detailed guidelines.
