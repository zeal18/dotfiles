# Guide: Creating TASKS.md for Context Foundry

When asked to create or update a `TASKS.md` for a Context Foundry project, follow this guide.

## Format

```markdown
## Phase 1: <Phase Name>
- [ ] T1.1: <Action-oriented task description>
- [ ] T1.2: <Action-oriented task description>
- [x] T1.3: <Completed task>

## Phase 2: <Phase Name>
- [ ] T2.1: <Action-oriented task description>
- [ ] T2.2: <Action-oriented task description>
```

### Rules

- **Headers:** Each phase starts with `## Phase N` or `## Phase N: Name`. Use a descriptive name when it adds clarity.
- **Task IDs:** Format is `TN.M` where N is the phase number and M is the sequence within that phase (e.g., `T1.1`, `T1.2`, `T2.1`). IDs must be unique across the whole file.
- **Checkbox state:** `- [ ]` for pending, `- [x]` for completed.
- **Description:** Comes after `ID: `. Write it as an imperative action ("Add X", "Implement Y", "Fix Z"). Keep it specific enough for an agent to act on without additional context.
- **Do not include** pipeline progress indicators like `[SPID]` — foundry manages those automatically.
- **Do not invent** phases or tasks beyond what the user described. If scope is unclear, ask before adding.

## Phasing Strategy

Group tasks into phases that reflect logical milestones or layers of the build:
- **Phase 1:** Foundation / scaffolding (project setup, dependencies, core types)
- **Phase 2:** Core logic / primary feature implementation
- **Phase 3:** Integration / secondary features
- **Phase 4:** Polish / testing / documentation

Keep phases cohesive. Avoid mixing unrelated concerns in one phase. Aim for 3–8 tasks per phase — too few and phases are meaningless, too many and the file becomes hard to navigate.

## Workflow

When the user provides a task description and context:

1. **Understand scope** — identify what needs to be built, the major components, and the natural sequence of work.
2. **Draft phases** — group work into 2–5 phases that each represent a coherent milestone.
3. **Write tasks** — one task per meaningful unit of work. Tasks should be independently completable by an agent in a single pipeline run.
4. **Number sequentially** — within each phase, number tasks `N.1`, `N.2`, etc. starting from 1.
5. **Write to `TASKS.md`** in the project root using the Write tool.

## Example

User: "Build a CLI tool that fetches GitHub repo stats and outputs a summary report."

```markdown
## Phase 1: Project Setup
- [ ] T1.1: Initialize Rust project with Cargo and add dependencies (reqwest, serde, clap)
- [ ] T1.2: Define CLI argument structure with clap (repo owner, repo name, output format)
- [ ] T1.3: Set up GitHub API client with authentication token support

## Phase 2: Data Fetching
- [ ] T2.1: Implement GitHub REST API calls for repo metadata (stars, forks, open issues)
- [ ] T2.2: Implement fetching contributor list with commit counts
- [ ] T2.3: Add error handling for rate limits and missing repos

## Phase 3: Report Generation
- [ ] T3.1: Define report data model and serialization
- [ ] T3.2: Implement plain-text summary output
- [ ] T3.3: Implement JSON output format
- [ ] T3.4: Add CLI flag to choose output format

## Phase 4: Testing and Polish
- [ ] T4.1: Write unit tests for data model and formatting logic
- [ ] T4.2: Add integration test with a mock GitHub API response
- [ ] T4.3: Write README with usage examples and setup instructions
```

## Notes

- The project should also have a `SPEC.md` describing the project goal, tech stack, and architecture. If the user hasn't created one, suggest writing it alongside TASKS.md.
- Do not pre-check `[x]` any tasks unless the user explicitly says work is already done.
- If updating an existing TASKS.md, preserve completed tasks (`[x]`) and pipeline progress indicators (`[SPID]` etc.) — only add or modify pending tasks.
