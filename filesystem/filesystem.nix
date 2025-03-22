{ ... }: {
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

  # fix GH-23
  # see: https://storaged.org/doc/udisks2-api/latest/mount_options.html
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEMS=="usb", ENV{UDISKS_MOUNT_OPTIONS_DEFAULTS}+="sync"
  '';

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
