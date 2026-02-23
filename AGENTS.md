# Repository Guidelines

## Project Structure & Module Organization
- `nvim/` contains the Neovim profile: `init.lua` loads modules under `lua/alzeck/`, `lazy-lock.json` pins plugins declared in `lua/alzeck/lazy.lua`, and `stylua.toml` stores formatting rules.  
- `tmux/` ships `tmux.conf`, helper scripts like `tmux-sessionizer`, and vendored plugins in `tmux/plugins/` (Catppuccin theme, TPM, vim-tmux-navigator).  
- `bat/`, `delta/`, `ghostty/`, and `lazygit/` mirror upstream config directories; large assets such as `bat/themes/*.tmTheme` should only change when fully regenerated.  
- `install.sh` bootstraps macOS machines by installing the Homebrew formulas in `packages` and running `stow .` to link everything into `~/.config`.

## Build, Test, and Development Commands
- `./install.sh` — run once on a new Mac to install dependencies, clone TPM, and stow configs.  
- `stow nvim tmux lazygit` — re-symlink only the modules you touched; Stow also prunes stale links.  
- `bash tmux/plugins/tmux/run_tests.sh` — executes Catppuccin’s tmux regression suite when editing files under `tmux/plugins/tmux`.  
- `NVIM_APPNAME=alzeck nvim` — launches Neovim with the stowed config so you can validate mappings or plugin upgrades.

## Coding Style & Naming Conventions
- Format Lua with Stylua via `stylua nvim/lua`; config lives in `nvim/stylua.toml` (2 spaces, 120 columns, double quotes).  
- Keep descriptive module names such as `plugins/git.lua`; group new plugin specs inside `lua/alzeck/plugins/`.  
- Shell scripts target `zsh` and should keep `set -e`, long-form flags, and lowercase function names.  
- YAML/TOML files (lazygit, delta) use two-space indentation and snake_case keys.

## Testing Guidelines
- Automated: run `bash tmux/plugins/tmux/run_tests.sh` plus any targeted script under `tmux/plugins/tmux/tests` before committing layout or status-line tweaks.  
- Manual: after stowing, open tmux to confirm status modules render; start Neovim via `NVIM_APPNAME=alzeck nvim --clean -u ~/.config/nvim/init.lua`.  
- Use `stylua` and `:checkhealth` to catch missing binaries (fzf, ripgrep, tree-sitter-cli) whenever editor integrations change.

## Commit & Pull Request Guidelines
- Follow the lightweight Conventional Commit style already in history (`feat: ...`, `chore: ...`), one logical change per commit, ≤60-character summaries.  
- PR descriptions should cover motivation, touched modules, and test evidence (e.g., `run_tests.sh`, tmux screenshots, Neovim health output). Link issues when available and call out user-facing theme updates with before/after notes.

## Security & Configuration Notes
- `install.sh` fetches Homebrew via HTTPS; verify URLs and avoid embedding API keys, hostnames, or SSH configs in tracked files.  
- Treat vendored plugin directories (`tmux/plugins/tpm`, `tmux/plugins/vim-tmux-navigator`, etc.) as read-only unless mirroring upstream changes.  
- Keep machine-specific secrets or overrides outside the repo (for example `~/.config/nvim/local.lua`) and ignore them via `.git/info/exclude` instead of broadening `.gitignore`.
