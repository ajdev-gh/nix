{ inputs, self, ... }:
{
  flake.nixosConfigurations.nixos-vm = inputs.nixpkgs.lib.nixosSystem {
    system = "x86_64-linux";
    specialArgs = { inherit inputs; };
    modules = [
      inputs.disko.nixosModules.disko
      self.diskoConfigurations.qemu-vm
      self.nixosModules.qemuGuest
      self.nixosModules.nixos-vm-config
    ];
  };
}
