with import ./pin { snapshot = "nixos-20-03_0"; };

mkShell {
  buildInputs = [
    bash
    jq
    skopeo
  ];
}
