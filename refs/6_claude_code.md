> **Author:** frank@agentii.ai  
> **Version:** v0.0.3  
> **Last Updated (NYC):** 2025-12-03 04:34


# Step 6.1: Use Claude Code to build constitution.md

```prompt

/constitution this blog-kit project is a fork of the github.com spec-kit project. read @README_spec-kit.md to get a global view of the original spec-kit and its spec-driven development workflow.

spec-driven development is a strong methodology for complex work with llm-based agents, and the same pattern can be applied to many domains (project management, product design, marketing, business writing, etc.). blog-kit is a featured variant of spec-kit focused on project management for discovering and validating product-market fit for ai saas products.

i will also use this project as a worked example of how to create your own spec-kit variants (for example, pm-kit, pd-kit, marketing-kit, biz-writing-kit). i will develop comprehensive documents in @refs/ to show, step by step, how to use prompts and search tools to build up-to-date references and adapt the original spec-kit templates.

in the constitution for this project, a few things are especially important:
1. i want to reuse the overall spec-kit design, including installation model, cli commands, and how it integrates with claude code, cursor, and other coding agents.
2. users may install multiple *-kit variants on the same machine, so the base `specify` command name can conflict across packages. you must design a clean naming and namespace strategy so spec-kit, blog-kit, pd-kit, and other kits can coexist without collisions.
3. related to (2), slash commands like `blogkit.plan` and `blogkit.implement` are how agents such as claude code invoke workflows. you must ensure there is no conflict between commands like `blogkit.plan` and `blogkit.plan`, and that they can reliably trigger different agents or workflows.

think carefully and globally about the architecture, naming, and multi-kit coexistence first, then draft a clear, opinionated constitution for blog-kit that respects these constraints and follows the principles in @memory/constitution.md.

IMPORTANT: DO NOT modify the .claude/ folder - it's a working copy from spec-kit for the current Claude Code agent to use.

```


# Step 6.2: Use Claude Code to build spec.md



```prompt
/specify is running… this blog-kit project is a fork of the github.com spec-kit project. read @README_spec-kit.md to get a global view of the original spec-kit project and its spec-driven development workflow.

spec-driven development is a strong methodology for complex work with llm-based agents, and the same pattern can be applied to many domains (project management, product design, marketing, business writing, etc.). blog-kit is a featured variant of spec-kit focused on project management for discovering and validating product-market fit for ai saas products.

read @memory/constitution.md and generate the spec.md for this project. you MUST also read @refs/2_ define_for_specify.md and follow its structure and intent.

there are a few important constraints:
1. re-use the overall spec-kit design, including the cli model and how it integrates with claude code, cursor, and other coding agents.
2. assume users may install multiple *-kit variants on the same machine, so the base `specify` command name can conflict across packages. design a clean naming and namespace strategy so spec-kit, blog-kit, pd-kit, and other variants can coexist.
3. related to (2), slash commands like `blogkit.plan` and `blogkit.implement` are how agents invoke workflows. ensure there is no conflict between commands such as `blogkit.plan` and `blogkit.plan`, and that each reliably triggers the correct workflow.

think carefully and globally about architecture, naming, and multi-kit coexistence first, then draft a clear, opinionated spec.md for blog-kit that is consistent with @memory/constitution.md and suitable as a reference for future *-kit variants.

IMPORTANT: DO NOT modify the .claude/ folder - it's a working copy from spec-kit for the current Claude Code agent to use.
REMEMBER to edit the package names in pyproject.toml file.
```



# Step 6.3: Use Claude Code to build plan.md

```prompt

/plan this blog-kit project is a fork of the github.com spec-kit project. read @README_spec-kit.md to get a global view of the original spec-kit project and its spec-driven development workflow.

spec-driven development is a strong methodology for complex work with llm-based agents, and the same pattern can be applied to many domains (project management, product design, marketing, business writing, etc.). blog-kit is a featured variant of spec-kit focused on project management for discovering and validating product-market fit for ai saas products.

for this task, read @memory/constitution.md and @specs/001-blog-kit-variant/spec.md. you MUST also read @refs/3_project_mangement_for_plan.md and follow its structure and intent when generating plan.md.

there are a few important constraints:
1. re-use the overall spec-kit design, including how it is installed, how the cli works, and how it integrates with claude code, cursor, and other coding agents.
2. assume users may install multiple *-kit variants on the same machine, so the base `specify` command name can conflict across packages. design a clean naming and namespace strategy so spec-kit, blog-kit, pd-kit, and other variants can coexist.
3. related to (2), slash commands like `blogkit.plan` and `blogkit.implement` are how agents invoke workflows. ensure there is no conflict between commands such as `blogkit.plan` and `blogkit.plan`, and that each reliably triggers the correct workflow.

think carefully and globally about architecture, naming, and multi-kit coexistence first. then generate a clear, opinionated plan.md for blog-kit that:
- respects the principles in @memory/constitution.md,
- aligns with the spec in @specs/001-blog-kit-variant/spec.md, and
- can guide edits to the spec-kit templates in @templates/ and @templates/commands/ to swap `blogkit` → `blogkit` **without** changing the underlying infrastructure.

IMPORTANT: DO NOT modify the .claude/ folder - it's a working copy from spec-kit for the current Claude Code agent to use.
IMPORTANT: The word "specify" shows up in two situations. One situation is as the command name like in "speckit.specify" or "./specify". In this situation, when change to "blog.specify" or "blogkit.specify", or "./specify", you should keep as it is for consistency. In the second situation, "specify" refers to the package name, like in folder name for "./specify/memory/constituation.md". Since multiple spec-kit like kits may work together in the same project, their package names should be distinct to avoid conflicts. Change "./specify/memory/constituation.md" to "./blogkit/memory/constituation.md" or "./blog/memory/constituation.md".
REMEMBER to edit the package names in pyproject.toml file.

```



