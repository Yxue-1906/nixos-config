{ ... }: {

  # Enable envfs, so that we can use /bin/... or /usr/bin/...
  services.envfs.enable = true;

  # Override default behaviors when close laptop lid
  services.logind = {
    lidSwitchDocked = "ignore";
    lidSwitchExternalPower = "lock";
  };

  # Setup logrorate
  services.journald.extraConfig = ''
    MaxRetentionSec=30day
  '';

  # Enable CUPS to print documents.
  services.printing.enable = true;
}
