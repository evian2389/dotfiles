# ai-wiki as an OKF bundle: structure, tooling, daily workflow

> Copy of `ai-wiki/docs/pkm/okf-bundle-workflow.md` (snapshot 2026-11-07) for devices without the ai-wiki checkout.
> The ai-wiki original is the source of truth; refresh this copy when it changes.

> TL;DR: `docs/` is an Open Knowledge Format v0.2 bundle (markdown + YAML frontmatter, `type` required). Edit it in Neovim (`<leader>k…`), run `scripts/okf-normalize.py` to normalize frontmatter and regenerate `index.md`, and every applied change is logged to `docs/log.md`. Private use only; nothing is published.

## TOC

- Structure
- Frontmatter
- Tooling
- Daily workflow
- Not set up (on purpose)
- See Also

## Structure

```
ai-wiki/
  log.md                 # dream agent activity log (append-only, its own format)
  scripts/okf-normalize.py
  meta/                  # agent/system docs (frontmatter normalized, not part of the bundle)
  docs/                  # <- the OKF bundle root
    index.md             # generated; carries okf_version: "0.2"
    log.md               # OKF change history, newest date first (auto-written)
    <topic>/index.md     # generated per directory
    <topic>/<page>.md    # concept documents
```

`index.md` and `log.md` are reserved OKF filenames: never use them for content pages.
The two logs are intentionally separate: root `log.md` is the dream agent's activity feed,
`docs/log.md` is the bundle's change history.

## Frontmatter

OKF standard keys plus ai-wiki extras (extras are allowed; consumers must ignore unknown keys):

```yaml
---
type: "How-To"           # REQUIRED: How-To | Concept | Reference | Meta | Plan | Spec
title: "..."
description: "one line"
tags: [...]
status: stable           # draft | stable | deprecated
layer: howto             # ai-wiki extra: concept | howto | reference | meta
harnesses: [all]         # ai-wiki extra
audience: [human, agent] # ai-wiki extra
updated: YYYY-MM-DD      # ai-wiki extra
---
```

Do not write `generated` / `verified` (OKF trust keys) unless the real actor is known.
`type` is derived from `layer` (and from `plans/`, `specs/` paths) by the script.

## Tooling

| What | Where | Notes |
| --- | --- | --- |
| Normalizer + index + log | `scripts/okf-normalize.py` | dry-run by default; `--apply` writes and logs to `docs/log.md`. Idempotent. |
| Graph viewer | `reference-agent visualize --bundle docs --out <html>` | Google's OKF reference tool, installed by `uv tool install` (pinned commit) from `non-guix-packages.sh` on the Guix machine. Writes one self-contained HTML. |
| Neovim | `lua/plugins/pkm.lua` | needs Telescope + marksman (LazyVim `lang.markdown` extra). |

Neovim keys (prefix `<leader>k`): `kf` find note, `kg` grep, `kb` backlinks of the current note,
`kt` by `type`, `kn` new note with OKF frontmatter, `ki` index, `kl` change log, `kN` / `:PkmNormalize[!]`
normalize (dry-run, `!` applies), `kv` / `:PkmViz` graph (written to nvim's cache dir, not into the wiki).

## Daily workflow

1. Write or edit a page under `docs/<topic>/` (`<leader>kn` for a new one).
2. `:PkmNormalize` to preview, `:PkmNormalize!` to apply (fills missing `type`/`title`/`description`,
   regenerates `index.md`, appends to `docs/log.md`).
3. `:PkmViz` to look at the link graph; fix pages with no links.
4. Commit the wiki. The dream agent keeps filing session insights; it uses the same frontmatter
   (see `ai-wiki/meta/dream-agent.md`).

## Not set up (on purpose)

- **GitBook / external publishing**: this wiki is private; no Git Sync.
- **Google `reference-agent enrich`**: it targets BigQuery datasets (needs GCP ADC and a Gemini key),
  not notes. Add it only when a BigQuery source exists; keep secrets in `pass`.
- **Trust keys** (`generated`/`verified`) on existing pages: authorship is unknown.

## See Also

- [OKF specification v0.2](https://github.com/GoogleCloudPlatform/open-knowledge-format/blob/main/SPEC.md)
- `ai-wiki/meta/dream-agent.md` (dream agent)
- Machine setup: `guix-system/doc/pkm/PLAN.md` (Guix), `dotfiles/docs/pkm.md` (Arch)
