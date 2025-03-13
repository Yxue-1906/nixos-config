{ ... }: 
let 
  default-options = [ "nosuid" "nodev" "nofail" "umask=000" "x-gvfs-show" ];
in
{
  # fileSystems."/mnt/工作" = {
  #   device = "/dev/disk/by-label/工作";
  #   fsType = "ntfs3";
  #   options = default-options;
  # };
  # fileSystems."/mnt/应用" = {
  #   device = "/dev/disk/by-label/应用";
  #   fsType = "ntfs3";
  #   options = default-options;
  # };
  # fileSystems."/mnt/娱乐" = {
  #   device = "/dev/disk/by-label/娱乐";
  #   fsType = "ntfs3";
  #   options = default-options;
  # };

  # Enable udisks, allow mount internal disks without authentication
  services.udisks2 = {
    enable = true;
    mountOnMedia = true;
  };
  security.polkit = {
    enable = true;
    # Allow user in group wheel mount drives without authentication
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        if ((action.id == "org.freedesktop.udisks2.filesystem-mount-system" ||
           action.id == "org.freedesktop.udisks2.filesystem-mount") &&
          subject.isInGroup("wheel")) {
          return polkit.Result.YES;
        }
      });
    '';
  };
}
