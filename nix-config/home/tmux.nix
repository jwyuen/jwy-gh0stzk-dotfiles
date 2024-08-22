{ pkgs, config, ... }:
let
  tmux-sessionx = pkgs.tmuxPlugins.mkTmuxPlugin
    {
      pluginName = "tmux-sessionx";
      version = "unstable-2024-06-25";
      src = pkgs.fetchFromGitHub {
        owner = "omerxx";
        repo = "tmux-sessionx";
        rev = "ecc926e7db7761bfbd798cd8f10043e4fb1b83ba";
        sha256 = "sha256-S/1mcmOrNKkzRDwMLGqnLUbvzUxcO1EcMdPwcipRQuE=";
      };
    };
in
{
  programs.tmux = {
    enable = true;
    plugins = with pkgs.tmuxPlugins; 
    [
      better-mouse-mode
      sensible
      yank
      resurrect
      continuum
      tmux-thumbs
      tmux-fzf
      fzf-tmux-url
      vim-tmux-navigator
      catppuccin
      {
        plugin = tmux-sessionx;
        extraConfig = ''
          set -g @sessionx-auto-accept 'off'
          set -g @sessionx-window-height '85%'
          set -g @sessionx-window-width '75%'
          set -g @sessionx-zoxide-mode 'on'
          set -g @sessionx-custom-paths-subdirectories 'false'
          set -g @sessionx-filter-current 'false'
        '';
      }
    ];
    extraConfig = ''
      # First remove *all* keybindings
      # unbind-key -a
      # Now reinsert all the regular tmux keys
      bind ^X lock-server
      bind ^C new-window -c "$HOME"
      bind ^D detach
      bind * list-clients

      # -n doesn't require prefix key first
      bind-key -n C-w previous-window
      bind-key -n C-e next-window
      bind-key -n C-h select-pane -L
      bind-key -n C-j select-pane -D
      bind-key -n C-k select-pane -U
      bind-key -n C-l select-pane -R
      bind-key -n C-S-F2 new-session

      bind-key "o" run-shell "sesh connect \"$(
	sesh list | fzf-tmux -p 55%,60% \
		--no-sort --ansi --border-label ' sesh ' --prompt '⚡  ' \
		--header '  ^a all ^t tmux ^g configs ^x zoxide ^d tmux kill ^f find' \
		--bind 'tab:down,btab:up' \
		--bind 'ctrl-a:change-prompt(⚡  )+reload(sesh list)' \
		--bind 'ctrl-t:change-prompt(🪟  )+reload(sesh list -t)' \
		--bind 'ctrl-g:change-prompt(⚙️  )+reload(sesh list -c)' \
		--bind 'ctrl-x:change-prompt(📁  )+reload(sesh list -z)' \
		--bind 'ctrl-f:change-prompt(🔎  )+reload(fd -H -d 2 -t d -E .Trash . ~)' \
		--bind 'ctrl-d:execute(tmux kill-session -t {})+change-prompt(⚡  )+reload(sesh list)'
)\""
      bind T new-window -c "$HOME"
      bind r command-prompt "rename-window %%"
      bind R source-file ~/.config/tmux/tmux.conf
      bind ^A last-window
      bind ^W list-windows
      bind w list-windows
      bind z resize-pane -Z
      bind ^L refresh-client
      bind l refresh-client
      bind | split-window
      bind s split-window -v -c "#{pane_current_path}"
      bind v split-window -h -c "#{pane_current_path}"
      bind '"' choose-window
      
      bind -r -T prefix , resize-pane -L 20
      bind -r -T prefix . resize-pane -R 20
      bind -r -T prefix - resize-pane -D 7
      bind -r -T prefix = resize-pane -U 7
      bind : command-prompt
      bind * setw synchronize-panes
      bind P set pane-border-status
      bind c kill-pane
      bind x swap-pane -D
      bind S choose-session
      bind R source-file ~/.config/tmux/tmux.conf
      bind K send-keys "clear"\; send-keys "Enter"
      bind-key -T copy-mode-vi v send-keys -X begin-selection

      

      set -g prefix ^A
      set -g base-index 1              # start indexing windows at 1 instead of 0
      set -g detach-on-destroy off     # don't exit from tmux when closing a session
      set -g escape-time 0             # zero-out escape time delay
      set -g history-limit 1000000     # increase history size (from 2,000)
      set -g renumber-windows on       # renumber all windows when any window is closed
      set -g set-clipboard on          # use system clipboard
      set -g status-position top       # macOS / darwin style
      setw -g mode-keys vi

      set -g @fzf-url-fzf-options '-p 60%,30% --prompt="   " --border-label=" Open URL "'
      set -g @fzf-url-history-limit '2000'

      
      set -g @continuum-restore 'on'
      set -g @resurrect-strategy-nvim 'session'

      set-option -g default-terminal 'screen-256color'
      set-option -g terminal-overrides ',xterm-256color:RGB'
      set -g pane-active-border-style 'fg=magenta,bg=default'
      set -g pane-border-style 'fg=brightblack,bg=default'
      set -g @catppuccin_window_left_separator ""
      set -g @catppuccin_window_right_separator " "
      set -g @catppuccin_window_middle_separator " █"
      set -g @catppuccin_window_number_position "right"
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_default_text "#W"
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_current_text "#W#{?window_zoomed_flag,(),}"
      set -g @catppuccin_status_modules_right "directory date_time"
      set -g @catppuccin_status_modules_left "session"
      set -g @catppuccin_status_left_separator  " "
      set -g @catppuccin_status_right_separator " "
      set -g @catppuccin_status_right_separator_inverse "no"
      set -g @catppuccin_status_fill "icon"
      set -g @catppuccin_status_connect_separator "no"
      set -g @catppuccin_directory_text "#{b:pane_current_path}"
      set -g @catppuccin_date_time_text "%H:%M"
    '';
  };
}
