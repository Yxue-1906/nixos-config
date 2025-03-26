{ ... }: {
  # Try to fix keyboard no response issue when press any key after select boot entry before the probing
  # see: https://lore.kernel.org/lkml/20211112180022.10850-1-tiwai@suse.de/T/
  # see: https://wiki.archlinux.org/title/Kernel_parameters
  # see: https://nixos.wiki/wiki/Linux_kernel
  boot.kernelParams = [
    "i8082.probe_defer"
  ];
}
