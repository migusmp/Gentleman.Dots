# Agents for Claude Code

## Installation

Copy all `.md` files to your global agents folder:

```bash
mkdir -p ~/.claude/agents
cp *.md ~/.claude/agents/
```

This makes them available in **all** your projects.

## Included agents

| # | Agent | File | Model | Role |
|---|-------|------|-------|------|
| 01 | **architect** | `architect.md` | Opus | System architecture, tech stack, data models, ADRs, scalability |
| 02 | **builder** | `builder.md` | Sonnet | Production-ready code with validation, error handling, and security |
| 03 | **detective** | `detective.md` | Opus | Forensic debugging: hypotheses, root cause, verified solution |
| 04 | **critic** | `critic.md` | Opus | Professional code review across 7 dimensions with scoring |
| 05 | **optimizer** | `optimizer.md` | Sonnet | Refactoring with atomic changes and improvement metrics |
| 06 | **shield** | `shield.md` | Sonnet | Complete test suite: 6 mandatory categories |
| 07 | **narrator** | `narrator.md` | Sonnet | Technical documentation: README, API, ADRs, runbooks, onboarding |

## Usage

### As a main session

Launch Claude Code directly with the agent:

```bash
claude --agent architect
claude --agent builder
claude --agent detective
```

The entire session will behave as that specialized agent.

### As a sub-agent (automatic delegation)

From a normal Claude Code session, simply describe your task and Claude will automatically delegate to the appropriate agent based on each agent's `description` field.

### From the interactive interface

Type `/agents` inside Claude Code to see all available agents and invoke any of them.

## Model selection

- **Opus** → architect, detective, critic: tasks requiring deep analysis and complex reasoning.
- **Sonnet** → builder, optimizer, shield, narrator: execution tasks where speed matters and reasoning is more direct.

You can change the model by editing the `model:` line in each file's frontmatter.

## Customization

Each agent is a Markdown file with YAML frontmatter. You can:

- Change the `model` (opus / sonnet / haiku).
- Add or remove `tools` as needed.
- Modify the system prompt (the text after the frontmatter).
- Add examples specific to your stack or project.

## Notes

- Agents are **technology-agnostic**: they automatically detect the language, framework, and conventions of each project.
- Read-only agents (detective, critic) do not have write tools to prevent accidental changes.
- Write agents (builder, optimizer, shield, narrator, architect) always analyze the project before modifying anything.

## Typical workflow

```
architect → builder → critic → shield → narrator
                                    ↑
                               detective (on demand, any stage)
                                    ↑
                               optimizer (after code is working)
```
