{
  pkgs,
  host,
  ...
}:
let
  vars = import ../hosts/${host}/options.nix;
  inherit (vars)
    flakePath
    ;
in
{

  environment.systemPackages = with pkgs; [
    nixfmt
    nixd
    terminaltexteffects
    watchexec
    (pkgs.writeShellScriptBin "dev-mode" ''
      watchexec --restart --clear --ignore result nix flake check ${flakePath}
    '')

  ];

}
