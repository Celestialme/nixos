{hardware, options,config,pkgs, modulesPath, lib, ... }: {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-graphical-plasma5.nix"
   "${modulesPath}/hardware/video/nvidia.nix"
  ];
 
hardware.nvidia.nvidiaSettings = true;
 
  services.xserver.videoDrivers = [ "nvidia" ];
  nixpkgs.config.allowUnfree = true;
  hardware.nvidia.modesetting.enable = true;
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.legacy_340;
  
  # use the latest Linux kernel
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_5_4;

  # Needed for https://github.com/NixOS/nixpkgs/issues/58959
  boot.supportedFilesystems = lib.mkForce [ "btrfs" "reiserfs" "vfat" "f2fs" "xfs" "ntfs" "cifs" ];
}