{ config, lib, pkgs, ... }:

{
  # Yazi settings
  programs.yazi = {
    enable = true;
    plugins = {
      inherit (pkgs.yaziPlugins) mount;
      inherit (pkgs.yaziPlugins) wl-clipboard;
    };
    settings = {
      keymap = lib.importTOML ../../.config/yazi/keymap.toml;
    };
  };

  # Yazi change CWD shell wrapper
  # See: https://yazi-rs.github.io/docs/quick-start/
  programs.bash.interactiveShellInit = ''
    function y() {
	    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	    command yazi "$@" --cwd-file="$tmp"
	    IFS= read -r -d "" cwd < "$tmp"
	    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	    command rm -f -- "$tmp"
    }
  '';
}