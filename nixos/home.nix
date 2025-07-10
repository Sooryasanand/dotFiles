{ pkgs, system, username, inputs, ... }:

let
  homeDirectory = "/home/${username}";
  isAarch64 = system == "aarch64-linux";

  # Example: Only enable certain packages on x86_64
  maybeVesktop = if isAarch64 then null else pkgs.vesktop;
  maybeNeovide = if isAarch64 then null else pkgs.neovide;
  maybeOpenrazer = if isAarch64 then null else pkgs.openrazer-daemon;
  maybeDbeaverBin = if isAarch64 then null else pkgs.dbeaver-bin;
  maybeBrave = if isAarch64 then null else pkgs.brave;
in {
  imports = [ inputs.polykey-cli.homeModules.default ];

  home.packages = builtins.filter (x: x != null) (with pkgs; [
    thunderbird
    eza
    pavucontrol
    neofetch
    stylua
    nixfmt-classic
    emmet-language-server
    typescript-language-server
    vscode-langservers-extracted
    nodePackages.prettier
    lua-language-server
    emacsPackages.deno-fmt
    nil
    biome
    ripgrep
    fd
    gcc
    zig
    maybeNeovide
    neovim
    gvfs
    libnotify
    blueman
    bluez
    networkmanager
    brightnessctl
    maybeOpenrazer
    ffmpeg
    maybeDbeaverBin
    fira
    starship
    vscode
    python3
    albert
    git-lfs
    postman
    dbmate
    cacert
    btop
    maybeVesktop
    maybeBrave
    kitty
    bitwarden
    spotify
    nodejs_20
    gnome-tweaks
  ]);

  home.sessionVariables = {
    NODE_EXTRA_CA_CERTS = "${pkgs.cacert}/etc/ssl/certs/ca-bundle.crt";
  };

  home = {
    inherit username homeDirectory;
    stateVersion = "23.11";
  };

  programs = {
    polykey = {
      enable = true;
      passwordFilePath = "%h/.polykeypass";
      recoveryCodeOutPath = "%h/.polykeyrecovery";
    };

    home-manager.enable = true;
  };
}

