{ self, inputs, ... }: {
  flake.nixosModules.base = {
    nix = {
      settings = {
        experimental-features = [ "nix-command" "flakes" ];
        trusted-users = [ "root" "@wheel" ];
      };
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 7d";
      };
    };
    time.timeZone = "Asia/Kolkata";
    nixpkgs.config.allowUnfree = true;
  };
}
