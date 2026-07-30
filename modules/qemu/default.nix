{ ... }:

{
  # Expose the NixOS module cleanly via flake.nixosModules
  flake.nixosModules.qemuGuest = { config, lib, pkgs, ... }: {
    options.profiles.qemuGuest = {
      enable = lib.mkEnableOption "common QEMU VM guest configurations";
    };

    config = lib.mkIf config.profiles.qemuGuest.enable {
      # VirtIO kernel drivers for optimal storage and network performance
      boot.initrd.availableKernelModules = [
        "virtio_pci"
        "virtio_blk"
        "virtio_net"
        "virtio_scsi"
        "virtio_console"
        "9p"
        "9pnet_virtio"
      ];

      # Standard Grub bootloader configuration suited for QEMU drives
      boot.loader.grub = {
        enable = true;
        device = "nodev";
        efiSupport = lib.mkDefault true;
        efiInstallAsRemovable = lib.mkDefault true;
      };

      # QEMU guest agent for host-guest interaction
      services.qemuGuest.enable = true;

      # Serial console output (ttyS0) for terminal access
      boot.kernelParams = [ "console=ttyS0,115200n8" ];
    };
  };
}
