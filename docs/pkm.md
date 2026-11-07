# PKM: ai-wiki as an OKF bundle, edited in Neovim (Arch)

Structure and usage: `docs/pkm-okf-bundle-workflow.md` (copy of the ai-wiki original, kept here because this device has no ai-wiki checkout). This file only covers the Arch install.

Mirrors the Guix machine. Format = Open Knowledge Format v0.2 (markdown + YAML
frontmatter, `type` required) plus ai-wiki extra keys. Private use only: nothing
is published (no GitBook / external sync).

## Install

    paru -S marksman uv                       # marksman: markdown LSP (LazyVim lang.markdown extra)
    # OKF graph viewer (not in Arch repos); pinned commit, heavy deps (google-adk):
    uv tool install --python 3.12 --force \
      "git+https://github.com/GoogleCloudPlatform/open-knowledge-format@ad30107c31c06aec8a7d5636e0d1058118604e6f"
    git clone <your ai-wiki remote> ~/work/ai-wiki      # bundle root is its docs/

Enable the LazyVim extra `lazyvim.plugins.extras.lang.markdown` if it is not yet
(`:LazyExtras`). `config/nvim/lua/plugins/pkm.lua` needs only Telescope (already
in `navigation.lua`). Change the wiki location with `vim.g.pkm_root = "..."`.

## Keys / commands (prefix `<leader>k`)

- `kf` find note, `kg` grep notes, `kb` backlinks of current note, `kt` notes by `type`
- `kn` new note with OKF frontmatter, `ki` open `docs/index.md`, `kl` open `docs/log.md`
- `kN` / `:PkmNormalize[!]` run `scripts/okf-normalize.py` (dry-run; `!` applies and
  logs the change to `docs/log.md`), `kv` / `:PkmViz` render the graph to nvim's cache
  dir and open it (needs `reference-agent` from the uv step).

## Conventions

- Required `type`: How-To | Concept | Reference | Meta | Plan | Spec.
- Never write `generated`/`verified` unless the real actor is known.
- `docs/log.md` = OKF change history (auto-written by `--apply`). The repo-root
  `log.md` is the dream agent's activity log; they are intentionally separate.
- BigQuery enrichment (Google's `reference-agent enrich`) is not set up; add it only
  when a BigQuery source exists (needs GCP ADC + `GEMINI_API_KEY`, kept in `pass`).

## Not verified here

`PkmViz` and the uv install have not been run end to end; `pkm.lua` was only
load-tested headless.
