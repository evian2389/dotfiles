# JetBrainsMonoHangul Nerd Font Mono (ghostty, herdr-gpui) on Arch

One monospaced font with Latin (JetBrains Mono), Korean (D2Coding Hangul, exactly two
cells wide) and Nerd Font icons, so no fallback font is needed.
Project: https://github.com/jhyub/JetBrainsMonoHangul (OFL-1.1), release `20260222`.
Family name: `JetBrainsMonoHangul Nerd Font Mono`.

`config/ghostty/config` already uses it, so ghostty falls back to a default font until
this is installed.

## Install (no AUR package exists)

    mkdir -p ~/.local/share/fonts/JetBrainsMonoHangul && cd "$(mktemp -d)"
    curl -fLO https://github.com/jhyub/JetBrainsMonoHangul/releases/download/20260222/JetBrainsMonoHangulNerdFontMono-20260222.zip
    echo "c77d814b96dfa2f7d7f91000c69eef9e64e05dc5134c36fcf3fdb80b07c5cde5  JetBrainsMonoHangulNerdFontMono-20260222.zip" | sha256sum -c -
    unzip -j JetBrainsMonoHangulNerdFontMono-20260222.zip '*.ttf' -d ~/.local/share/fonts/JetBrainsMonoHangul
    fc-cache -f && fc-list | grep -i JetBrainsMonoHangul | head -2
    ghostty +list-fonts | grep -i JetBrainsMonoHangul

The hash is of the zip as downloaded on the Guix machine on 2026-11-07; if it differs,
the release may have been re-uploaded: check before installing.

## herdr-gpui (GUI app, optional)

`~/.config/herdr/config-gpui.local.toml` is written by herdr itself, so it is not
stowed. Add (all four areas, or just `[terminal]`):

    [sidebar]
    family = "JetBrainsMonoHangul Nerd Font Mono"
    [tabs]
    family = "JetBrainsMonoHangul Nerd Font Mono"
    [terminal]
    family = "JetBrainsMonoHangul Nerd Font Mono"
    [ui]
    family = "JetBrainsMonoHangul Nerd Font Mono"

herdr-gpui reads fonts only at startup: restart `herdr-gpui` (not the herdr server).
On Guix the app could not see the profile's fonts at all and reported "Configured fonts
not installed"; the fonts had to be copied to `~/.local/share/fonts`. On Arch the
standard font dirs (`/usr/share/fonts`, `~/.local/share/fonts`) are scanned, so the
install above should be enough. Not verified on Arch.
