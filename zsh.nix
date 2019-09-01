{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    autosuggestions.enable = true;
    ohMyZsh.enable = true;
    ohMyZsh.plugins = [ "git" "vi-mode" ];
    ohMyZsh.theme = "gnzh";
    syntaxHighlighting.enable = true;
    interactiveShellInit = ''
      export ZSH=${pkgs.oh-my-zsh}/share/oh-my-zsh/
  
      # Customize your oh-my-zsh options here
      ZSH_THEME="gnzh"
      plugins=(git zsh-autosuggestions vi-mode)
  
      bindkey '\e[5~' history-beginning-search-backward
      bindkey '\e[6~' history-beginning-search-forward
  
      HISTFILESIZE=500000
      HISTSIZE=500000
      setopt SHARE_HISTORY
      setopt HIST_IGNORE_ALL_DUPS
      setopt HIST_IGNORE_DUPS
      setopt INC_APPEND_HISTORY
      autoload -U compinit && compinit
      unsetopt menu_complete
      setopt completealiases
  
      if [ -f ~/.aliases ]; then
        source ~/.aliases
      fi

      if [ -n "''${commands[fzf-share]}" ]; then
        source "$(fzf-share)/key-bindings.zsh"
      fi

      if [ -n "$IN_NIX_SHELL" ]; then
        export TERMINFO=/run/current-system/sw/share/terminfo
      
        # Reload terminfo
        real_TERM=$TERM; TERM=xterm; TERM=$real_TERM; unset real_TERM
      fi
  
      source $ZSH/oh-my-zsh.sh
    '';
    promptInit = "";
  };
}
