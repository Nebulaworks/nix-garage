# This expression is used to produce the release
# For normal usage, please refer to `default.nix` instead.

{}:
let
  nixpkgs = import ./pin { snapshot = "master_0"; };
  default = import ./default.nix { inherit nixpkgs; };
in
default
