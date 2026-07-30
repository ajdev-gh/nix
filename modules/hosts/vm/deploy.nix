{
  self,
  inputs,
  ...
}: {
  flake.deploy.nodes.nixos-vm = {
    hostname = "nixos-vm";
    sshUser = "ajirequi";
    fastConnection = true;
    profiles.system = {
      user = "root";
      path = inputs.deploy-rs.lib.x86_64-linux.activate.nixos self.nixosConfigurations.nixos-vm;
    };
  };
}
