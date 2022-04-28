# This expression is used to provide consistency for nixpkgs
# especially in CI

{}:
let
  nixpkgs = import ./pin { snapshot = "master_1"; };
  default = import ./default.nix { inherit nixpkgs; };
in
default
