{ pkgs, lib, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      file-roller = prev.file-roller.overrideAttrs (finalAttrs: prevAttrs: {
        mesonFlags = [
	  (lib.mesonEnable "libarchive" false)
	];
        patches = (prevAttrs.patches or []) ++ [
	  ./restore-extract-button-behavior.patch
	];
      });
    })
  ];
}
