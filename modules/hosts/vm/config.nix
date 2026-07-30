{self, inputs, ... }: {
  flake.nixosModules.nixos-vm-config = { pkgs, ... }: {
    # Enable the profile
    profiles.qemuGuest.enable = true;

    networking.hostName = "nixos-vm";
    networking.useDHCP = true;

    services.openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "prohibit-password";
        PasswordAuthentication = false;
      };
    };

    security.sudo.wheelNeedsPassword = false;

    users.users.root = {
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILXcI7ftmBn6N33Au3JMYJQOC8NJGfvRKP69Nk+vwTk8 ajirequi@metis"
      ];
    };

    users.users.ajirequi = {
      description = "Ajai Dev";
      isNormalUser = true;
      extraGroups = ["wheel"];
      hashedPassword = "$6$cpCIfBSvpZcfrOx9$7hXVTLYjewnXCv4y6LjFXOKd8BnWyDBCU1o/KHsnW/6Ll.Nrq2MMIa0Yv7ni77couVklPuI/pCqUKzFw30lE11";
      openssh.authorizedKeys.keys = [
        "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILXcI7ftmBn6N33Au3JMYJQOC8NJGfvRKP69Nk+vwTk8 ajirequi@metis"
      ];
      packages = with pkgs;[
        tree
      ];
    };

    system.stateVersion = "26.05";
  };
}
