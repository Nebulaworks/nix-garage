{ pkgs }:

rec {
  awsutils = pkgs.callPackage ./awsutils {
    pkgs = import ../pin { snapshot = "nixos-20-03_0"; };
  };

  helmsman-aws = pkgs.callPackage ./helmsman-aws {
    pkgs = import ../pin { snapshot = "nixpkgs-unstable_0"; };
  };

  magic-wormhole-mailbox = pkgs.callPackage ./magic-wormhole-mailbox {
    pkgs = import ../pin { snapshot = "nixos-20-03_0"; };
  };

  pki-validator = pkgs.callPackage ./pki-validator {
    pkgs = import ../pin { snapshot = "nixos-20-03_0"; };
  };
}
