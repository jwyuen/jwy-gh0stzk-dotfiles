{
  config,
  lib,
  pkgs,
  host,
  ...
}:

let
  inherit (import ../hosts/${host}/options.nix) theShell hostname;
in
lib.mkIf (theShell == "zsh") {
  programs.zsh = {
    enable = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    historySubstringSearch.enable = true;
    dotDir = "${config.xdg.configHome}/zsh";
    plugins = [
      {
        name = "fzf-tab";
        src = pkgs.fetchFromGitHub {
          owner = "Aloxaf";
          repo = "fzf-tab";
          rev = "14e16f0d36ae9938e28b2f6efdb7344cd527a1a6";
          sha256 = "o8hgnTl84nI7jMVfA5jEcDXkMFFlnxKbRva+l/Fx4jI=";
        };
      }
    ];
    profileExtra = ''
      #if [ -z "$DISPLAY" ] && [ "$XDG_VNTR" = 1 ]; then
      #  exec Hyprland
      #fi
    '';
    initContent =
      let
        zshConfig = lib.mkOrder 1000 ''
          enable-fzf-tab
          # disable sort when completing `git checkout`
          zstyle ':completion:*:git-checkout:*' sort false
          # set descriptions format to enable group support
          # NOTE: don't use escape sequences here, fzf-tab will ignore them
          zstyle ':completion:*:descriptions' format '[%d]'
          # force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
          zstyle ':completion:*' menu no
          # case insensitive matching
          zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
          # preview directory's content with eza when completing cd
          zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
          # switch group using `<` and `>`
          zstyle ':fzf-tab:*' switch-group '<' '>'

          if type nproc &>/dev/null; then
            export MAKEFLAGS="$MAKEFLAGS -j$(($(nproc)-1))"
          fi
          bindkey '^[[3~' delete-char                     # Key Del
          bindkey '^[[5~' beginning-of-buffer-or-history  # Key Page Up
          bindkey '^[[6~' end-of-buffer-or-history        # Key Page Down
          bindkey '^[[1;3D' backward-word                 # Key Alt + Left
          bindkey '^[[1;3C' forward-word                  # Key Alt + Right
          bindkey '^[[H' beginning-of-line                # Key Home
          bindkey '^[[F' end-of-line                      # Key End
          bindkey '^F' autosuggest-accept                 # ctrl+f
          fastfetch
          if [ -f $HOME/.zshrc-personal ]; then
            source $HOME/.zshrc-personal
          fi
          eval "$(starship init zsh)"
          eval "$(zoxide init zsh)"
          eval "$(direnv hook zsh)"
        '';
        zshConfigEarlyInit = lib.mkOrder 500 ''
          HISTFILE=~/.histfile
          HISTSIZE=1000
          HISTDUP=erase
          SAVEHIST=1000
          setopt appendhistory
          setopt sharehistory
          setopt hist_ignore_space
          setopt hist_ignore_all_dups
          setopt hist_save_no_dups
          setopt hist_ignore_dups
          setopt hist_find_no_dups
          setopt autocd nomatch
          unsetopt beep extendedglob notify
          autoload -Uz compinit; 
          compinit
        '';
      in
      lib.mkMerge [
        zshConfigEarlyInit
        zshConfig
      ];
    sessionVariables = {

    };
    shellAliases = {
      sv = "sudo nvim";
      flake-rebuild = "nh os switch --hostname ${hostname}";
      flake-update = "nh os switch --hostname ${hostname} --update";
      gcCleanup = "nix-collect-garbage --delete-old && sudo nix-collect-garbage -d && sudo /run/current-system/bin/switch-to-configuration boot";
      cd = "z";
      v = "nvim";
      ls = "eza -a --icons --git --group-directories-first";
      ll = "eza -l --icons --git --group-directories-first";
      la = "eza -la --icons --git --group-directories-first";
      lt = "eza -la --icons --git --tree --level=2 --group-directories-first";
      ".." = "cd ..";
      history = "history 0";
      nf = "nvim $(fzf)";
      "gitrmall" = "git rm $(git ls-files --deleted)";
    };
  };
}
