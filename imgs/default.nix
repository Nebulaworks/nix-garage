{ pkgs }:

rec {
  ansible-lint = pkgs.callPackage ./ansible-lint { };

  awsutils = pkgs.callPackage ./awsutils { };

  flasksample = pkgs.callPackage ./flasksample { };

  helmsman-aws = pkgs.callPackage ./helmsman-aws { };

  magic-wormhole-mailbox = pkgs.callPackage ./magic-wormhole-mailbox { };

  nwi-pr-utils = pkgs.callPackage ./nwi-pr-utils { };

  pki-validator = pkgs.callPackage ./pki-validator { };

  term-apply = pkgs.callPackage ./term-apply { };
}
