{ pkgs, ... }: {
  nixpkgs.overlays = [
    (final: prev: {
      file-roller = prev.file-roller.overrideAttrs (finalAttrs: prevAttrs: {
        patches = prevAttrs.patches ++ [
	  ./restore-extract-button-behavior.patch
	];
      });
    })
  ];
}
