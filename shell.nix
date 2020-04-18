with import ./pin { snapshot = "nixos-unstable_0"; };

mkShell {
  buildInputs = [
    skopeo
    jq
    bash
  ];
}
