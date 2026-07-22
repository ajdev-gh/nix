{ self, inputs, ... }: {
  perSystem = { pkgs, ... }: {
    packages.nvim = inputs.wrappers.wrappers.neovim.wrap {
      inherit pkgs;
      env = {
        "CONFIG_ROOT" = ./.;
        "NVIM_APPNAME" = "nixvim";
      };
      runtimePkgs = with pkgs; [
        hello
      ];
      settings.config_directory = ./.;
    };
  };
}
