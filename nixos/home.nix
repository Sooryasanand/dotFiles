{ pkgs, username, inputs, ... }:

let
  homeDirectory = "/home/${username}";
  myNeovimPlugins = with pkgs.vimPlugins; [
    lazy-nvim
    nvim-lspconfig
    nvim-treesitter
    nvim-cmp
    cmp-nvim-lsp
    cmp-buffer
    cmp-path
    cmp-cmdline
    luasnip
    mason-nvim
    mason-lspconfig-nvim
    nvim-tree-lua
    vim-fugitive
  ];
in {
  imports = [ inputs.polykey-cli.homeModules.default ];

  home.packages = with pkgs; [
    eza
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
    neovim
    bluez
    networkmanager
    fira
    starship
    python3
    git-lfs
    dbmate
    cacert
    btop
    nodejs_20
  ];

  # Set Wayland session variables
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
