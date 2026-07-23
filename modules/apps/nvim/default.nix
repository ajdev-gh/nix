{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.nvim = inputs.wrappers.wrappers.neovim.wrap({ config, ... }: {
      inherit pkgs;
      runtimePkgs = with pkgs; [
        ripgrep
        fd
        tree-sitter
        
        jdt-language-server
        lua-language-server
        basedpyright
        rust-analyzer
        nixd

        alejandra
      ];
      specs.general = with pkgs.vimPlugins; [
        mini-nvim
        which-key-nvim
        render-markdown-nvim
        nvim-treesitter
        friendly-snippets
        nvim-lspconfig
      ];
      specs.mini-pick-preview = config.nvim-lib.mkPlugin "mini-pick-preview"
      inputs.mini-pick-preview;
      env = {
        "CONFIG_ROOT" = ./.;
        "NVIM_APPNAME" = "nixvim";
      };
      settings.config_directory = ./.;
    });
  };
}
