# security-skills

Cloudflare's [security-audit skill](https://github.com/cloudflare/security-audit-skill), packaged so you can install it without `npx`:

- **Claude Code** and **GitHub Copilot CLI**: as a plugin from this repo's marketplace
- **Codex**, **Cursor**, **GitHub Copilot** (VS Code): by copying the skill folder to `~/.agents/skills/`

The skill turns your coding agent into a security auditor: reconnaissance, coverage-led hunting, independent validation of every candidate, structured `findings.json`, and a final report. See [`skills/security-audit/SKILL.md`](skills/security-audit/SKILL.md) and the [upstream README](https://github.com/cloudflare/security-audit-skill#readme) for how it works.

## Install

### Claude Code

```
/plugin marketplace add seabnavin19/security-skills
/plugin install security-audit@security-skills
```

Or from your shell:

```sh
claude plugin marketplace add seabnavin19/security-skills
claude plugin install security-audit@security-skills
```

Update later with `/plugin marketplace update security-skills`.

### GitHub Copilot CLI

```sh
copilot plugin marketplace add seabnavin19/security-skills
copilot plugin install security-audit@security-skills
```

### Codex, Cursor, GitHub Copilot (VS Code)

All three read skills from `~/.agents/skills/`. The install script downloads this repo and copies the skill there.

macOS / Linux:

```sh
curl -fsSL https://raw.githubusercontent.com/seabnavin19/security-skills/main/install.sh | sh
```

Windows (PowerShell):

```powershell
irm https://raw.githubusercontent.com/seabnavin19/security-skills/main/install.ps1 | iex
```

To install somewhere else, such as a project's `.agents/skills/` folder so the whole team gets it from the repo:

```sh
curl -fsSL https://raw.githubusercontent.com/seabnavin19/security-skills/main/install.sh | sh -s -- ./.agents/skills
```

```powershell
& ([scriptblock]::Create((irm https://raw.githubusercontent.com/seabnavin19/security-skills/main/install.ps1))) -Dest .\.agents\skills
```

Run the same command again to update.

#### Manual install

```sh
git clone --depth 1 https://github.com/seabnavin19/security-skills
cp -R security-skills/skills/security-audit ~/.agents/skills/
```

## Usage

Open your agent in the codebase you want to audit and ask:

```
security audit this codebase
```

Security questions and focused reviews use guidance mode. A full audit or pen-test request runs all six phases and writes its report to `~/security-audit-skill/<repo-name>/run-<N>` unless you name another directory.

## Requirements

- A coding agent that supports tool use and sub-agents.
- **Node.js** for full audits. The skill runs two zero-dependency validators (`validate-findings.cjs`, `validate-coverage-ledger.cjs`) with `node`. Installing the skill and guidance mode do not need Node.
- An OS-enforced sandbox if you want the audit to execute target code; without one, the skill keeps such leads as `needs_validation`.

## Credit and license

The skill content in [`skills/security-audit/`](skills/security-audit/) is by Cloudflare, Inc., unchanged from [cloudflare/security-audit-skill](https://github.com/cloudflare/security-audit-skill) at commit `c1c8a8c`. MIT licensed; see [LICENSE](LICENSE).
