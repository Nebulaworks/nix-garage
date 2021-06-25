with import ./pin { snapshot = "release-21.05_0"; };

mkShell {
  buildInputs = [
    bash
    jq
    skopeo
    nixpkgs-fmt
    curl
  ];
}