# Step 6.4: User Claude Code to build tasks.md


```prompt

/tasks is running… this blog-kit project is a fork of the github.com spec-kit project. read @README_spec-kit.md to get a global view of the original spec-kit project and its spec-driven development workflow.

spec-driven development is a strong methodology for complex work with llm-based agents, and the same pattern can be applied to many domains (project management, product design, marketing, business writing, etc.). blog-kit is a featured variant of spec-kit focused on project management for discovering and validating product-market fit for ai saas products.

for this task, read @memory/constitution.md, @specs/001-blog-kit-variant/spec.md, and @specs/001-blog-kit-variant/plan.md. you MUST also read @refs/4_pm_tasking_for_tasks.md and follow its structure and intent when generating tasks.md.

there are a few important constraints:
1. re-use the overall spec-kit design, including how it is installed, how the cli works, and how it integrates with claude code, cursor, and other coding agents.
2. assume users may install multiple *-kit variants on the same machine, so the base `specify` command name can conflict across packages. design a clean naming and namespace strategy so spec-kit, blog-kit, pd-kit, and other variants can coexist.
3. related to (2), slash commands like `blogkit.plan` and `blogkit.implement` are how agents invoke workflows. ensure there is no conflict between commands such as `blogkit.plan` and `blogkit.plan`, and that each reliably triggers the correct workflow.

think carefully and globally about architecture, naming, and multi-kit coexistence first. then generate a clear, opinionated tasks.md for blog-kit that:
- respects the principles in @memory/constitution.md,
- aligns with the spec and plan in @specs/001-blog-kit-variant/, and
- can guide edits to the spec-kit templates in @templates/ and @templates/commands/ to swap `blogkit` → `blogkit` **without** changing the underlying infrastructure. continue writing tasks.md in the current git branch.

IMPORTANT: DO NOT modify the .claude/ folder - it's a working copy from spec-kit for the current Claude Code agent to use.
IMPORTANT: The word "specify" shows up in two situations. One situation is as the command name like in "speckit.specify" or "./specify". In this situation, when change to "blog.specify" or "blogkit.specify", or "./specify", you should keep as it is for consistency. In the second situation, "specify" refers to the package name, like in folder name for "./specify/memory/constituation.md". Since multiple spec-kit like kits may work together in the same project, their package names should be distinct to avoid conflicts. Change "./specify/memory/constituation.md" to "./blogkit/memory/constituation.md" or "./blog/memory/constituation.md".
REMEMBER to edit the package names in pyproject.toml file.

```

# Step 6.5: Use Claude Code to implement


```prompt
/implement this blog-kit project is a fork of the github.com spec-kit project. read @README_spec-kit.md to get a global view of the original spec-kit project and its spec-driven development workflow.

spec-driven development is a strong methodology for complex work with llm-based agents, and the same pattern can be applied to many domains (project management, product design, marketing, business writing, etc.). blog-kit is a featured variant of spec-kit focused on project management for discovering and validating product-market fit for ai saas products.

for this task, read @memory/constitution.md, @specs/001-blog-kit-variant/spec.md, and @specs/001-blog-kit-variant/plan.md. you MUST also read @specs/001-blog-kit-variant/tasks.md and @refs/4_pm_tasking_for_tasks.md to understand the blog tasking approach.

there are a few important constraints:
1. re-use the overall spec-kit design, including how it is installed, how the cli works, and how it integrates with claude code, cursor, and other coding agents.
2. assume users may install multiple *-kit variants on the same machine, so the base `specify` command name can conflict across packages. design a clean naming and namespace strategy so spec-kit, blog-kit, pd-kit, and other variants can coexist.
3. related to (2), slash commands like `blogkit.plan` and `blogkit.implement` are how agents invoke workflows. ensure there is no conflict between commands such as `blogkit.plan` and `blogkit.plan`, and that each reliably triggers the correct workflow.

think carefully and globally about architecture, naming, and multi-kit coexistence first. then implement the changes described in tasks.md for blog-kit by:
- editing the spec-kit templates in @templates/ and @templates/commands/ to swap `blogkit` → `blogkit` **without** changing the underlying infrastructure, and
- keeping all edits in the current git branch as you complete the implementation.

IMPORTANT: DO NOT modify the .claude/ folder - it's a working copy from spec-kit for the current Claude Code agent to use.
IMPORTANT: The word "specify" shows up in two situations. One situation is as the command name like in "speckit.specify" or "./specify". In this situation, when change to "blog.specify" or "blogkit.specify", or "./specify", you should keep as it is for consistency. In the second situation, "specify" refers to the package name, like in folder name for "./specify/memory/constituation.md". Since multiple spec-kit like kits may work together in the same project, their package names should be distinct to avoid conflicts. Change "./specify/memory/constituation.md" to "./blogkit/memory/constituation.md" or "./blog/memory/constituation.md".
REMEMBER to edit the package names in pyproject.toml file.

```



# Step 6.6: Upload to github, automatically create release






# Step 6.7: Install from it, and run tests to verify the implementation



