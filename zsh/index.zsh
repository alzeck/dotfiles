  for f in ~/.config/zsh/*.zsh(N); do
    [[ "$f" == ~/.config/zsh/index.zsh ]] && continue
    source "$f"
  done
