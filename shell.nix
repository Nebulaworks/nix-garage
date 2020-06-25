with import ./pin { snapshot = "nixos-unstable_0"; };

mkShell {
  buildInputs = [
    bash
    jq
    skopeo
    nixpkgs-fmt
  ];
}
