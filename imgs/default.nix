{ pkgs }:

rec {
  awsutils = pkgs.callPackage ./awsutils { };

  flasksample = pkgs.callPackage ./flasksample { };

  helmsman-aws = pkgs.callPackage ./helmsman-aws { };

  magic-wormhole-mailbox = pkgs.callPackage ./magic-wormhole-mailbox { };

  nwi-pr-utils = pkgs.callPackage ./nwi-pr-utils { };

  pki-validator = pkgs.callPackage ./pki-validator { };
}
