# Mail (himalaya + sirup + himalaya.nvim) and Teams (lazyteams) on Arch

Ported from the Guix machine (`guix-system`). Config files here mirror it:
`config/himalaya`, `config/sirup`, `config/nvim/lua/plugins/himalaya.lua`.
Deploy the same way as the other `config/*` entries (stow into `~/.config`).

## 1. Install (Arch)

    paru -S himalaya          # or: cargo install --locked himalaya
    cargo install --locked --git https://github.com/pimalaya/sirup.git sirup
    # make sure v2: `himalaya --version` must be >= 2.1 (himalaya.nvim needs v2)

himalaya.nvim comes through LazyVim (`config/nvim/lua/plugins/himalaya.lua`,
repo `knownasnaffy/himalaya.nvim`, dep `MunifTanjim/nui.nvim`). Open with `<leader>oh`.

## 2. No mail on the SSD

- sirup sockets live in `$XDG_RUNTIME_DIR/sirup/` (tmpfs).
- himalaya reads IMAP live (no local cache); `downloads-dir = /tmp/himalaya-downloads`.
- Only credentials persist (`pass`/gpg).

## 3. Outlook / Microsoft 365: decide by what IT allows (check in this order)

1. **IMAP/SMTP enabled + OAuth2?** Many tenants disable basic auth and/or IMAP.
   Test: `openssl s_client -connect outlook.office365.com:993` then see whether
   `Option A` in `config/sirup/config.toml` can authenticate with XOAUTH2.
   Needs an OAuth2 access token for scope
   `https://outlook.office365.com/IMAP.AccessAsUser.All` (+ `SMTP.Send`).
2. **Microsoft Graph backend** (himalaya v2 has `msgraph`, no IMAP needed): config
   `Option B` in `config/himalaya/config.toml`. Needs a short-lived Graph access
   token with `Mail.ReadWrite`/`Mail.Send`; refreshing it is yours to arrange
   (`msgraph.auth.token.command`). Pimalaya's `ortie` can fetch OAuth tokens.
3. The blocker is almost always the **OAuth client registration**: non-admin users
   usually cannot register or consent to a third-party Azure AD app
   (`AADSTS65002` / admin approval). Ask IT for an approved app/client ID, or for
   IMAP+OAuth enablement. Do not reuse another vendor's client ID without
   checking your company's policy.

## 4. lazyteams (Teams TUI) — https://github.com/agmonetti/lazyteams

    # pre-built release (linux-amd64), then:
    tar -xzf lazyteams-linux-amd64.tar.gz -C ~/.local/bin
    lazyteams-auth     # one-time interactive SSO login (browser/Playwright helper)
    lazyteams
    # or from source (Go 1.22+): go build -o lazyteams . ; go build -o lazyteams-auth ./cmd/auth-helper/

Note: `lazyteams-auth` captures tokens from a real web session (via a Playwright
helper), not from an app you registered. Running it on a corporate network and
account may fall under your company's security/acceptable-use policy — confirm
with IT first. `tokens.env` and the auth helper's browser profile are secrets;
never commit or share them (`~/.config/lazyteams/`).

## 5. Not verified

Nothing here was run against a real Outlook tenant. Treat sections 3–4 as a
checklist, and fix the Option A/B snippets to whatever your tenant accepts.
