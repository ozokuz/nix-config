{ lib, ... }:
{
  options = {
    custom.virtualization = {
      guiTools = lib.mkEnableOption "Enable GUI tools for virtualization";
      btrfsSubvolumes = lib.mkEnableOption "Use btrfs subvolumes for storage";
    };
  };
}