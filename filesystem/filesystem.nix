{ ... }: 
let 
  default-options = [ "nosuid" "nodev" "nofail" "x-gvfs-show" ];
in
{
  fileSystems."/mnt/工作" = {
    device = "/dev/disk/by-label/工作";
    fsType = "ntfs3";
    options = default-options;
  };
  fileSystems."/mnt/应用" = {
    device = "/dev/disk/by-label/应用";
    fsType = "ntfs3";
    options = default-options;
  };
  fileSystems."/mnt/娱乐" = {
    device = "/dev/disk/by-label/娱乐";
    fsType = "ntfs3";
    options = default-options;
  };
}
