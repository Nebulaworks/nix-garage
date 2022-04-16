with import ./pin { snapshot = "master_0"; };

mkShell {
  buildInputs = [
    nix
    bash
    jq
    skopeo
    nixpkgs-fmt
    curl
  ];
}
