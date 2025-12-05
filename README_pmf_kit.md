<div align="center">
    <img src="./media/logo.png" alt="PMF Kit Logo" width="200" height="200"/>
    <h1>🎯 PMF Kit</h1>
    <h3><em>Discover and validate product-market-fit faster with AI agents.</em></h3>
</div>

<p align="center">
    <strong>A spec-driven toolkit for systematic PMF discovery and validation of AI SaaS products, built on the foundations of spec-kit.</strong>
</p>

<p align="center">
    <a href="https://github.com/agentii-ai/pmf-kit/actions"><img src="https://img.shields.io/badge/status-alpha-orange" alt="Status"/></a>
    <a href="https://github.com/agentii-ai/pmf-kit/stargazers"><img src="https://img.shields.io/github/stars/agentii-ai/pmf-kit?style=social" alt="GitHub stars"/></a>
    <a href="https://github.com/agentii-ai/pmf-kit/blob/main/LICENSE"><img src="https://img.shields.io/github/license/agentii-ai/pmf-kit" alt="License"/></a>
    <a href="https://kits.agentii.ai"><img src="https://img.shields.io/badge/kits-agentii.ai-blue" alt="Kit Variants"/></a>
</p>

---

## 🎯 What is PMF-Kit?

**PMF-Kit** is a specialized variant of [**Spec-Kit**](https://github.com/github/spec-kit), adapted for product-market-fit (PMF) discovery and validation of AI SaaS products.

While Spec-Kit enables spec-driven software development with AI agents, **PMF-Kit applies the same methodology to the domain of product management, market research, and customer validation**—helping founders and PMs discover PMF through structured, AI-assisted workflows instead of ad-hoc experimentation.

### Key Differences from Spec-Kit

| Aspect | Spec-Kit | PMF-Kit |
|--------|----------|---------|
| **Focus** | Software feature development | Product-market-fit discovery |
| **Primary Workflow** | Specification → Plan → Code → Test | Specification → Research → Evidence → Decision |
| **Success Metrics** | Code quality, test coverage, performance | Persona validation, retention curves, willingness-to-pay |
| **Deliverables** | Production software & APIs | Research artifacts, validated hypotheses, PMF signals |
| **CLI Command** | `specify` | `pmf` |
| **Agent Commands** | `/speckit.*` | `/pmfkit.*` |

---

## 🚀 Get Started

### 1. Install PMF-Kit

Choose your preferred installation method:

#### Option 1: One-Time Usage (Recommended)

Run directly without installing—always uses the latest version:

```bash
uvx --from git+https://github.com/agentii-ai/pmf-kit.git pmf init my-product
uvx --from git+https://github.com/agentii-ai/pmf-kit.git pmf check
```

> **Note**: This project is improving rapidly. We recommend `uvx` to always get the latest features and fixes.

![One-time installation with uvx](./media/test1.png)

*Running `pmf init` shows an interactive wizard to select your AI assistant*

#### Option 2: Persistent Installation

Install once and use everywhere (may require periodic updates):

```bash
uv tool install pmf-cli --from git+https://github.com/agentii-ai/pmf-kit.git
```

![Persistent installation with uv tool](./media/test4.png)

*The `pmf` executable is installed globally for use anywhere*

Then use the tool directly:

```bash
pmf init my-product
pmf check
```

To update to the latest version:

```bash
uv tool install pmf-cli --force --from git+https://github.com/agentii-ai/pmf-kit.git
```

### 2. Initialize Your First PMF Project

```bash
pmf init my-ai-product
cd my-ai-product
```

This creates a project with PMF-specific templates, constitution, and agent commands.

![Successful PMF project initialization](./media/test2.png)

*After setup completes, you'll see all available slash commands and next steps*

### 3. Launch Your AI Agent

Open your AI assistant (Claude Code, Cursor, Windsurf, etc.) in the project directory. You'll see `/pmfkit.*` commands available:

```bash
/pmfkit.constitution    # Establish PMF-specific principles
/pmfkit.pmf         # Define what you're trying to learn
/pmfkit.clarify         # Resolve ambiguities in your hypothesis
/pmfkit.plan            # Create research execution plan
/pmfkit.tasks           # Generate actionable research tasks
/pmfkit.implement       # Execute PMF discovery workflow
```

![Claude Code showing PMF-Kit commands](./media/test3.png)

*Claude Code automatically detects all `/pmfkit.*` slash commands in your project*

### 4. Run Your First PMF Discovery Workflow

```bash
/pmfkit.pmf Validate willingness to pay for AI-powered contract review among solo lawyers, following Harvey's market approach
```

This generates a PMF specification with:
- Sharp personas (role, company, tools, environment)
- Jobs-to-be-done with current workarounds
- Hero workflows (intent → AI work → artifact)
- PMF success metrics (activation, engagement, AI-specific, business)
- Constraints, risks, and distribution hypotheses

---

## 🤖 Supported AI Agents

PMF-Kit works with all agents supported by Spec-Kit:

| Agent | Support | Notes |
|-------|---------|-------|
| [Claude Code](https://www.anthropic.com/claude-code) | ✅ | Native support |
| [Cursor](https://cursor.sh/) | ✅ | Full integration |
| [Windsurf](https://windsurf.com/) | ✅ | Complete support |
| [Gemini CLI](https://github.com/google-gemini/gemini-cli) | ✅ | Verified working |
| [GitHub Copilot](https://github.com/features/copilot) | ✅ | Compatible |
| [Qoder CLI](https://qoder.com/cli) | ✅ | Supported |
| Plus 5+ additional agents | ✅ | See Spec-Kit docs |

---

## 📦 PMF-Kit Templates

PMF-Kit provides project templates for 18 AI coding agents, automatically downloaded when you run `pmf init`. Each template includes:

- **PMF-Kit Constitution v1.0.0** with 7 PMF-specific principles
- **Workflow templates**: spec.md, plan.md, tasks.md for research documentation
- **9 slash commands**: /pmfkit.pmf, /pmfkit.plan, /pmfkit.tasks, /pmfkit.implement, /pmfkit.clarify, /pmfkit.analyze, /pmfkit.checklist, /pmfkit.taskstoissues, /pmfkit.constitution
- **Scripts**: Bash or PowerShell variants for automation
- **Memory system**: constitution.md for project-specific principles

### Supported Template Agents

Templates are available for all 18 agents in both bash and PowerShell variants (36 total):

- Claude Code • Cursor Agent • Windsurf • Google Gemini
- GitHub Copilot • Qoder • Qwen • OpenCode
- Codex • KiloCode • Auggie • CodeBuddy
- AMP • Shai • Amazon Q • Bob • Roo

See [GitHub Releases](https://github.com/agentii-ai/pmf-kit/releases) for downloadable template archives with SHA-256 checksums.

---

## 🎯 Core PMF Workflow

### Phase 1: Specification (`/pmfkit.pmf`)

Define **WHAT** you're trying to learn and **WHY**:
- Target personas (role/skill, company, tools, environment)
- Top 3 jobs-to-be-done (customer problems)
- 1-2 hero workflows (end-to-end AI-native flows)
- Success metrics (activation, engagement, AI-specific, business)
- Constraints & risks
- Distribution hypotheses

### Phase 2: Clarification (`/pmfkit.clarify`)

Resolve ambiguities before committing to research:
- Validate persona sharpness
- Clarify JTBD and hypotheses
- Define success metrics precisely
- Identify unstated assumptions

### Phase 3: Planning (`/pmfkit.plan`)

Define **HOW** you'll execute discovery:
- Research methodology (interviews, surveys, experiments)
- Sample sizes and recruitment strategy
- Evidence collection instruments
- Analysis approach
- Validation checkpoints & PDCA cycles

### Phase 4: Task Breakdown (`/pmfkit.tasks`)

Generate actionable research tasks:
- Recruit participants from target segment
- Conduct hero workflow research
- Analyze behavioral data
- Validate hypotheses
- Document learnings & pivot/persevere decisions

### Phase 5: Execution (`/pmfkit.implement`)

Execute research systematically with AI assistance:
- Collect customer evidence (interviews, behavioral data)
- Measure PMF signals (retention, TTFW, completion rates)
- Validate go/no-go criteria per phase
- Document decisions and evidence

---

## 🌟 PMF-Kit Constitution

PMF-Kit is built on 7 core principles that guide all discovery work:

### I. Specification-First Approach
Define hypotheses and success criteria **before** running experiments.

### II. Customer-Evidence-Driven
Support all PMF claims with direct customer evidence—not opinions or assumptions.

### III. Iterative Validation
Follow build-measure-learn cycles with independent, testable increments.

### IV. Minimal Viable Process
Use the simplest approach that achieves the learning objective.

### V. Cross-Functional Integration
Integrate insights from product, engineering, sales, marketing, and customer success.

### VI. Kit Namespace Isolation
Enable multiple kit variants (`pmf-kit`, `pd-kit`, `marketing-kit`) to coexist without conflicts.

### VII. Template Extensibility
Serve as a reference implementation for creating domain-specific kit variants.

See [`memory/constitution.md`](./memory/constitution.md) for full details.

---

## 📚 Reference Documentation

PMF-Kit includes comprehensive reference materials to guide your discovery:

- **`refs/0_overview.md`** - Overview of PMF discovery for AI SaaS products
- **`refs/1_principles_for_constitution.md`** - PMF-specific principles and patterns
- **`refs/2_define_for_specify.md`** - How to structure sharp PMF specifications
- **`refs/3_project_management_for_plan.md`** - Research planning methodology
- **`refs/4_pm_tasking_for_tasks.md`** - PMF discovery task patterns
- **`refs/instructions.md`** - How to create your own kit variants

---

## 🔧 Multi-Kit Installation

PMF-Kit is designed to coexist with Spec-Kit and other kit variants:

```bash
# Install Spec-Kit for software development
uv tool install specify-cli --from git+https://github.com/github/spec-kit.git

# Install PMF-Kit for product-market-fit discovery
uv tool install pmf-cli --from git+https://github.com/agentii-ai/pmf-kit.git

# Both tools work independently
specify check    # Shows Spec-Kit configuration
pmf check        # Shows PMF-Kit configuration

# Create projects with different kits
specify init my-feature           # Software feature project
pmf init my-product             # PMF discovery project
```

In your AI agent, both command namespaces are available:
- `/speckit.*` commands for software development workflows
- `/pmfkit.*` commands for PMF discovery workflows

---

## 🎛️ CLI Reference

### `pmf init` - Initialize PMF Project

```bash
pmf init <PROJECT_NAME>
pmf init my-product --ai claude
pmf init . --here --force        # Initialize in current directory
pmf init my-product --ai cursor --script ps   # PowerShell scripts
```

**Options:**
- `--ai` - Specify AI assistant (claude, cursor, windsurf, gemini, etc.)
- `--script` - Script variant (sh for bash/zsh, ps for PowerShell)
- `--here` - Initialize in current directory
- `--force` - Skip confirmation when directory has files
- `--no-git` - Skip git initialization
- `--ignore-agent-tools` - Skip tool availability checks

### `pmf check` - Verify Installation

```bash
pmf check
```

Verifies PMF-Kit installation and checks for required tools (git, claude, cursor, windsurf, etc.).

---

## 🚀 Examples by AI Product Type

### Developer Tools (Cursor, Claude Code, Devin)

```
pmf init ai-code-assistant
/pmfkit.pmf "Validate demand for AI-powered coding assistance among backend engineers, similar to Cursor's approach"
```

Expected artifacts:
- Personas: Backend engineers at 50-500 person SaaS
- JTBD: "When writing boilerplate code, I want AI to generate it, so I can focus on logic"
- Hero workflow: Intent (write comment) → AI generates → review → merge
- Success metric: Time-to-first-completion, edit distance, retention

### Creative Tools (Runway, Pika, HeyGen)

```
pmf init video-generation
/pmfkit.pmf "Validate demand for text-to-video generation among YouTube creators"
```

Expected artifacts:
- Personas: Content creators with 10k-100k subscribers
- JTBD: "When I need to produce weekly videos, I want to cut editing time by 80%"
- Hero workflow: Upload footage → AI edits with templates → review → export
- Success metric: Time-to-first-render, edit satisfaction, repeat usage

### Vertical AI Tools (Harvey, Writer)

```
pmf init contract-ai
/pmfkit.pmf "Validate willingness to pay for AI-powered legal analysis among solo practitioners and small law firms"
```

---

## 📖 Learn More

- **[PMF-Kit Specification](./specs/001-pmf-kit-variant/spec.md)** - Full feature specification
- **[PMF-Kit Implementation Plan](./specs/001-pmf-kit-variant/plan.md)** - Technical implementation details
- **[Spec-Kit Repository](https://github.com/github/spec-kit)** - Upstream project for software development
- **[Spec-Driven Development Methodology](https://github.com/github/spec-kit/blob/main/spec-driven.md)** - Core methodology

---

## 🚧 Roadmap

### Next Up: `/pmfkit.optimize` - Template Quality Optimization

The next major feature for PMF-Kit is an **automated optimization module** that evaluates and improves template quality using multi-judge LLM evaluation and optimization algorithms.

#### 5-Stage Optimization Pipeline

| Stage | Description | Status |
|-------|-------------|--------|
| **EVALUATE** | Multi-judge quality assessment (GPT-4o, Claude, Gemini) with 8-dimensional scoring | 🟡 Planned |
| **SUGGEST** | Root cause analysis + meta-prompting for improvement recommendations | 🟡 Planned |
| **IMPROVE** | MIPROv2/TextGrad optimization with few-shot example bootstrapping | 🟡 Planned |
| **VALIDATE** | *(Optional)* A/B testing with statistical significance validation | 🟡 Planned |
| **ITERATE** | *(Optional)* Continuous monitoring with auto-reoptimization triggers | 🟡 Planned |

#### Key Features

- **Multi-Judge Consensus**: 3 LLM judges (GPT-4o strict, Claude balanced, Gemini lenient) with Bradley-Terry aggregation
- **8-Dimensional Rubric**: Correctness, Coherence, Instruction-Following, Completeness, Specificity, Clarity, Actionability, Policy-Adherence
- **Quantified Improvements**: Target +15-25% quality improvement with statistical significance (p < 0.05)
- **CLI + Agent Support**: `pmf optimize <target>` and `/pmfkit.optimize` slash command

#### Usage Preview

```bash
# CLI usage
pmf optimize .pmf/templates/spec-template.md --mode=full

# Agent command
/pmfkit.optimize specs/my-feature/spec.md
```

See [specs/003-workflow-optimization](./specs/003-workflow-optimization/) for full specification and implementation plan.

---

## 🏗️ Project Structure

```
pmf-kit/
├── .claude/commands/          # Claude Code slash commands
│   ├── constitution.md
│   ├── specify.md
│   ├── plan.md
│   ├── tasks.md
│   ├── implement.md
│   ├── clarify.md
│   ├── analyze.md
│   └── checklist.md
├── memory/
│   └── constitution.md        # PMF-Kit principles (v1.0.0)
├── templates/
│   ├── spec-template.md       # PMF specification template
│   ├── plan-template.md       # PMF research planning template
│   ├── tasks-template.md      # PMF task breakdown template
│   ├── checklist-template.md  # PMF quality validation template
│   └── commands/              # Agent command templates
├── scripts/
│   ├── bash/                  # Bash automation scripts
│   └── powershell/            # PowerShell automation scripts
├── refs/                      # Reference documentation
│   ├── 0_overview.md
│   ├── 1_principles_for_constitution.md
│   ├── 2_define_for_specify.md
│   ├── 3_project_management_for_plan.md
│   ├── 4_pm_tasking_for_tasks.md
│   └── instructions.md        # How to create kit variants
└── specs/
    └── 001-pmf-kit-variant/   # Feature specification & implementation docs
```

---

## 🔧 Prerequisites

- **Linux/macOS/Windows**
- [Supported](#-supported-ai-agents) AI coding agent
- [uv](https://docs.astral.sh/uv/) for package management
- [Python 3.11+](https://www.python.org/downloads/)
- [Git](https://git-scm.com/downloads)

### Verify Your Setup

Run `pmf check` to verify all prerequisites and see which AI agents are available:

```bash
pmf check
```

![pmf check command output](./media/test5.png)

*The `pmf check` command shows all detected tools and AI agents*

---

## 🌐 Creating Your Own Kit Variant

PMF-Kit demonstrates how to adapt spec-driven methodology to any domain. Want to create a variant for product design, marketing, or business writing?

See [`refs/instructions.md`](./refs/instructions.md) for a comprehensive guide on:
- How to fork and adapt spec-kit for your domain
- How to define domain-specific principles
- How to create templates and reference materials
- How to enable multi-kit coexistence

**Example variants:**
- **`pd-kit`** - Product design and UX workflows
- **`marketing-kit`** - Go-to-market and growth campaigns
- **`writing-kit`** - Technical and business writing
- **`ops-kit`** - Operations and project management

All variants are published at [**kits.agentii.ai**](https://kits.agentii.ai).

---

## 🙏 Acknowledgements

PMF-Kit is built on the excellent work of the [**Spec-Kit**](https://github.com/github/spec-kit) project from GitHub. We preserve 100% of Spec-Kit's architecture and infrastructure while adapting templates and methodology for PMF discovery.

**Spec-Kit Credits:**
- [Den Delimarsky](https://github.com/localden)
- [John Lam](https://github.com/jflam)

---

## 💬 Support

For issues, questions, or feedback:

- **GitHub Issues**: [Report on PMF-Kit](https://github.com/agentii-ai/pmf-kit/issues)
- **Spec-Kit Issues**: [Report on Spec-Kit](https://github.com/github/spec-kit/issues)
- **Kit Variants**: [Visit kits.agentii.ai](https://kits.agentii.ai)

---

## 📄 License

This project is licensed under the terms of the MIT open source license. See [LICENSE](./LICENSE) for details.

**Note**: PMF-Kit extends Spec-Kit's MIT license. For Spec-Kit license details, see [Spec-Kit LICENSE](https://github.com/github/spec-kit/blob/main/LICENSE).

---

## 🌟 Why PMF-Kit?

### For Founders & PMs:
- **Systematic**: Replace vibe-based PMF discovery with structured, hypothesis-driven research
- **AI-Assisted**: Leverage AI agents for specification, planning, and evidence analysis
- **Validated**: Reference templates based on proven PMF patterns from Cursor, Runway, Harvey, Writer, and other successful AI products
- **Evidence-Driven**: Focus on customer evidence and measurable PMF signals, not opinions

### For the Open Source Community:
- **Reproducible**: Spec-driven workflows are more transparent and collaborative than ad-hoc processes
- **Extensible**: PMF-Kit serves as a reference for creating domain-specific kit variants
- **Community-Friendly**: All templates and reference materials are open source and MIT-licensed
- **Professional**: Built on proven Spec-Kit infrastructure, adapted by experienced product leaders

---

**Ready to discover product-market-fit with confidence?**

```bash
pmf init my-product
```

Let's build products customers love, with evidence guiding every decision.

---
